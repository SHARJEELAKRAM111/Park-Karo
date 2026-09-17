import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/storage/progress_repository.dart';
import '../domain/level_definition.dart';
import '../cubit/game_cubit.dart';
import '../cubit/game_state.dart';
import 'widgets/game_header.dart';
import 'widgets/parking_board_widget.dart';
import 'widgets/game_controls.dart';
import 'widgets/win_dialog.dart';
import 'widgets/onboarding_overlay.dart';
import '../../levels/data/level_repository.dart';

class GamePage extends StatefulWidget {
  final LevelDefinition level;

  const GamePage({super.key, required this.level});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  bool showTutorial = false;

  @override
  void initState() {
    super.initState();
    if (widget.level.id == 1) {
      showTutorial = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GameCubit(
        context.read<ProgressRepository>(),
        widget.level,
      ),
      child: BlocListener<GameCubit, GameState>(
        listenWhen: (prev, curr) => curr.status == GameStatus.completed && prev.status != GameStatus.completed,
        listener: (context, state) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (dialogCtx) => WinDialog(
              stars: state.stars,
              moves: state.moveCount,
              par: state.level.parMoves,
              coins: state.coinsEarned,
              onReplay: () {
                Navigator.of(dialogCtx).pop();
                context.read<GameCubit>().reset();
              },
              onNextLevel: () {
                Navigator.of(dialogCtx).pop();
                final nextId = state.level.id + 1;
                final nextLevel = LevelRepository().getLevelById(nextId);
                if (nextLevel != null) {
                  context.read<GameCubit>().loadLevel(nextLevel);
                } else {
                  Navigator.of(context).pop();
                }
              },
              onLevelSelect: () {
                Navigator.of(dialogCtx).pop();
                Navigator.of(context).pop();
              },
            ),
          );
        },
        child: Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                LayoutBuilder(
                  builder: (context, constraints) {
                    final availableHeight = constraints.maxHeight;
                    final availableWidth = constraints.maxWidth;
                    final maxBoardHeight = availableHeight - 165.0;
                    final maxBoardWidth = availableWidth - 32.0;
                    final boardSide = math.min(maxBoardWidth, maxBoardHeight).clamp(200.0, 520.0);

                    return BlocBuilder<GameCubit, GameState>(
                      builder: (context, state) {
                        final cubit = context.read<GameCubit>();
                        final repo = context.read<ProgressRepository>();

                        return Column(
                          children: [
                            GameHeader(
                              levelId: state.level.id,
                              moveCount: state.moveCount,
                              parMoves: state.level.parMoves,
                              coins: repo.coins,
                              difficulty: state.level.difficulty,
                              onBack: () => Navigator.of(context).pop(),
                            ),
                            Expanded(
                              child: Center(
                                child: SizedBox(
                                  width: boardSide,
                                  height: boardSide,
                                  child: const ParkingBoardWidget(),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: GameControls(
                                canUndo: state.moveHistory.isNotEmpty,
                                onUndo: cubit.undo,
                                onHint: cubit.requestHint,
                                onReset: cubit.reset,
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
                if (showTutorial)
                  OnboardingOverlay(
                    onDismiss: () => setState(() => showTutorial = false),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
