import 'package:equatable/equatable.dart';
import 'position.dart';
import 'orientation.dart';
import 'vehicle_type.dart';

class Vehicle extends Equatable {
  final String id;
  final Position position;
  final VehicleOrientation orientation;
  final int length;
  final VehicleType type;
  final bool isTarget;
  final String colorKey;

  const Vehicle({
    required this.id,
    required this.position,
    required this.orientation,
    required this.length,
    required this.type,
    this.isTarget = false,
    this.colorKey = 'cyan',
  });

  List<Position> get occupiedPositions {
    final list = <Position>[];
    for (int i = 0; i < length; i++) {
      if (orientation == VehicleOrientation.horizontal) {
        list.add(Position(position.row, position.col + i));
      } else {
        list.add(Position(position.row + i, position.col));
      }
    }
    return list;
  }

  Vehicle copyWith({
    Position? position,
    String? colorKey,
  }) {
    return Vehicle(
      id: id,
      position: position ?? this.position,
      orientation: orientation,
      length: length,
      type: type,
      isTarget: isTarget,
      colorKey: colorKey ?? this.colorKey,
    );
  }

  @override
  List<Object?> get props => [id, position, orientation, length, type, isTarget, colorKey];
}
