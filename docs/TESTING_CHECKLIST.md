# Testing checklist

## Build
- [ ] CI workflow runs from a clean checkout.
- [ ] Godot version and Android export templates are pinned/documented.
- [ ] Android debug APK artifact exists and can be downloaded.

## Gameplay
- [ ] Start, pause, resume, and quit work.
- [ ] First-person movement and look work on touch controls.
- [ ] The player can inspect the sleeper coach and use both exits.
- [ ] Normal coach selects front exit; anomaly selects rear exit.
- [ ] Wrong exit returns the player to S-8.
- [ ] Five anomalies are distinguishable and fair.

## Device and performance
- [ ] UI is readable in landscape orientation.
- [ ] Test on at least one physical Android device.
- [ ] Record FPS, memory use, device model, and crash logs.
- [ ] Verify no missing assets or black/pink materials.

## Release readiness
- [ ] All assets have documented rights and licenses.
- [ ] Working title and store metadata checked for conflicts.
- [ ] No secrets or signing keys are committed.
