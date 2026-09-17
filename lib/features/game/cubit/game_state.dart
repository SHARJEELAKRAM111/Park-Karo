import 'package:equatable/equatable.dart';
import '../domain/board.dart';
import '../domain/level_definition.dart';
import '../domain/move_record.dart';

enum GameStatus { initial, playing, completed }

class GameState extends Equatable {
  final GameStatus status;
  final LevelDefinition level;
  final Board board;
  final String? selectedVehicleId;
  final int moveCount;
  final List<MoveRecord> moveHistory;
  final MoveRecord? hintMove;
  final int stars;
  final int coinsEarned;
  final String equippedSkin;
  final String equippedTheme;

  const GameState({
    required this.status,
    required this.level,
    required this.board,
    this.selectedVehicleId,
    required this.moveCount,
    required this.moveHistory,
    this.hintMove,
    this.stars = 0,
    this.coinsEarned = 0,
    required this.equippedSkin,
    required this.equippedTheme,
  });

  GameState copyWith({
    GameStatus? status,
    LevelDefinition? level,
    Board? board,
    String? selectedVehicleId,
    int? moveCount,
    List<MoveRecord>? moveHistory,
    MoveRecord? hintMove,
    bool clearHint = false,
    int? stars,
    int? coinsEarned,
    String? equippedSkin,
    String? equippedTheme,
  }) {
    return GameState(
      status: status ?? this.status,
      level: level ?? this.level,
      board: board ?? this.board,
      selectedVehicleId: selectedVehicleId ?? this.selectedVehicleId,
      moveCount: moveCount ?? this.moveCount,
      moveHistory: moveHistory ?? this.moveHistory,
      hintMove: clearHint ? null : (hintMove ?? this.hintMove),
      stars: stars ?? this.stars,
      coinsEarned: coinsEarned ?? this.coinsEarned,
      equippedSkin: equippedSkin ?? this.equippedSkin,
      equippedTheme: equippedTheme ?? this.equippedTheme,
    );
  }

  @override
  List<Object?> get props => [
        status,
        level,
        board,
        selectedVehicleId,
        moveCount,
        moveHistory,
        hintMove,
        stars,
        coinsEarned,
        equippedSkin,
        equippedTheme,
      ];
}
