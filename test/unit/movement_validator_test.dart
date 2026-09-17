import 'package:flutter_test/flutter_test.dart';
import 'package:park_karo/features/game/domain/board.dart';
import 'package:park_karo/features/game/domain/orientation.dart';
import 'package:park_karo/features/game/domain/position.dart';
import 'package:park_karo/features/game/domain/vehicle.dart';
import 'package:park_karo/features/game/domain/vehicle_type.dart';
import 'package:park_karo/features/game/engine/movement_validator.dart';

void main() {
  group('MovementValidator Unit Tests', () {
    test('Horizontal vehicle range calculation', () {
      final target = const Vehicle(
        id: 'target',
        position: Position(2, 0),
        orientation: VehicleOrientation.horizontal,
        length: 2,
        type: VehicleType.target,
        isTarget: true,
      );

      final blocker = const Vehicle(
        id: 'v1',
        position: Position(2, 3),
        orientation: VehicleOrientation.vertical,
        length: 2,
        type: VehicleType.car,
      );

      final board = Board(vehicles: [target, blocker]);
      final range = MovementValidator.getValidMoveRange(board, target);

      expect(range.min, equals(0));
      expect(range.max, equals(1)); // Blocked by v1 at col 3
    });
  });
}
