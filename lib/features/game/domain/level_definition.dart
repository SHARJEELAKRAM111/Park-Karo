import 'package:equatable/equatable.dart';
import 'board.dart';
import 'vehicle.dart';

class LevelDefinition extends Equatable {
  final int id;
  final int worldId;
  final String title;
  final String difficulty;
  final List<Vehicle> vehicles;
  final int parMoves;
  final int boardRows;
  final int boardCols;
  final int exitRow;
  final int exitCol;

  const LevelDefinition({
    required this.id,
    required this.worldId,
    required this.title,
    required this.difficulty,
    required this.vehicles,
    required this.parMoves,
    this.boardRows = 6,
    this.boardCols = 6,
    this.exitRow = 2,
    this.exitCol = 5,
  });

  Board toBoard() {
    return Board(
      rows: boardRows,
      cols: boardCols,
      exitRow: exitRow,
      exitCol: exitCol,
      vehicles: vehicles,
    );
  }

  @override
  List<Object?> get props => [
        id,
        worldId,
        title,
        difficulty,
        vehicles,
        parMoves,
        boardRows,
        boardCols,
        exitRow,
        exitCol,
      ];
}
