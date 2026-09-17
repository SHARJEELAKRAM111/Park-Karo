import 'package:equatable/equatable.dart';
import 'position.dart';

class MoveRecord extends Equatable {
  final String vehicleId;
  final Position from;
  final Position to;

  const MoveRecord({
    required this.vehicleId,
    required this.from,
    required this.to,
  });

  @override
  List<Object?> get props => [vehicleId, from, to];
}
