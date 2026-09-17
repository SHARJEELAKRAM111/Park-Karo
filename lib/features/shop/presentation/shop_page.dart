import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/storage/progress_repository.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../cubit/shop_cubit.dart';
import '../cubit/shop_state.dart';
import '../domain/board_theme.dart';
import '../domain/vehicle_skin.dart';
import 'widgets/skin_card.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopCubit(context.read<ProgressRepository>()),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Garage Shop', style: AppTypography.titleMedium),
            backgroundColor: AppColors.background,
            bottom: const TabBar(
              indicatorColor: AppColors.accent,
              labelColor: AppColors.accent,
              unselectedLabelColor: Colors.white60,
              tabs: [
                Tab(icon: Icon(Icons.directions_car_rounded), text: 'Vehicle Skins'),
                Tab(icon: Icon(Icons.dashboard_customize_rounded), text: 'Board Themes'),
              ],
            ),
          ),
          body: BlocBuilder<ShopCubit, ShopState>(
            builder: (context, state) {
              final cubit = context.read<ShopCubit>();

              return Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    color: AppColors.cardBg.withValues(alpha: 0.5),
                    child: Row(
                      children: [
                        Expanded(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerLeft,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Icon(Icons.lock_open_rounded, color: AppColors.secondary, size: 16),
                                SizedBox(width: 6),
                                Text(
                                  'Unlocked via Gameplay Coins',
                                  style: TextStyle(fontSize: 12, color: Colors.white70, fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.cardBg,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: AppColors.accent.withValues(alpha: 0.5)),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.monetization_on, color: AppColors.accent, size: 16),
                              const SizedBox(width: 4),
                              Text('${state.coins}', style: AppTypography.bodyLarge.copyWith(fontSize: 13, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        // TAB 1: VEHICLE SKINS
                        ListView(
                          padding: const EdgeInsets.all(16),
                          children: [
                            ...VehicleSkin.allSkins.map((skin) {
                              final isUnlocked = state.unlockedSkins.contains(skin.id);
                              final isEquipped = state.equippedSkin == skin.id;

                              return Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: SkinCard(
                                  skin: skin,
                                  isUnlocked: isUnlocked,
                                  isEquipped: isEquipped,
                                  onTap: () async {
                                    final ok = await cubit.buySkin(skin);
                                    if (!ok && context.mounted) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text('Not enough coins! Solve more puzzles to earn coins.'),
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              );
                            }),
                          ],
                        ),

                        // TAB 2: BOARD THEMES
                        ListView(
                          padding: const EdgeInsets.all(16),
                          children: [
                            ...BoardThemeData.allThemes.map((theme) {
                              final isUnlocked = state.unlockedThemes.contains(theme.id);
                              final isEquipped = state.equippedTheme == theme.id;

                              return Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: AppColors.cardBg,
                                    borderRadius: BorderRadius.circular(18),
                                    border: Border.all(
                                      color: isEquipped ? AppColors.accent : Colors.white10,
                                      width: isEquipped ? 2.0 : 1.0,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: theme.boardBg,
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(color: theme.border, width: 2),
                                        ),
                                        child: Center(
                                          child: Container(
                                            width: 14,
                                            height: 14,
                                            decoration: BoxDecoration(
                                              color: theme.gridLine,
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              theme.name,
                                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white),
                                            ),
                                            const SizedBox(height: 2),
                                            Text(
                                              theme.price == 0 ? 'Default Theme' : 'Cost: ${theme.price} Coins',
                                              style: const TextStyle(color: Colors.white54, fontSize: 11),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      ElevatedButton(
                                        onPressed: () async {
                                          final ok = await cubit.buyTheme(theme);
                                          if (!ok && context.mounted) {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(
                                                content: Text('Not enough coins! Solve more puzzles to earn coins.'),
                                                duration: Duration(seconds: 2),
                                              ),
                                            );
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: isEquipped
                                              ? AppColors.secondary
                                              : (isUnlocked ? AppColors.primary : AppColors.accent),
                                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                          minimumSize: const Size(60, 36),
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                        ),
                                        child: Text(
                                          isEquipped ? 'EQUIPPED' : (isUnlocked ? 'EQUIP' : '${theme.price} C'),
                                          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
