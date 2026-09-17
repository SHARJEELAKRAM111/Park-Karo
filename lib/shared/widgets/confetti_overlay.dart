import 'dart:math' as math;
import 'package:flutter/material.dart';

class ConfettiParticle {
  double x;
  double y;
  double vx;
  double vy;
  double size;
  Color color;
  double rotation;
  double rotationSpeed;
  double opacity;

  ConfettiParticle({
    required this.x,
    required this.y,
    required this.vx,
    required this.vy,
    required this.size,
    required this.color,
    required this.rotation,
    required this.rotationSpeed,
    this.opacity = 1.0,
  });
}

class ConfettiOverlay extends StatefulWidget {
  const ConfettiOverlay({super.key});

  @override
  State<ConfettiOverlay> createState() => _ConfettiOverlayState();
}

class _ConfettiOverlayState extends State<ConfettiOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<ConfettiParticle> _particles = [];
  final math.Random _random = math.Random();

  static const List<Color> _colors = [
    Color(0xFFFF5722),
    Color(0xFFFFC107),
    Color(0xFF00E676),
    Color(0xFF00E5FF),
    Color(0xFFFF007F),
    Color(0xFFFFD700),
    Color(0xFF7C4DFF),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    )..addListener(_updateParticles);

    _spawnParticles();
    _controller.forward();
  }

  void _spawnParticles() {
    for (int i = 0; i < 70; i++) {
      final angle = _random.nextDouble() * 2 * math.pi;
      final speed = 3.0 + _random.nextDouble() * 9.0;
      _particles.add(ConfettiParticle(
        x: 0.5,
        y: 0.45,
        vx: math.cos(angle) * speed * 0.0025,
        vy: (math.sin(angle) * speed * 0.0025) - 0.005,
        size: 6.0 + _random.nextDouble() * 8.0,
        color: _colors[_random.nextInt(_colors.length)],
        rotation: _random.nextDouble() * 2 * math.pi,
        rotationSpeed: (_random.nextDouble() - 0.5) * 0.2,
      ));
    }
  }

  void _updateParticles() {
    for (final p in _particles) {
      p.x += p.vx;
      p.y += p.vy;
      p.vy += 0.00018; // gravity
      p.rotation += p.rotationSpeed;
      p.opacity = (1.0 - _controller.value).clamp(0.0, 1.0);
    }
    setState(() {});
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: CustomPaint(
        size: Size.infinite,
        painter: _ConfettiPainter(particles: _particles),
      ),
    );
  }
}

class _ConfettiPainter extends CustomPainter {
  final List<ConfettiParticle> particles;

  _ConfettiPainter({required this.particles});

  @override
  void paint(Canvas canvas, Size size) {
    for (final p in particles) {
      if (p.opacity <= 0) continue;
      final paint = Paint()
        ..color = p.color.withValues(alpha: p.opacity)
        ..style = PaintingStyle.fill;

      canvas.save();
      final px = p.x * size.width;
      final py = p.y * size.height;
      canvas.translate(px, py);
      canvas.rotate(p.rotation);
      final rect = Rect.fromCenter(
        center: Offset.zero,
        width: p.size,
        height: p.size * 0.6,
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(rect, const Radius.circular(2)),
        paint,
      );
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant _ConfettiPainter oldDelegate) => true;
}