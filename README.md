# PARK KARO 🚗

**Park Karo** is a complete, polished, production-ready casual 2D parking puzzle mobile game built using Flutter 3.41.6 and Dart 3.11.4.

The core gameplay centers around moving surrounding vehicles strategically in a 6x6 parking lot to clear a path and guide the target red sports car to the exit slot.

---

## 🌟 Features

- **100 Playable & Solvable Levels**: Divided into 5 difficulty worlds:
  - World 1: Beginner (Levels 1–20)
  - World 2: Easy (Levels 21–40)
  - World 3: Medium (Levels 41–60)
  - World 4: Hard (Levels 61–80)
  - World 5: Expert (Levels 81–100)
- **Dynamic BFS Solver Engine**: Calculates exact optimal par moves and provides guaranteed step-by-step real-time hints.
- **Move Counter & Star Scoring System**: Awards 1, 2, or 3 stars depending on performance relative to par.
- **Undo & Reset System**: Move history stack for instant undoing and level resetting.
- **Garage Shop & Skins**: Custom vehicle skins (Red Racer, Cyber Neon, Police Cruiser, City Taxi, Golden VIP, Stealth Jet) and board themes.
- **7-Day Daily Reward Streak**: Local persistent login rewards with escalating coin payouts.
- **Date-Seeded Daily Challenge**: Deterministic daily puzzle mode.
- **Achievements System**: 6+ claimable achievements with coin rewards.
- **Audio & Haptic System**: Comprehensive sound effects, music toggles, and tactile haptic feedback.
- **Offline First**: Works 100% offline with local persistence via shared_preferences.

---

## 📁 Architecture & Folder Structure

`
lib/
├── core/
│   ├── audio/           # Sound & music player manager
│   ├── haptics/         # Haptic feedback controller
│   ├── storage/         # Local persistence repository
│   ├── services/        # AdService, AnalyticsService, CrashReporting abstractions
│   └── theme/           # Palette, fonts, dark visual theme
├── features/
│   ├── game/            # Domain models, MovementValidator, BFSSolver, GameCubit, UI
│   ├── levels/          # 100 levels dataset & level repository
│   ├── home/            # Home menu screen & animated banners
│   ├── shop/            # Vehicle skins & themes shop cubit and screens
│   ├── achievements/    # Trophy tracker & rewards
│   ├── daily_reward/    # 7-day streak calendar dialog
│   ├── daily_challenge/ # Date-based puzzle mode
│   ├── statistics/      # Stats dashboard
│   └── settings/        # Sound/Music/Haptics toggles & Progress Reset
└── shared/              # Reusable widgets & star ratings
`

---

## 🛠️ How to Create & Add New Levels

Levels are data-driven data structures. To add a new level, define a LevelDefinition in lib/features/levels/data/levels_data.dart:

`dart
LevelDefinition(
  id: 101,
  worldId: 5,
  title: 'Level 101',
  difficulty: 'Expert',
  parMoves: 8,
  vehicles: [
    Vehicle(
      id: 'target',
      position: Position(2, 0),
      orientation: VehicleOrientation.horizontal,
      length: 2,
      type: VehicleType.target,
      isTarget: true,
      colorKey: 'red_sports',
    ),
    Vehicle(
      id: 'v1',
      position: Position(1, 2),
      orientation: VehicleOrientation.vertical,
      length: 2,
      type: VehicleType.car,
    ),
  ],
)
`

The embedded BFSSolver will automatically validate solvability and compute optimal moves!

---

## 🚀 Running & Testing

### Get Dependencies
`ash
flutter pub get
`

### Analyze Code
`ash
flutter analyze
`

### Run All Tests
`ash
flutter test
`

### Run Application
`ash
flutter run
`

---

## 📄 License & Attribution
Park Karo - Production Ready Mobile Game.
