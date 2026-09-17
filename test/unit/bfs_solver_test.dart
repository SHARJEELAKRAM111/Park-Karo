import 'package:flutter_test/flutter_test.dart';
import 'package:park_karo/features/game/domain/board.dart';
import 'package:park_karo/features/game/domain/orientation.dart';
import 'package:park_karo/features/game/domain/position.dart';
import 'package:park_karo/features/game/domain/vehicle.dart';
import 'package:park_karo/features/game/domain/vehicle_type.dart';
import 'package:park_karo/features/game/engine/bfs_solver.dart';

void main() {
  group('BFSSolver Unit Tests', () {
    test('Solves basic unblocked target car in 1 move', () {
      final target = const Vehicle(
        id: 'target',
        position: Position(2, 3),
        orientation: VehicleOrientation.horizontal,
        length: 2,
        type: VehicleType.target,
        isTarget: true,
      );

      final board = Board(vehicles: [target]);
      final solution = BFSSolver.solve(board);

      expect(solution, isNotNull);
      expect(solution!.length, equals(1));
    });
  });
}
