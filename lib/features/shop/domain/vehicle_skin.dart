import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class VehicleSkin extends Equatable {
  final String id;
  final String name;
  final String description;
  final int price;
  final Color primaryColor;
  final Color accentColor;
  final IconData icon;

  const VehicleSkin({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.primaryColor,
    required this.accentColor,
    required this.icon,
  });

  static const List<VehicleSkin> allSkins = [
    VehicleSkin(
      id: 'red_sports',
      name: 'Red Racer',
      description: 'Classic fiery red sports car',
      price: 0,
      primaryColor: Color(0xFFFF2A4B),
      accentColor: Color(0xFFFFD700),
      icon: Icons.directions_car,
    ),
    VehicleSkin(
      id: 'neon_cyber',
      name: 'Cyber Neon',
      description: 'Futuristic glowing cyber vehicle',
      price: 300,
      primaryColor: Color(0xFF00E5FF),
      accentColor: Color(0xFFFF007F),
      icon: Icons.electric_car,
    ),
    VehicleSkin(
      id: 'police_patrol',
      name: 'Police Cruiser',
      description: 'High speed interceptor',
      price: 500,
      primaryColor: Color(0xFF2962FF),
      accentColor: Color(0xFFFFFFFF),
      icon: Icons.local_police,
    ),
    VehicleSkin(
      id: 'taxi_cab',
      name: 'City Taxi',
      description: 'Iconic yellow cab skin',
      price: 400,
      primaryColor: Color(0xFFFFD600),
      accentColor: Color(0xFF212121),
      icon: Icons.local_taxi,
    ),
    VehicleSkin(
      id: 'gold_luxury',
      name: 'Golden VIP',
      description: 'Pure 24k gold luxury finish',
      price: 1000,
      primaryColor: Color(0xFFFFD700),
      accentColor: Color(0xFFFFA000),
      icon: Icons.workspace_premium,
    ),
    VehicleSkin(
      id: 'stealth_black',
      name: 'Stealth Jet',
      description: 'Matte black stealth finish',
      price: 600,
      primaryColor: Color(0xFF263238),
      accentColor: Color(0xFF00E676),
      icon: Icons.directions_car_filled,
    ),
  ];

  @override
  List<Object?> get props => [id, name, description, price, primaryColor, accentColor, icon];
}
