#!/data/data/com.termux/files/usr/bin/bash
set -euo pipefail
REPO="${1:-}"
if [ -z "$REPO" ]; then
  echo "Usage: bash termux/build-install.sh OWNER/REPOSITORY"
  echo "Example: bash termux/build-install.sh sowkath6/COD-GHOST-AI-V8"
  exit 2
fi
command -v gh >/dev/null 2>&1 || { echo "Install GitHub CLI first: pkg install gh"; exit 1; }
gh auth status >/dev/null 2>&1 || { echo "Sign in first: gh auth login"; exit 1; }
echo "Starting the Android APK build on GitHub Actions..."
gh workflow run build-apk.yml -R "$REPO" --ref main
sleep 4
RUN_ID="$(gh run list -R "$REPO" --workflow build-apk.yml --limit 1 --json databaseId --jq '.[0].databaseId')"
if [ -z "$RUN_ID" ] || [ "$RUN_ID" = "null" ]; then echo "Could not find the workflow run. Check GitHub Actions."; exit 1; fi
echo "Waiting for build run $RUN_ID..."
gh run watch "$RUN_ID" -R "$REPO" --exit-status
echo "Downloading APK artifact..."
mkdir -p "$HOME/ghost-ai-apk"
gh run download "$RUN_ID" -R "$REPO" -n COD-GHOST-AI-V8.1-debug -D "$HOME/ghost-ai-apk"
APK="$HOME/ghost-ai-apk/app-debug.apk"
[ -f "$APK" ] || APK="$(find "$HOME/ghost-ai-apk" -name '*.apk' -type f | head -n 1)"
[ -n "$APK" ] && [ -f "$APK" ] || { echo "APK not found in downloaded artifact."; exit 1; }
echo "APK ready: $APK"
termux-open "$APK" || echo "Open the APK in your file manager and approve Android's install prompt."
