import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/storage/progress_repository.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/primary_button.dart';
import '../../game/presentation/game_page.dart';
import '../../levels/data/level_repository.dart';
import '../../levels/presentation/level_select_page.dart';
import '../../shop/presentation/shop_page.dart';
import '../../achievements/presentation/achievements_page.dart';
import '../../daily_reward/presentation/daily_reward_dialog.dart';
import '../../daily_challenge/presentation/daily_challenge_page.dart';
import '../../statistics/presentation/statistics_page.dart';
import '../../settings/presentation/settings_page.dart';
import 'widgets/animated_car_banner.dart';
import 'widgets/menu_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final repo = context.watch<ProgressRepository>();
    final currentLevelId = repo.highestUnlockedLevel;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: AppColors.cardBg,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: AppColors.accent.withValues(alpha: 0.5)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.monetization_on, color: AppColors.accent, size: 20),
                            const SizedBox(width: 6),
                            Text('${repo.coins}', style: AppTypography.bodyLarge),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const StatisticsPage(),
                              ));
                            },
                            icon: const Icon(Icons.bar_chart, color: Colors.white),
                            style: IconButton.styleFrom(backgroundColor: AppColors.cardBg),
                          ),
                          const SizedBox(width: 8),
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const SettingsPage(),
                              )).then((_) => setState(() {}));
                            },
                            icon: const Icon(Icons.settings, color: Colors.white),
                            style: IconButton.styleFrom(backgroundColor: AppColors.cardBg),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const AnimatedCarBanner(),
                  const SizedBox(height: 16),
                  Text(
                    'PARK KARO',
                    style: AppTypography.titleLarge.copyWith(fontSize: 36, letterSpacing: 2.0),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Unblock the exit & master parking!',
                    style: AppTypography.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 28),
                  PrimaryButton(
                    text: 'PLAY LEVEL $currentLevelId',
                    icon: Icons.play_arrow_rounded,
                    onPressed: () {
                      final level = LevelRepository().getLevelById(currentLevelId) ??
                          LevelRepository().getAllLevels().first;
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => GamePage(level: level),
                      )).then((_) => setState(() {}));
                    },
                  ),
                  const SizedBox(height: 16),
                  MenuButton(
                    title: 'Levels Select (100 Levels)',
                    icon: Icons.grid_view_rounded,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const LevelSelectPage(),
                      )).then((_) => setState(() {}));
                    },
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: MenuButton(
                          title: 'Garage Shop',
                          icon: Icons.shopping_bag_outlined,
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const ShopPage(),
                            )).then((_) => setState(() {}));
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: MenuButton(
                          title: 'Daily Reward',
                          icon: Icons.card_giftcard,
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => const DailyRewardDialog(),
                            ).then((_) => setState(() {}));
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: MenuButton(
                          title: 'Achievements',
                          icon: Icons.emoji_events_outlined,
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const AchievementsPage(),
                            )).then((_) => setState(() {}));
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: MenuButton(
                          title: 'Daily Puzzle',
                          icon: Icons.today,
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const DailyChallengePage(),
                            )).then((_) => setState(() {}));
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
