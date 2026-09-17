import 'dart:collection';
import '../domain/board.dart';
import '../domain/position.dart';
import '../domain/orientation.dart';
import '../domain/move_record.dart';
import '../domain/vehicle_type.dart';
import 'movement_validator.dart';

class BFSSolver {
  /// Solves the given board using Breadth-First Search.
  /// Returns shortest list of MoveRecords to reach win condition, or null if unsolvable.
  static List<MoveRecord>? solve(Board initialBoard, {int maxDepth = 20000}) {
    if (initialBoard.isTargetEscaped()) return [];

    final visited = <String>{initialBoard.canonicalStateKey};
    final queue = Queue<({Board board, List<MoveRecord> path})>();

    queue.add((board: initialBoard, path: []));

    int iterations = 0;

    while (queue.isNotEmpty) {
      iterations++;
      if (iterations > maxDepth) break;

      final current = queue.removeFirst();
      final currentBoard = current.board;

      if (currentBoard.isTargetEscaped()) {
        return current.path;
      }

      for (final vehicle in currentBoard.vehicles) {
        if (vehicle.type == VehicleType.obstacle) continue;

        final range = MovementValidator.getValidMoveRange(currentBoard, vehicle);

        if (vehicle.orientation == VehicleOrientation.horizontal) {
          for (int c = range.min; c <= range.max; c++) {
            if (c == vehicle.position.col) continue;
            final newPos = Position(vehicle.position.row, c);
            final nextBoard = currentBoard.copyWithVehiclePosition(vehicle.id, newPos);
            final key = nextBoard.canonicalStateKey;
            if (!visited.contains(key)) {
              visited.add(key);
              final newPath = List<MoveRecord>.from(current.path)
                ..add(MoveRecord(
                  vehicleId: vehicle.id,
                  from: vehicle.position,
                  to: newPos,
                ));
              queue.add((board: nextBoard, path: newPath));
            }
          }
        } else {
          for (int r = range.min; r <= range.max; r++) {
            if (r == vehicle.position.row) continue;
            final newPos = Position(r, vehicle.position.col);
            final nextBoard = currentBoard.copyWithVehiclePosition(vehicle.id, newPos);
            final key = nextBoard.canonicalStateKey;
            if (!visited.contains(key)) {
              visited.add(key);
              final newPath = List<MoveRecord>.from(current.path)
                ..add(MoveRecord(
                  vehicleId: vehicle.id,
                  from: vehicle.position,
                  to: newPos,
                ));
              queue.add((board: nextBoard, path: newPath));
            }
          }
        }
      }
    }

    return null;
  }
}
