import 'package:flutter/material.dart';
import '../../domain/orientation.dart';
import '../../domain/vehicle.dart';
import 'vehicle_painter.dart';

class VehicleWidget extends StatelessWidget {
  final Vehicle vehicle;
  final double cellSize;
  final bool isSelected;
  final bool isHinted;
  final String skinId;
  final double dragPixelOffset;
  final bool isCurrentlyDragging;
  final GestureDragStartCallback onPanStart;
  final GestureDragUpdateCallback onPanUpdate;
  final GestureDragEndCallback onPanEnd;
  final VoidCallback onTap;

  const VehicleWidget({
    super.key,
    required this.vehicle,
    required this.cellSize,
    this.isSelected = false,
    this.isHinted = false,
    this.skinId = 'red_sports',
    this.dragPixelOffset = 0.0,
    this.isCurrentlyDragging = false,
    required this.onPanStart,
    required this.onPanUpdate,
    required this.onPanEnd,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isHorizontal = vehicle.orientation == VehicleOrientation.horizontal;
    final width = (isHorizontal ? vehicle.length : 1) * cellSize;
    final height = (isHorizontal ? 1 : vehicle.length) * cellSize;

    final baseLeft = vehicle.position.col * cellSize;
    final baseTop = vehicle.position.row * cellSize;

    final currentLeft = isHorizontal ? (baseLeft + dragPixelOffset) : baseLeft;
    final currentTop = !isHorizontal ? (baseTop + dragPixelOffset) : baseTop;

    return AnimatedPositioned(
      duration: isCurrentlyDragging ? Duration.zero : const Duration(milliseconds: 160),
      curve: Curves.easeOutCubic,
      left: currentLeft,
      top: currentTop,
      width: width,
      height: height,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        onPanStart: onPanStart,
        onPanUpdate: onPanUpdate,
        onPanEnd: onPanEnd,
        child: Stack(
          alignment: Alignment.center,
          children: [
            CustomPaint(
              size: Size(width, height),
              painter: VehiclePainter(
                vehicle: vehicle,
                isSelected: isSelected,
                isHinted: isHinted,
                skinId: skinId,
              ),
            ),
            if (isHinted)
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.amberAccent.withValues(alpha: 0.8),
                ),
                padding: const EdgeInsets.all(4),
                child: const Icon(
                  Icons.lightbulb,
                  size: 16,
                  color: Colors.black,
                ),
              ),
          ],
        ),
      ),
    );
  }
}