import 'package:flutter/material.dart';
import '../../domain/orientation.dart';
import '../../domain/vehicle.dart';

class VehiclePainter extends CustomPainter {
  final Vehicle vehicle;
  final bool isSelected;
  final bool isHinted;
  final String skinId;

  VehiclePainter({
    required this.vehicle,
    this.isSelected = false,
    this.isHinted = false,
    this.skinId = 'red_sports',
  });

  @override
  void paint(Canvas canvas, Size size) {
    final isHorizontal = vehicle.orientation == VehicleOrientation.horizontal;
    final w = size.width;
    final h = size.height;
    const margin = 4.0;

    // 1. Drop shadow
    final shadowRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(margin, margin + 3, w - (margin * 2), h - (margin * 2)),
      const Radius.circular(12),
    );
    final shadowPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.45)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5);
    canvas.drawRRect(shadowRect, shadowPaint);

    // 2. Wheels / Tires on sides
    _drawTires(canvas, w, h, isHorizontal);

    // 3. Base Vehicle Color
    Color primaryColor;
    Color accentColor;
    if (vehicle.isTarget) {
      switch (skinId) {
        case 'neon_cyber':
          primaryColor = const Color(0xFF00E5FF);
          accentColor = const Color(0xFFFF007F);
          break;
        case 'police_patrol':
          primaryColor = const Color(0xFF1A237E);
          accentColor = Colors.white;
          break;
        case 'taxi_cab':
          primaryColor = const Color(0xFFFFD600);
          accentColor = Colors.black87;
          break;
        case 'gold_luxury':
          primaryColor = const Color(0xFFFFD700);
          accentColor = const Color(0xFFFF6F00);
          break;
        case 'stealth_black':
          primaryColor = const Color(0xFF212121);
          accentColor = const Color(0xFF00E676);
          break;
        default:
          primaryColor = const Color(0xFFFF2A4B);
          accentColor = const Color(0xFFFFD700);
      }
    } else {
      switch (vehicle.colorKey) {
        case 'amber':
          primaryColor = const Color(0xFFFF9800);
          accentColor = const Color(0xFFFFE082);
          break;
        case 'purple':
          primaryColor = const Color(0xFF9C27B0);
          accentColor = const Color(0xFFE1BEE7);
          break;
        case 'teal':
          primaryColor = const Color(0xFF009688);
          accentColor = const Color(0xFFB2DFDB);
          break;
        case 'pink':
          primaryColor = const Color(0xFFE91E63);
          accentColor = const Color(0xFFF8BBD0);
          break;
        case 'steel':
          primaryColor = const Color(0xFF607D8B);
          accentColor = const Color(0xFFCFD8DC);
          break;
        case 'green':
          primaryColor = const Color(0xFF4CAF50);
          accentColor = const Color(0xFFC8E6C9);
          break;
        default:
          primaryColor = const Color(0xFF0288D1);
          accentColor = const Color(0xFFB3E5FC);
      }
    }

    // 4. Main Body Chassis
    final bodyRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(margin, margin, w - (margin * 2), h - (margin * 2)),
      const Radius.circular(12),
    );
    final bodyGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        primaryColor,
        HSVColor.fromColor(primaryColor).withValue(0.65).toColor(),
      ],
    );
    final bodyPaint = Paint()..shader = bodyGradient.createShader(bodyRect.outerRect);
    canvas.drawRRect(bodyRect, bodyPaint);

    // 5. Windows / Cockpit
    _drawCockpit(canvas, w, h, isHorizontal, primaryColor, accentColor);

    // 6. Target Car Special Accents (Stripes, Spoiler, Roof Lights)
    if (vehicle.isTarget) {
      _drawTargetFeatures(canvas, w, h, isHorizontal, accentColor);
    } else if (vehicle.length == 3) {
      _drawTruckCargoRibs(canvas, w, h, isHorizontal);
    }

    // 7. Headlights & Taillights
    _drawLights(canvas, w, h, isHorizontal);

    // 8. Selection or Hint Border Glow
    final borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = isSelected ? 3.0 : (isHinted ? 3.0 : 1.5)
      ..color = isSelected
          ? Colors.white
          : (isHinted ? const Color(0xFFFFD700) : Colors.white.withValues(alpha: 0.25));
    canvas.drawRRect(bodyRect, borderPaint);
  }

  void _drawTires(Canvas canvas, double w, double h, bool isHorizontal) {
    final tirePaint = Paint()..color = const Color(0xFF1E1E1E);
    final rimPaint = Paint()..color = const Color(0xFF757575);

    if (isHorizontal) {
      final tireW = (w * 0.18).clamp(8.0, 18.0);
      const tireH = 3.5;
      final positions = [
        Offset(w * 0.2, 1.0),
        Offset(w * 0.8, 1.0),
        Offset(w * 0.2, h - 1.0),
        Offset(w * 0.8, h - 1.0),
      ];
      for (final p in positions) {
        final rect = Rect.fromCenter(center: p, width: tireW, height: tireH);
        canvas.drawRRect(RRect.fromRectAndRadius(rect, const Radius.circular(2)), tirePaint);
        canvas.drawRect(Rect.fromCenter(center: p, width: tireW * 0.5, height: 1.5), rimPaint);
      }
    } else {
      const tireW = 3.5;
      final tireH = (h * 0.18).clamp(8.0, 18.0);
      final positions = [
        Offset(1.0, h * 0.2),
        Offset(1.0, h * 0.8),
        Offset(w - 1.0, h * 0.2),
        Offset(w - 1.0, h * 0.8),
      ];
      for (final p in positions) {
        final rect = Rect.fromCenter(center: p, width: tireW, height: tireH);
        canvas.drawRRect(RRect.fromRectAndRadius(rect, const Radius.circular(2)), tirePaint);
        canvas.drawRect(Rect.fromCenter(center: p, width: 1.5, height: tireH * 0.5), rimPaint);
      }
    }
  }

  void _drawCockpit(Canvas canvas, double w, double h, bool isHorizontal, Color primary, Color accent) {
    final glassPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [const Color(0xFF263238), const Color(0xFF0D1B2A)],
      ).createShader(Rect.fromLTWH(0, 0, w, h));

    if (isHorizontal) {
      final windshield = RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.25, h * 0.22, w * 0.5, h * 0.56),
        const Radius.circular(6),
      );
      canvas.drawRRect(windshield, glassPaint);

      final roof = RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.35, h * 0.28, w * 0.3, h * 0.44),
        const Radius.circular(4),
      );
      canvas.drawRRect(roof, Paint()..color = primary.withValues(alpha: 0.9));
    } else {
      final windshield = RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.22, h * 0.25, w * 0.56, h * 0.5),
        const Radius.circular(6),
      );
      canvas.drawRRect(windshield, glassPaint);

      final roof = RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.28, h * 0.35, w * 0.44, h * 0.3),
        const Radius.circular(4),
      );
      canvas.drawRRect(roof, Paint()..color = primary.withValues(alpha: 0.9));
    }
  }

  void _drawTargetFeatures(Canvas canvas, double w, double h, bool isHorizontal, Color accent) {
    final stripePaint = Paint()..color = accent.withValues(alpha: 0.85);

    if (isHorizontal) {
      // Racing stripes across center
      canvas.drawRect(Rect.fromLTWH(w * 0.1, h * 0.44, w * 0.8, 2.5), stripePaint);
      // Rear spoiler on left end
      final spoilerPaint = Paint()..color = Colors.black87;
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(w * 0.08, h * 0.18, 3.5, h * 0.64),
          const Radius.circular(2),
        ),
        spoilerPaint,
      );
    } else {
      canvas.drawRect(Rect.fromLTWH(w * 0.44, h * 0.1, 2.5, h * 0.8), stripePaint);
      final spoilerPaint = Paint()..color = Colors.black87;
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(w * 0.18, h * 0.08, w * 0.64, 3.5),
          const Radius.circular(2),
        ),
        spoilerPaint,
      );
    }
  }

  void _drawTruckCargoRibs(Canvas canvas, double w, double h, bool isHorizontal) {
    final ribPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.15)
      ..strokeWidth = 1.5;

    if (isHorizontal) {
      for (double x = w * 0.45; x < w * 0.85; x += w * 0.12) {
        canvas.drawLine(Offset(x, h * 0.25), Offset(x, h * 0.75), ribPaint);
      }
    } else {
      for (double y = h * 0.45; y < h * 0.85; y += h * 0.12) {
        canvas.drawLine(Offset(w * 0.25, y), Offset(w * 0.75, y), ribPaint);
      }
    }
  }

  void _drawLights(Canvas canvas, double w, double h, bool isHorizontal) {
    final headPaint = Paint()..color = const Color(0xFFFFF59D);
    final tailPaint = Paint()..color = const Color(0xFFFF1744);

    if (isHorizontal) {
      // Front headlights on right (toward exit)
      canvas.drawCircle(Offset(w - 7, h * 0.28), 2.5, headPaint);
      canvas.drawCircle(Offset(w - 7, h * 0.72), 2.5, headPaint);
      // Rear taillights on left
      canvas.drawCircle(Offset(7, h * 0.28), 2.2, tailPaint);
      canvas.drawCircle(Offset(7, h * 0.72), 2.2, tailPaint);
    } else {
      // Front headlights at top
      canvas.drawCircle(Offset(w * 0.28, 7), 2.5, headPaint);
      canvas.drawCircle(Offset(w * 0.72, 7), 2.5, headPaint);
      // Rear taillights at bottom
      canvas.drawCircle(Offset(w * 0.28, h - 7), 2.2, tailPaint);
      canvas.drawCircle(Offset(w * 0.72, h - 7), 2.2, tailPaint);
    }
  }

  @override
  bool shouldRepaint(covariant VehiclePainter oldDelegate) {
    return oldDelegate.vehicle != vehicle ||
        oldDelegate.isSelected != isSelected ||
        oldDelegate.isHinted != isHinted ||
        oldDelegate.skinId != skinId;
  }
}