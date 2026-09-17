import 'package:flutter_test/flutter_test.dart';
import 'package:park_karo/features/game/domain/position.dart';

void main() {
  group('Position Unit Tests', () {
    test('Equality and Props check', () {
      const p1 = Position(2, 3);
      const p2 = Position(2, 3);
      const p3 = Position(1, 3);

      expect(p1, equals(p2));
      expect(p1 == p3, isFalse);
    });
  });
}
