# Technical Plan — raat-ki-aakhri-sawari

## 1. Project Structure

```
raat-ki-aakhri-sawari/
├── .github/
│   └── workflows/
│       └── android-apk.yml
├── assets/
│   ├── audio/
│   ├── images/
│   ├── models/
│   └── textures/
├── docs/
│   ├── GAME_DESIGN_DOCUMENT.md
│   ├── TECHNICAL_PLAN.md
│   ├── ANOMALY_CATALOG.md
│   ├── DEVELOPMENT_RULES.md
│   ├── ROADMAP.md
│   ├── TESTING_CHECKLIST.md
│   └── DECISIONS.md
├── scenes/
│   ├── main.tscn
│   ├── menu/
│   ├── gameplay/
│   └── anomalies/
├── scripts/
│   ├── player/
│   ├── vehicle/
│   ├── anomalies/
│   ├── ui/
│   └── managers/
├── export_templates/
├── icon.svg
└── project.godot
```

## 2. Engine & Tools

| Component      | Specification                                      |
|----------------|-----------------------------------------------------|
| Game Engine    | Godot 4.x (latest stable)                           |
| Programming    | GDScript (primary), C# (optional)                   |
| Version Control| Git + GitHub                                        |
| CI/CD          | GitHub Actions (android-apk.yml)                    |
| Asset Pipeline | Godot's built-in import + custom scripts if needed  |
| Target SDK     | Android API 26+ (Android 8.0)                       |
| Export Target  | Android APK (debug + release builds)                |

## 3. Architecture Overview

### 3.1 Scene Organization

The game is organized into a hierarchy of scenes:

- **Main Scene** (`scenes/main.tscn`) — Root scene that manages transitions between menu, gameplay, and pause states.
- **Menu Scene** (`scenes/menu/`) — Main menu, settings, controls configuration.
- **Gameplay Scene** (`scenes/gameplay/`) — Core game loop, player controller, environment.
- **Anomaly Scenes** (`scenes/anomalies/`) — Reusable anomaly entity templates.

### 3.2 Script Modules

| Module          | Responsibility                                           |
|----------------|----------------------------------------------------------|
| `player/`      | Player movement, health, inventory, sanity management.   |
| `vehicle/`     | Vehicle physics, fuel consumption, damage system.        |
| `anomalies/`   | Entity behaviors, patrol routes, trigger conditions.     |
| `ui/`          | HUD rendering, menus, dialog system, inventory UI.       |
| `managers/`    | GameManager, AudioManager, SaveManager, SceneManager.    |

### 3.3 Manager Pattern

```
GameManager (singleton)
├── AudioManager (singleton)
├── SaveManager (singleton)
├── SceneManager (singleton)
└── ResourceManager (singleton)
```

## 4. Godot Export Pipeline

### 4.1 Android Export Configuration

- **Renderer**: Vulkan (preferred) with OpenGL fallback.
- **Architecture**: ARM64_V8A (primary), ARM_V7 (fallback).
- **Keystore**: Debug keystore for CI builds; release keystore managed securely.
- **Splash Screen**: Custom splash with game logo.

### 4.2 Gradle Configuration

Custom `Android/build.gradle` modifications:
- Minimum SDK: 26
- Target SDK: 34
- Compile SDK: 34
- Memory allocation: Increased heap for low-end devices.

## 5. Performance Targets

| Metric              | Target                     |
|---------------------|----------------------------|
| Frame Rate | 30 FPS minimum, 60 FPS target |
| Texture Budget | 2 GB total VRAM |
| Initial Load Time | Under 10 seconds on mid-range device |
| APK Size | Under 150 MB (base APK + OBB) |

## 6. Build & Deployment

### 6.1 CI (GitHub Actions)

- Triggered on push to `main` and on pull requests.
- Downloads Godot 4 headless binary.
- Validates project.godot existence.
- Exports debug APK.
- Uploads APK as artifact.

### 6.2 Local Development

```bash
# Run in editor
godot --editor

# Export debug APK locally
godot --headless --export-debug "Android"
```

## 7. Known Technical Risks

| Risk                        | Mitigation                                     |
|-----------------------------|------------------------------------------------|
| Godot Android build issues | Maintain local Godot build as fallback. |
| Large APK size | Use split APKs + OBB for assets. |
| Low-end device performance | LOD system + aggressive optimization phase. |
| Android permission changes | Target Android 13+ permissions model. |

---

*This document will be updated as technical decisions are made. See `docs/DECISIONS.md` for a log of key choices.*
