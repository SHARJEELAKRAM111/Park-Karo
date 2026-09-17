import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/orientation.dart';
import '../../domain/position.dart';
import '../../domain/vehicle.dart';
import '../../engine/movement_validator.dart';
import '../../cubit/game_cubit.dart';
import '../../cubit/game_state.dart';
import 'vehicle_widget.dart';

class ParkingBoardWidget extends StatefulWidget {
  const ParkingBoardWidget({super.key});

  @override
  State<ParkingBoardWidget> createState() => _ParkingBoardWidgetState();
}

class _ParkingBoardWidgetState extends State<ParkingBoardWidget> {
  String? _draggingVehicleId;
  double _dragPixelOffset = 0.0;
  int _startCell = 0;
  int _minCell = 0;
  int _maxCell = 0;

  void _onPanStart(Vehicle vehicle, DragStartDetails details, GameState state, double cellSize) {
    final range = MovementValidator.getValidMoveRange(state.board, vehicle);
    final isHorizontal = vehicle.orientation == VehicleOrientation.horizontal;

    setState(() {
      _draggingVehicleId = vehicle.id;
      _dragPixelOffset = 0.0;
      _startCell = isHorizontal ? vehicle.position.col : vehicle.position.row;
      _minCell = range.min;
      _maxCell = range.max;
    });

    context.read<GameCubit>().selectVehicle(vehicle.id);
  }

  void _onPanUpdate(Vehicle vehicle, DragUpdateDetails details, double cellSize) {
    if (_draggingVehicleId != vehicle.id) return;
    final isHorizontal = vehicle.orientation == VehicleOrientation.horizontal;
    final delta = isHorizontal ? details.delta.dx : details.delta.dy;

    final minPixelDelta = (_minCell - _startCell) * cellSize;
    final maxPixelDelta = (_maxCell - _startCell) * cellSize;

    setState(() {
      _dragPixelOffset = (_dragPixelOffset + delta).clamp(minPixelDelta, maxPixelDelta);
    });
  }

  void _onPanEnd(Vehicle vehicle, DragEndDetails details, double cellSize) {
    if (_draggingVehicleId != vehicle.id) return;
    final snappedDelta = (_dragPixelOffset / cellSize).round();
    final targetCell = (_startCell + snappedDelta).clamp(_minCell, _maxCell);
    final isHorizontal = vehicle.orientation == VehicleOrientation.horizontal;

    setState(() {
      _draggingVehicleId = null;
      _dragPixelOffset = 0.0;
    });

    if (targetCell != _startCell) {
      final newPos = isHorizontal
          ? Position(vehicle.position.row, targetCell)
          : Position(targetCell, vehicle.position.col);
      context.read<GameCubit>().moveVehicle(vehicle.id, newPos);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameCubit, GameState>(
      builder: (context, state) {
        final board = state.board;
        final cubit = context.read<GameCubit>();

        return AspectRatio(
          aspectRatio: 1.0,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final boardWidth = constraints.maxWidth;
              final cellSize = boardWidth / board.cols;

              return Container(
                decoration: BoxDecoration(
                  color: AppColors.boardAsphalt,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.primary, width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.5),
                      blurRadius: 18,
                      offset: const Offset(0, 8),
                    )
                  ],
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // Asphalt parking grid markings
                    CustomPaint(
                      size: Size(boardWidth, boardWidth),
                      painter: _ParkingGridPainter(rows: board.rows, cols: board.cols),
                    ),

                    // Glowing Neon EXIT Slot on Exit Row
                    Positioned(
                      top: board.exitRow * cellSize + (cellSize * 0.1),
                      right: -16,
                      width: 16,
                      height: cellSize * 0.8,
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.secondary,
                          borderRadius: const BorderRadius.horizontal(
                            right: Radius.circular(10),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.secondary.withValues(alpha: 0.85),
                              blurRadius: 12,
                              spreadRadius: 3,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.arrow_forward_ios,
                          size: 11,
                          color: Colors.black,
                        ),
                      ),
                    ),

                    // Vehicles Stack
                    ...board.vehicles.map((vehicle) {
                      final isSelected = state.selectedVehicleId == vehicle.id;
                      final isHinted = state.hintMove?.vehicleId == vehicle.id;
                      final isDragging = _draggingVehicleId == vehicle.id;
                      final offset = isDragging ? _dragPixelOffset : 0.0;

                      return VehicleWidget(
                        key: ValueKey(vehicle.id),
                        vehicle: vehicle,
                        cellSize: cellSize,
                        isSelected: isSelected,
                        isHinted: isHinted,
                        skinId: state.equippedSkin,
                        dragPixelOffset: offset,
                        isCurrentlyDragging: isDragging,
                        onTap: () => cubit.selectVehicle(vehicle.id),
                        onPanStart: (details) => _onPanStart(vehicle, details, state, cellSize),
                        onPanUpdate: (details) => _onPanUpdate(vehicle, details, cellSize),
                        onPanEnd: (details) => _onPanEnd(vehicle, details, cellSize),
                      );
                    }),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class _ParkingGridPainter extends CustomPainter {
  final int rows;
  final int cols;

  _ParkingGridPainter({required this.rows, required this.cols});

  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = AppColors.boardGridLine
      ..strokeWidth = 1.0;

    final cellW = size.width / cols;
    final cellH = size.height / rows;

    for (int r = 1; r < rows; r++) {
      canvas.drawLine(Offset(0, r * cellH), Offset(size.width, r * cellH), linePaint);
    }
    for (int c = 1; c < cols; c++) {
      canvas.drawLine(Offset(c * cellW, 0), Offset(c * cellW, size.height), linePaint);
    }
  }

  @override
  bool shouldRepaint(covariant _ParkingGridPainter oldDelegate) => false;
}