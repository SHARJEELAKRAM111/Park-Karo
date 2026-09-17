import '../../game/domain/level_definition.dart';
import 'levels_data.dart';

class LevelRepository {
  List<LevelDefinition> getAllLevels() => LevelsData.allLevels;

  LevelDefinition? getLevelById(int id) {
    try {
      return LevelsData.allLevels.firstWhere((l) => l.id == id);
    } catch (_) {
      return null;
    }
  }

  List<LevelDefinition> getLevelsForWorld(int worldId) {
    return LevelsData.allLevels.where((l) => l.worldId == worldId).toList();
  }
}
