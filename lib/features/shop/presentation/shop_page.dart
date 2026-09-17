import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/storage/progress_repository.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../cubit/shop_cubit.dart';
import '../cubit/shop_state.dart';
import '../domain/vehicle_skin.dart';
import 'widgets/skin_card.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopCubit(context.read<ProgressRepository>()),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Garage Shop', style: AppTypography.titleMedium),
          backgroundColor: AppColors.background,
        ),
        body: BlocBuilder<ShopCubit, ShopState>(
          builder: (context, state) {
            final cubit = context.read<ShopCubit>();

            return ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Vehicle Skins', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                    Row(
                      children: [
                        const Icon(Icons.monetization_on, color: AppColors.accent, size: 20),
                        const SizedBox(width: 4),
                        Text('', style: AppTypography.bodyLarge),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
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
                            const SnackBar(content: Text('Not enough coins!')),
                          );
                        }
                      },
                    ),
                  );
                }),
              ],
            );
          },
        ),
      ),
    );
  }
}
