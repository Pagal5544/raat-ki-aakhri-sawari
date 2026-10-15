# Anomaly Catalog — raat-ki-aakhri-sawari

## Introduction

This catalog documents all paranormal entities, environmental phenomena, and supernatural occurrences within the game world. Each anomaly has defined behaviors, trigger conditions, and player interaction rules.

---

## Anomaly List

### 1. The Whispering Passenger

| Property         | Detail                                              |
|-----------------|-----------------------------------------------------|
| Class           | Entity — Humanoid (apparent)                         |
| Threat Level    | Medium                                               |
| Trigger          | Player sits in the driver's seat after midnight      |
| Behavior        | Sits in the passenger seat; whispers clues and threats |
| Audio Cue       | Soft Hindi whispers, overlapping voices              |
| Avoidance       | Keep windows rolled up; use radio to mask sound      |
| Effect on Sanity| Slow drain (-2/min while present)                    |
| Discovery Hint  | Rearview mirror shows empty seat when not looking    |

### 2. Roadside Dancer

| Property         | Detail                                              |
|-----------------|-----------------------------------------------------|
| Class           | Entity — Animated                                    |
| Threat Level    | High                                                 |
| Trigger          | Driving past specific highway markers (km 47–53)     |
| Behavior        | Dances on the roadside; when the player looks away, moves closer to the road |
| Audio Cue       | Traditional dholak beat, out of rhythm               |
| Avoidance       | Keep headlights on full beam; do not stop            |
| Effect on Sanity| Sudden -15 on first sighting                         |
| Discovery Hint  | Dholak sound gets louder as you approach             |

### 3. Static Rider

| Property         | Detail                                              |
|-----------------|-----------------------------------------------------|
| Class           | Entity — Energy-based                                |
| Threat Level    | Medium                                               |
| Trigger          | Flashlight exposed to dark corridors for 30+ seconds |
| Behavior        | Appears as a shimmering figure; causes electrical interference |
| Audio Cue       | Radio static, TV white noise                         |
| Avoidance       | Turn off flashlight; use emergency lamp (blue light)|
| Effect on Sanity| -5 per exposure tick                                 |
| Discovery Hint  | Electrical devices flicker before appearance         |

### 4. The Toll Collector

| Property         | Detail                                              |
|-----------------|-----------------------------------------------------|
| Class           | Entity — Humanoid                                    |
| Threat Level    | Medium (puzzle-based)                                |
| Trigger          | Approaching the abandoned toll plaza                 |
| Behavior        | Demands toll; gives wrong directions; can be outsmarted with correct items |
| Audio Cue       | Coin clinking, mumbled speech                        |
| Avoidance       | Present correct toll items (see Inventory system)    |
| Effect on Sanity| -10 if demands are not met; +5 if correctly paid     |
| Discovery Hint  | Toll booth appears on map only after Act 2           |

### 5. Mirror Doppelgänger

| Property         | Detail                                              |
|-----------------|-----------------------------------------------------|
| Class           | Entity — Shapeshifter                                |
| Threat Level    | Critical                                             |
| Trigger          | Any reflective surface (window, puddle, mirror)      |
| Behavior        | Imitates player movement with a 3-second delay; when the delay ends, it lunges |
| Audio Cue       | Heartbeat that matches player's breathing            |
| Avoidance       | Destroy reflective objects; wear visor               |
| Effect on Sanity| -20 on appearance, -10 per encounter                 |
| Discovery Hint  | Player's breath fogs mirrors even when hot           |

### 6. Highway Phantom Car

| Property         | Detail                                              |
|-----------------|-----------------------------------------------------|
| Class           | Environmental — Vehicle anomaly                      |
| Threat Level    | Medium                                               |
| Trigger          | Driving on the highway at night (random spawn)       |
| Behavior        | An old Ambassador car appears and disappears; headlights flash in Morse code |
| Audio Cue       | Distant horn, engine sputtering                      |
| Avoidance       | Do not follow; it leads to dead ends                 |
| Effect on Sanity| -3 per minute of pursuit                             |
| Discovery Hint  | Radio picks up emergency broadcast when near         |

### 7. The Ferryman

| Property         | Detail                                              |
|-----------------|-----------------------------------------------------|
| Class           | Entity — Guardian / Quest NPC                        |
| Threat Level    | Low (informational)                                  |
| Trigger          | Reaching the river crossing checkpoint               |
| Behavior        | Appears as a hooded figure on a boat; provides lore and key items |
| Audio Cue       | Water lapping, distant chanting                      |
| Avoidance       | Interact peacefully to receive reward                |
| Effect on Sanity| +10 (comforting presence)                            |
| Discovery Hint  | Appears only during full moon in-game event          |

---

## Anomaly Behavior Categories

| Category     | Description                                                  |
|-------------|--------------------------------------------------------------|
| Passive     | Does not directly harm the player but affects sanity.        |
| Active      | Chases or attacks the player when triggered.                 |
| Environmental| Changes the game world (lights, sounds, paths).             |
| Puzzle      | Requires player action to resolve; offers rewards.           |
| Guardian    | Neutral or helpful entities that provide information.        |

## Implementation Notes

- All anomalies must have a clear audio and visual cue system.
- Anomaly behavior trees should be reusable via scene instantiation.
- Sanity effects must be balanced to avoid early game frustration.
- Each anomaly must be documented in `docs/TESTING_CHECKLIST.md` for QA.

---

*This catalog is a living document. Add new anomalies as they are designed.*
