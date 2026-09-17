import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class BoardThemeData extends Equatable {
  final String id;
  final String name;
  final int price;
  final Color boardBg;
  final Color gridLine;
  final Color border;

  const BoardThemeData({
    required this.id,
    required this.name,
    required this.price,
    required this.boardBg,
    required this.gridLine,
    required this.border,
  });

  static const List<BoardThemeData> allThemes = [
    BoardThemeData(
      id: 'city_asphalt',
      name: 'City Asphalt',
      price: 0,
      boardBg: Color(0xFF263238),
      gridLine: Color(0xFF37474F),
      border: Color(0xFFFF5722),
    ),
    BoardThemeData(
      id: 'luxury_mall',
      name: 'Mall Deck',
      price: 400,
      boardBg: Color(0xFF1A237E),
      gridLine: Color(0xFF283593),
      border: Color(0xFF00E5FF),
    ),
    BoardThemeData(
      id: 'beach_parking',
      name: 'Sunset Coast',
      price: 500,
      boardBg: Color(0xFF3E2723),
      gridLine: Color(0xFF4E342E),
      border: Color(0xFFFFB300),
    ),
    BoardThemeData(
      id: 'neon_grid',
      name: 'Neon Cyberboard',
      price: 800,
      boardBg: Color(0xFF0D0221),
      gridLine: Color(0xFF261447),
      border: Color(0xFFFF007F),
    ),
  ];

  @override
  List<Object?> get props => [id, name, price, boardBg, gridLine, border];
}
