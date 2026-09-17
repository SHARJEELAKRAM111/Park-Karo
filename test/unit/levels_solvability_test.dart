import 'package:flutter_test/flutter_test.dart';
import 'package:park_karo/features/levels/data/level_repository.dart';
import 'package:park_karo/features/game/engine/bfs_solver.dart';

void main() {
  group('Levels Solvability Automated Test', () {
    test('Verifies all 100 levels are solvable', () {
      final repo = LevelRepository();
      final allLevels = repo.getAllLevels();

      expect(allLevels.length, equals(100));

      for (final lvl in allLevels) {
        final solution = BFSSolver.solve(lvl.toBoard());
        expect(solution, isNotNull, reason: 'Level ${lvl.id} is unsolvable!');
      }
    });
  });
}
