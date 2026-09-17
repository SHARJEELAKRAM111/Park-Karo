import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/audio/audio_service.dart';
import '../../../../core/haptics/haptic_service.dart';
import '../../../../core/storage/progress_repository.dart';
import '../domain/level_definition.dart';
import '../domain/move_record.dart';
import '../domain/position.dart';
import '../engine/movement_validator.dart';
import '../engine/bfs_solver.dart';
import 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  final ProgressRepository _repository;
  final AudioService _audioService = AudioService();
  final HapticService _hapticService = HapticService();

  GameCubit(this._repository, LevelDefinition level)
      : super(GameState(
          status: GameStatus.initial,
          level: level,
          board: level.toBoard(),
          moveCount: 0,
          moveHistory: const [],
          equippedSkin: _repository.equippedSkin,
          equippedTheme: _repository.equippedTheme,
        )) {
    loadLevel(level);
  }

  void loadLevel(LevelDefinition level) {
    emit(GameState(
      status: GameStatus.playing,
      level: level,
      board: level.toBoard(),
      selectedVehicleId: null,
      moveCount: 0,
      moveHistory: const [],
      hintMove: null,
      stars: 0,
      coinsEarned: 0,
      equippedSkin: _repository.equippedSkin,
      equippedTheme: _repository.equippedTheme,
    ));
  }

  void selectVehicle(String? vehicleId) {
    if (vehicleId != null) {
      _hapticService.selectionClick();
    }
    emit(state.copyWith(selectedVehicleId: vehicleId, clearHint: true));
  }

  Future<void> moveVehicle(String vehicleId, Position newPos) async {
    final vehicle = state.board.getVehicleById(vehicleId);
    if (vehicle == null) return;

    if (vehicle.position == newPos) return;

    final isValid = MovementValidator.isMoveValid(state.board, vehicle, newPos);
    if (!isValid) {
      _audioService.playInvalid();
      _hapticService.heavyImpact();
      return;
    }

    final moveRecord = MoveRecord(
      vehicleId: vehicleId,
      from: vehicle.position,
      to: newPos,
    );

    final newBoard = state.board.copyWithVehiclePosition(vehicleId, newPos);
    final newHistory = List<MoveRecord>.from(state.moveHistory)..add(moveRecord);
    final newMoveCount = state.moveCount + 1;

    _audioService.playMove();
    _hapticService.lightImpact();

    if (newBoard.isTargetEscaped()) {
      final stars = _calculateStars(newMoveCount, state.level.parMoves);
      final coins = 100 + (stars * 50);

      await _repository.saveLevelCompletion(
        levelId: state.level.id,
        stars: stars,
        moves: newMoveCount,
      );
      await _repository.addCoins(coins);

      _audioService.playWin();
      _hapticService.successNotification();

      emit(state.copyWith(
        status: GameStatus.completed,
        board: newBoard,
        moveCount: newMoveCount,
        moveHistory: newHistory,
        stars: stars,
        coinsEarned: coins,
        clearHint: true,
      ));
    } else {
      emit(state.copyWith(
        status: GameStatus.playing,
        board: newBoard,
        moveCount: newMoveCount,
        moveHistory: newHistory,
        clearHint: true,
      ));
    }
  }

  void undo() {
    if (state.moveHistory.isEmpty) return;
    final lastMove = state.moveHistory.last;
    final restoredBoard = state.board.copyWithVehiclePosition(
      lastMove.vehicleId,
      lastMove.from,
    );
    final newHistory = List<MoveRecord>.from(state.moveHistory)..removeLast();
    final newMoveCount = (state.moveCount > 0) ? state.moveCount - 1 : 0;

    _hapticService.mediumImpact();
    _audioService.playClick();

    emit(state.copyWith(
      board: restoredBoard,
      moveHistory: newHistory,
      moveCount: newMoveCount,
      clearHint: true,
    ));
  }

  void reset() {
    _hapticService.mediumImpact();
    _audioService.playClick();
    loadLevel(state.level);
  }

  Future<void> requestHint() async {
    _hapticService.lightImpact();
    _audioService.playClick();

    await _repository.incrementHintsUsed();

    final path = BFSSolver.solve(state.board);
    if (path != null && path.isNotEmpty) {
      emit(state.copyWith(hintMove: path.first));
    }
  }

  int _calculateStars(int moves, int par) {
    if (moves <= par) return 3;
    if (moves <= par + 3) return 2;
    return 1;
  }
}
