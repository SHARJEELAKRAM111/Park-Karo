import 'package:equatable/equatable.dart';

class ShopState extends Equatable {
  final int coins;
  final String equippedSkin;
  final String equippedTheme;
  final List<String> unlockedSkins;
  final List<String> unlockedThemes;

  const ShopState({
    required this.coins,
    required this.equippedSkin,
    required this.equippedTheme,
    required this.unlockedSkins,
    required this.unlockedThemes,
  });

  ShopState copyWith({
    int? coins,
    String? equippedSkin,
    String? equippedTheme,
    List<String>? unlockedSkins,
    List<String>? unlockedThemes,
  }) {
    return ShopState(
      coins: coins ?? this.coins,
      equippedSkin: equippedSkin ?? this.equippedSkin,
      equippedTheme: equippedTheme ?? this.equippedTheme,
      unlockedSkins: unlockedSkins ?? this.unlockedSkins,
      unlockedThemes: unlockedThemes ?? this.unlockedThemes,
    );
  }

  @override
  List<Object?> get props => [coins, equippedSkin, equippedTheme, unlockedSkins, unlockedThemes];
}
