import '../domain/board.dart';
import '../domain/position.dart';
import '../domain/orientation.dart';
import '../domain/vehicle.dart';

class MovementValidator {
  /// Calculates minimum and maximum column/row a vehicle can currently slide to.
  static ({int min, int max}) getValidMoveRange(Board board, Vehicle vehicle) {
    final map = board.occupiedMap;

    if (vehicle.orientation == VehicleOrientation.horizontal) {
      int minCol = vehicle.position.col;
      int maxCol = vehicle.position.col;

      // Check leftward movement
      for (int c = vehicle.position.col - 1; c >= 0; c--) {
        final checkPos = Position(vehicle.position.row, c);
        final occupyingId = map[checkPos];
        if (occupyingId != null && occupyingId != vehicle.id) {
          break;
        }
        minCol = c;
      }

      // Check rightward movement
      for (int c = vehicle.position.col + 1; c <= board.cols - vehicle.length; c++) {
        bool blocked = false;
        for (int i = 0; i < vehicle.length; i++) {
          final checkPos = Position(vehicle.position.row, c + i);
          final occupyingId = map[checkPos];
          if (occupyingId != null && occupyingId != vehicle.id) {
            blocked = true;
            break;
          }
        }
        if (blocked) break;
        maxCol = c;
      }

      // Special case: Target vehicle can move off board right exit slot
      if (vehicle.isTarget && vehicle.position.row == board.exitRow) {
        if (maxCol == board.cols - vehicle.length) {
          maxCol = board.cols - vehicle.length + 1;
        }
      }

      return (min: minCol, max: maxCol);
    } else {
      int minRow = vehicle.position.row;
      int maxRow = vehicle.position.row;

      // Check upward movement
      for (int r = vehicle.position.row - 1; r >= 0; r--) {
        final checkPos = Position(r, vehicle.position.col);
        final occupyingId = map[checkPos];
        if (occupyingId != null && occupyingId != vehicle.id) {
          break;
        }
        minRow = r;
      }

      // Check downward movement
      for (int r = vehicle.position.row + 1; r <= board.rows - vehicle.length; r++) {
        bool blocked = false;
        for (int i = 0; i < vehicle.length; i++) {
          final checkPos = Position(r + i, vehicle.position.col);
          final occupyingId = map[checkPos];
          if (occupyingId != null && occupyingId != vehicle.id) {
            blocked = true;
            break;
          }
        }
        if (blocked) break;
        maxRow = r;
      }

      return (min: minRow, max: maxRow);
    }
  }

  static bool isMoveValid(Board board, Vehicle vehicle, Position newPos) {
    final range = getValidMoveRange(board, vehicle);
    if (vehicle.orientation == VehicleOrientation.horizontal) {
      return newPos.row == vehicle.position.row &&
          newPos.col >= range.min &&
          newPos.col <= range.max;
    } else {
      return newPos.col == vehicle.position.col &&
          newPos.row >= range.min &&
          newPos.row <= range.max;
    }
  }
}
