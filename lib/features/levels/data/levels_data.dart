import '../../game/domain/position.dart';
import '../../game/domain/orientation.dart';
import '../../game/domain/vehicle.dart';
import '../../game/domain/vehicle_type.dart';
import '../../game/domain/level_definition.dart';

class LevelsData {
  static final List<LevelDefinition> allLevels = _generateLevels();

  static List<LevelDefinition> _generateLevels() {
    final list = <LevelDefinition>[];
    for (int i = 1; i <= 100; i++) {
      int worldId = 1;
      String difficulty = 'Beginner';
      if (i > 80) {
        worldId = 5;
        difficulty = 'Expert';
      } else if (i > 60) {
        worldId = 4;
        difficulty = 'Hard';
      } else if (i > 40) {
        worldId = 3;
        difficulty = 'Medium';
      } else if (i > 20) {
        worldId = 2;
        difficulty = 'Easy';
      }

      final vehicles = <Vehicle>[];

      int targetCol = (i > 50) ? 1 : 0;
      vehicles.add(Vehicle(
        id: 'target',
        position: Position(2, targetCol),
        orientation: VehicleOrientation.horizontal,
        length: 2,
        type: VehicleType.target,
        isTarget: true,
        colorKey: 'red_sports',
      ));

      int blockerCol = (i % 2 == 0) ? 2 : 3;
      vehicles.add(Vehicle(
        id: 'v1',
        position: Position(1, blockerCol),
        orientation: VehicleOrientation.vertical,
        length: 2,
        type: VehicleType.car,
        colorKey: 'cyan',
      ));

      vehicles.add(Vehicle(
        id: 'h1',
        position: Position(0, blockerCol),
        orientation: VehicleOrientation.horizontal,
        length: 2,
        type: VehicleType.car,
        colorKey: 'amber',
      ));

      if (i > 15) {
        vehicles.add(Vehicle(
          id: 'v2',
          position: Position(3, 1),
          orientation: VehicleOrientation.vertical,
          length: 2,
          type: VehicleType.car,
          colorKey: 'purple',
        ));
      }

      if (i > 35) {
        vehicles.add(Vehicle(
          id: 'h2',
          position: Position(5, 0),
          orientation: VehicleOrientation.horizontal,
          length: 3,
          type: VehicleType.truck,
          colorKey: 'steel',
        ));
      }

      if (i > 65) {
        vehicles.add(Vehicle(
          id: 'v3',
          position: Position(0, 5),
          orientation: VehicleOrientation.vertical,
          length: 3,
          type: VehicleType.truck,
          colorKey: 'green',
        ));
      }

      int par = 4 + (i % 4) + (worldId * 2);

      list.add(LevelDefinition(
        id: i,
        worldId: worldId,
        title: 'Level $i',
        difficulty: difficulty,
        vehicles: vehicles,
        parMoves: par,
      ));
    }
    return list;
  }
}