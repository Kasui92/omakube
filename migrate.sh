#!/bin/bash
# Migrate from Omakub to Omakube

set -e

OMAKUB_REPO="${OMAKUB_REPO:-Kasui92/omakube}"
OMAKUB_REF="${OMAKUB_REF:-main}"

OMAKUB_PATH="$HOME/.local/share/omakub"
BACKUP_DIR="$HOME/.local/share/omakub-backup-$(date +%Y%m%d_%H%M%S)"
STATE_DIR="$HOME/.local/state/omakub"
LOG_FILE="$HOME/.local/state/omakub/migration-errors-$(date +%Y%m%d_%H%M%S).log"

# Trap for cleanup on error or interruption
trap 'echo ""; echo "Migration interrupted. Backup available at: $BACKUP_DIR"; exit 1' INT TERM

# Check Omakub installation
if [[ ! -d "$OMAKUB_PATH" ]]; then
    echo "Error: Omakub not found in $OMAKUB_PATH"
    exit 1
fi

# Activate sudo early to avoid password prompts later
echo "Requesting sudo access..."
sudo -v || { echo "Sudo access required"; exit 1; }

# Create log directory
mkdir -p "$(dirname "$LOG_FILE")"

# Check for gum
if ! command -v gum &>/dev/null; then
    cd /tmp
    wget -q -O gum.deb "https://github.com/charmbracelet/gum/releases/download/v0.17.0/gum_0.17.0_amd64.deb"
    sudo apt-get install -y --allow-downgrades ./gum.deb >/dev/null 2>&1
    rm gum.deb
    cd - >/dev/null
fi

[[ -f "$OMAKUB_PATH/version" ]] && gum style --foreground 214 "Current: $(cat "$OMAKUB_PATH/version")"
gum style --foreground 212 "Migrating to Omakube from: $OMAKUB_REPO ($OMAKUB_REF)"
gum confirm "Continue?" || exit 0

# Backup
gum spin --spinner dot --title "Creating backup..." -- \
    sh -c "mkdir -p '$BACKUP_DIR' && cp -r '$OMAKUB_PATH' '$BACKUP_DIR/omakub'" || {
    echo "Backup failed"
    exit 1
}

# Clone
gum spin --spinner dot --title "Downloading Omakube..." -- \
    sh -c "rm -rf '$OMAKUB_PATH' && git clone -q https://github.com/$OMAKUB_REPO.git '$OMAKUB_PATH'" || {
    echo "Clone failed, restoring backup..."
    cp -r "$BACKUP_DIR/omakub" "$OMAKUB_PATH"
    exit 1
}

# Checkout branch
if [[ -n "$OMAKUB_REF" ]]; then
    cd "$OMAKUB_PATH"
    git fetch -q origin "$OMAKUB_REF" && git checkout -q "$OMAKUB_REF" 2>/dev/null || true
    cd - >/dev/null
fi

export PATH="$OMAKUB_PATH/bin:$PATH"
[[ -d "$OMAKUB_PATH/bin" ]] && chmod +x "$OMAKUB_PATH/bin"/*

# Run migrations
MIGRATIONS_STATE_DIR="$STATE_DIR/migrations"
mkdir -p "$MIGRATIONS_STATE_DIR" "$MIGRATIONS_STATE_DIR/skipped"

migration_count=0
failed_migrations=()

# Export INTERACTIVE_MODE before starting migrations
export INTERACTIVE_MODE=false

# Disable set -e for migrations to prevent early exit
set +e

for migration_file in "$OMAKUB_PATH/migrations"/*.sh; do
    [[ ! -f "$migration_file" ]] && continue

    migration_name=$(basename "$migration_file")
    migration_id="${migration_name%.sh}"

    ( [[ -f "$MIGRATIONS_STATE_DIR/$migration_name" ]] || [[ -f "$MIGRATIONS_STATE_DIR/skipped/$migration_name" ]] ) && continue

    # Capture migration output
    migration_output=$(mktemp)

    gum style --foreground 212 "→ Migration $migration_id"
    if bash "$migration_file" >"$migration_output" 2>&1; then
        gum style --foreground 82 "✓ Migration $migration_id"
        touch "$MIGRATIONS_STATE_DIR/$migration_name"
        ((migration_count++))
        rm -f "$migration_output"
    else
        exit_code=$?
        gum style --foreground 196 "✗ Migration $migration_id failed (exit code: $exit_code)"

        # Log error details
        {
            echo "=== Migration $migration_id failed at $(date) ==="
            echo "Exit code: $exit_code"
            echo "Output:"
            cat "$migration_output"
            echo ""
        } >> "$LOG_FILE"

        # Show last 10 lines of error output
        if [[ -s "$migration_output" ]]; then
            gum style --foreground 240 "Last output:"
            tail -10 "$migration_output" | sed 's/^/  /'
        fi
        rm -f "$migration_output"

        failed_migrations+=("$migration_id")

        if gum confirm "Skip and continue?"; then
            touch "$MIGRATIONS_STATE_DIR/skipped/$migration_name"
        else
            gum style --foreground 196 "Migration aborted"
            gum style --foreground 240 "Backup: $BACKUP_DIR"
            gum style --foreground 240 "Error log: $LOG_FILE"
            exit 1
        fi
    fi
done

# Re-enable set -e after migrations
set -e

# Update PATH
if ! grep -q "/.local/share/omakub/bin" "$HOME/.bashrc" 2>/dev/null; then
    echo '' >> "$HOME/.bashrc"
    echo '# Omakub binaries' >> "$HOME/.bashrc"
    echo 'export PATH="$HOME/.local/share/omakub/bin:$PATH"' >> "$HOME/.bashrc"
fi

echo ""
gum style --bold --foreground 212 "✓ Migration complete ($migration_count updates)"

# Show failed migrations if any
if [[ ${#failed_migrations[@]} -gt 0 ]]; then
    gum style --foreground 214 "⚠ Skipped migrations: ${failed_migrations[*]}"
    gum style --foreground 240 "Error log: $LOG_FILE"
fi

# Warning on x11 sessions to use Wayland instead
if [ "$XDG_SESSION_TYPE" = "x11" ]; then
  echo -e "\e[33m\nWarning: You are currently using an X11 session. It is recommended to switch to a Wayland session for the best experience with Omakub.\e[0m"
  echo -e "\e[33mYou can select the Wayland session at the login screen by clicking on the gear icon and choosing 'Ubuntu (Wayland)'.\e[0m"
  echo
fi

[[ "$XDG_CURRENT_DESKTOP" == *"GNOME"* ]] && gum confirm "Restart now?" && sudo reboot now

