# raat-ki-aakhri-sawari (The Last Ride of the Night)

An Android horror game built with Godot 4.

## Description

This project is a horror-themed Android game built using the Godot 4 engine. The title "raat-ki-aakhri-sawari" translates to "The Last Ride of the Night," reflecting the game's dark, atmospheric narrative and eerie setting.

## Current Status

This repository has received its first playable prototype scaffold.

- First playable prototype added (Godot 4.3 project, scene, and scripts).
- APK build has NOT yet been verified by GitHub Actions.
- The game is a low-cost 3D first-person horror prototype set in a dim sleeper train coach.

## Project Structure

- `project.godot` — Godot 4.3 project configuration
- `export_presets.cfg` — Export presets including Android debug APK (arm64-v8a)
- `scenes/main.tscn` — Sleeper coach scene with primitives (berths, lights, fans, exits, HUD)
- `scripts/main.gd` — First-person controls, exit logic, anomaly toggle, HUD

## Gameplay

- First-person movement with WASD/mouse-look and mobile touchscreen joystick/buttons.
- Dim sleeper coach made from primitives: floor, walls, blue triple berths, door frames, ceiling lights, fan placeholders.
- Two interactable exit areas: FRONT and REAR.
- Rules: normal mode → FRONT; anomaly mode → REAR; wrong exit → respawn at S-8.
- Anomaly toggle demo button included.
- HUD displays title, time (02:15 AM), and inspect hint.

## Building

1. Open this project in Godot 4.3+.
2. Click **Project → Export → Android** to export a debug APK.
3. Or use the CI workflow at `.github/workflows/android-apk.yml` to build via GitHub Actions.

## License

[Add license here]
