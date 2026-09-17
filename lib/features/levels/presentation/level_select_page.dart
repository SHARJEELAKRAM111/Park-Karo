import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/storage/progress_repository.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../game/presentation/game_page.dart';
import '../data/level_repository.dart';
import 'widgets/level_card.dart';

class LevelSelectPage extends StatefulWidget {
  const LevelSelectPage({super.key});

  @override
  State<LevelSelectPage> createState() => _LevelSelectPageState();
}

class _LevelSelectPageState extends State<LevelSelectPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final repo = LevelRepository();

  final List<String> worlds = [
    'World 1: Beginner',
    'World 2: Easy',
    'World 3: Medium',
    'World 4: Hard',
    'World 5: Expert',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final progress = context.watch<ProgressRepository>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Select Level', style: AppTypography.titleMedium),
        backgroundColor: AppColors.background,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          indicatorColor: AppColors.primary,
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.textSecondary,
          tabs: worlds.map((w) => Tab(text: w)).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: List.generate(5, (worldIndex) {
          final worldId = worldIndex + 1;
          final levels = repo.getLevelsForWorld(worldId);

          return LayoutBuilder(
            builder: (context, constraints) {
              final columns = (constraints.maxWidth / 85).floor().clamp(3, 8);

              return GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: columns,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.0,
                ),
                itemCount: levels.length,
                itemBuilder: (context, index) {
                  final lvl = levels[index];
                  final isUnlocked = lvl.id <= progress.highestUnlockedLevel;
                  final stars = progress.getStars(lvl.id);

                  return LevelCard(
                    level: lvl,
                    isUnlocked: isUnlocked,
                    stars: stars,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => GamePage(level: lvl),
                      )).then((_) => setState(() {}));
                    },
                  );
                },
              );
            },
          );
        }),
      ),
    );
  }
}