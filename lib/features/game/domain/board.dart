import 'package:equatable/equatable.dart';
import 'position.dart';
import 'vehicle.dart';

class Board extends Equatable {
  final int rows;
  final int cols;
  final int exitRow;
  final int exitCol;
  final List<Vehicle> vehicles;

  const Board({
    this.rows = 6,
    this.cols = 6,
    this.exitRow = 2,
    this.exitCol = 5,
    required this.vehicles,
  });

  Vehicle? get targetVehicle {
    for (final v in vehicles) {
      if (v.isTarget) return v;
    }
    return null;
  }

  Vehicle? getVehicleById(String id) {
    for (final v in vehicles) {
      if (v.id == id) return v;
    }
    return null;
  }

  bool isTargetEscaped() {
    final target = targetVehicle;
    if (target == null) return false;
    final rightCol = target.position.col + target.length - 1;
    return target.position.row == exitRow && rightCol >= exitCol;
  }

  Map<Position, String> get occupiedMap {
    final map = <Position, String>{};
    for (final v in vehicles) {
      for (final pos in v.occupiedPositions) {
        map[pos] = v.id;
      }
    }
    return map;
  }

  Board copyWithVehiclePosition(String vehicleId, Position newPos) {
    final newVehicles = vehicles.map((v) {
      if (v.id == vehicleId) {
        return v.copyWith(position: newPos);
      }
      return v;
    }).toList();
    return Board(
      rows: rows,
      cols: cols,
      exitRow: exitRow,
      exitCol: exitCol,
      vehicles: newVehicles,
    );
  }

  String get canonicalStateKey {
    final sorted = List<Vehicle>.from(vehicles)
      ..sort((a, b) => a.id.compareTo(b.id));
    return sorted.map((v) => '${v.id}:${v.position.row},${v.position.col}').join(';');
  }

  @override
  List<Object?> get props => [rows, cols, exitRow, exitCol, vehicles];
}
