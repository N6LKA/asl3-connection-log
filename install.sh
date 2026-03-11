#!/bin/bash
# install.sh - Installer for asl3-connection-log
# https://github.com/N6LKA/asl3-connection-log

set -e

SCRIPT_DIR=/etc/asterisk/scripts
LOGFILE=/var/log/asterisk/connectlog
OWNER=asterisk:asterisk

echo "=== ASL3 Connection Log Installer ==="

# Check for root
if [[ $EUID -ne 0 ]]; then
  echo "ERROR: This script must be run as root (use sudo)."
  exit 1
fi

# Create scripts directory if it doesn't exist
if [ ! -d "$SCRIPT_DIR" ]; then
  echo "Creating $SCRIPT_DIR..."
  mkdir -p "$SCRIPT_DIR"
else
  echo "$SCRIPT_DIR already exists, skipping."
fi

# Copy scripts
echo "Installing conlog.sh and dislog.sh to $SCRIPT_DIR..."
cp conlog.sh "$SCRIPT_DIR/conlog.sh"
cp dislog.sh "$SCRIPT_DIR/dislog.sh"

# Set execute permissions
chmod +x "$SCRIPT_DIR/conlog.sh"
chmod +x "$SCRIPT_DIR/dislog.sh"
echo "Permissions set."

# Create log file if it doesn't exist
if [ ! -f "$LOGFILE" ]; then
  echo "Creating log file at $LOGFILE..."
  touch "$LOGFILE"
else
  echo "Log file already exists, skipping."
fi

# Set ownership
chown "$OWNER" "$LOGFILE"
echo "Ownership of $LOGFILE set to $OWNER."

echo ""
echo "=== Installation complete! ==="
echo ""
echo "Next step: Edit /etc/asterisk/rpt.conf and add the following to your node stanza:"
echo ""
echo "  connpgm = $SCRIPT_DIR/conlog.sh"
echo "  discpgm = $SCRIPT_DIR/dislog.sh"
echo ""
echo "Then restart Asterisk:"
echo "  sudo systemctl restart asterisk"
echo ""
