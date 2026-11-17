# COD GHOST AI V8.1 — Tactical Companion

Independent Android companion project for COD Mobile Global. Adds Shizuku connection/permission status and a Termux helper that triggers the GitHub Actions Android build, downloads the APK artifact, and opens Android's installer.

## Features
- Neon tactical companion interface, demo-only local entry, optional speech recognition.
- COD Mobile Global launcher (`com.activision.callofduty.shooter`).
- Android battery, battery temperature, available RAM, CPU core count and network transport diagnostics.
- Local MP/BR sensitivity notes and standalone reaction timer.
- Shizuku API integration to check service availability and request this app's Shizuku permission. This release does not execute shell commands or change game/system settings.
- GitHub Actions build workflow (JDK 17, Android SDK 36, Gradle 8.13).
- `termux/build-install.sh` triggers the cloud build, downloads the APK artifact and opens the installer.

## Build and install from Termux
1. Create a NEW GitHub repository and upload the contents of this project to its `main` branch.
2. In Termux:
   ```sh
   pkg update -y && pkg install -y gh
   gh auth login
   ```
3. Run:
   ```sh
   bash termux/build-install.sh YOUR_GITHUB_NAME/COD-GHOST-AI-V8
   ```
4. Android opens the APK installer. Review and approve installation. If blocked, allow installs for the app that opened the APK and retry.

The Android compilation runs on GitHub Actions, not locally inside Termux. Termux triggers the build, downloads the artifact and launches the installer; this avoids a large, fragile Android SDK installation on the phone.

## Shizuku setup
1. Install and start Shizuku using its official instructions.
2. Open COD GHOST AI > Settings > Check Shizuku.
3. Tap Request Permission and approve the prompt in Shizuku.
4. Check status again.

Wireless debugging pairing/restart is handled in the Shizuku app. This companion only checks Shizuku connectivity and permission in this release.

## Limitations
- Login is demo-only; do not enter a CODM password. Real authentication requires a secure backend.
- Device diagnostics are Android readings, not CODM's internal FPS or server ping.
- No game injection, memory editing, aimbot, ESP/wallhack, recoil automation, paid currency unlocks, anti-cheat bypass, or account modification.
- Shizuku is not root and does not grant unrestricted access.

## Local account login (V8.1 update)

The login screen supports creating one local account on the current Android installation. Choose a username (3–24 letters/numbers/dot/dash/underscore) and a password of at least 8 characters, then confirm it. The app stores a random salt and PBKDF2-HMAC-SHA256 password hash (150,000 iterations), not the plaintext password. This is device-local authentication only: it does not create a cloud account, sync across devices, or provide password recovery. Clearing app data or uninstalling may remove the local account. Do not use your COD Mobile password. For multi-device accounts and recovery, integrate a proper backend such as Supabase Auth.


## V8.2 cinematic launch screen

This update adds a 4.4-second HTML/CSS launch sequence using the supplied helmet artwork, animated cyan/violet HUD rings, a scan sweep, logo reveal, brand reveal, progress line, and a Skip Intro control. The sequence fades into the existing local-login screen. Android launcher icons remain static; the animated sequence runs when the app opens. The splash works offline and does not need permissions.

Build artifact: `COD-GHOST-AI-V8.2-debug`.
