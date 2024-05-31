import 'package:palmeres/people.dart';
import 'package:test/test.dart';

void main() {
  group('People', () {
    group('.allocateWeeks()', () {
      test('asserts collections are not empty', () {
        expect(
          () => const <String>{}.allocateWeeks(from: DateTime.now()),
          throwsA(isA<AssertionError>()),
        );
        expect(
          () => const {'A', 'B'}.allocateWeeks(
            from: DateTime.now(),
            apartments: const [],
          ),
          throwsA(isA<AssertionError>()),
        );
      });

      test('allocates four people with default values', () {
        final schedule = const {'A', 'B', 'C', 'D'}.allocateWeeks(
          from: DateTime(2024, 6, 3),
        );

        expect(schedule, [
          (DateTime(2024, 6, 3), '', 'D'),
          (DateTime(2024, 6, 10), '', 'C'),
          (DateTime(2024, 6, 17), '', 'B'),
          (DateTime(2024, 6, 24), '', 'A'),
        ]);
      });

      test('allocates four people with a different seed', () {
        final schedule = const {'A', 'B', 'C', 'D'}.allocateWeeks(
          from: DateTime(2024, 6, 3),
          seed: 14,
        );

        expect(schedule, [
          (DateTime(2024, 6, 3), '', 'C'),
          (DateTime(2024, 6, 10), '', 'B'),
          (DateTime(2024, 6, 17), '', 'A'),
          (DateTime(2024, 6, 24), '', 'D'),
        ]);
      });

      test('allocates people in four weeks each', () {
        final schedule = const {'A', 'B'}.allocateWeeks(
          from: DateTime(2024, 6, 3),
          weeksPerPerson: 4,
        );

        expect(schedule, [
          (DateTime(2024, 6, 3), '', 'B'),
          (DateTime(2024, 6, 10), '', 'A'),
          (DateTime(2024, 6, 17), '', 'B'),
          (DateTime(2024, 6, 24), '', 'A'),
          (DateTime(2024, 7), '', 'B'),
          (DateTime(2024, 7, 8), '', 'A'),
          (DateTime(2024, 7, 15), '', 'B'),
          (DateTime(2024, 7, 22), '', 'A'),
        ]);
      });

      test('allocates six people in two apartments', () {
        final schedule = const {'A', 'B', 'C', 'D', 'E', 'F'}.allocateWeeks(
          from: DateTime(2024, 6, 3),
          weeksPerPerson: 2,
          apartments: const ['🌴', '🏡'],
        );

        expect(schedule, [
          (DateTime(2024, 6, 3), '🌴', 'F'),
          (DateTime(2024, 6, 10), '🌴', 'C'),
          (DateTime(2024, 6, 17), '🌴', 'B'),
          (DateTime(2024, 6, 24), '🌴', 'E'),
          (DateTime(2024, 7), '🌴', 'D'),
          (DateTime(2024, 7, 8), '🌴', 'A'),
          (DateTime(2024, 7, 15), '🌴', 'F'),
          (DateTime(2024, 7, 22), '🌴', 'C'),
          (DateTime(2024, 7, 29), '🌴', 'B'),
          (DateTime(2024, 8, 5), '🌴', 'E'),
          (DateTime(2024, 8, 12), '🌴', 'D'),
          (DateTime(2024, 8, 19), '🌴', 'A'),
          (DateTime(2024, 6, 3), '🏡', 'E'),
          (DateTime(2024, 6, 10), '🏡', 'D'),
          (DateTime(2024, 6, 17), '🏡', 'A'),
          (DateTime(2024, 6, 24), '🏡', 'F'),
          (DateTime(2024, 7), '🏡', 'C'),
          (DateTime(2024, 7, 8), '🏡', 'B'),
          (DateTime(2024, 7, 15), '🏡', 'E'),
          (DateTime(2024, 7, 22), '🏡', 'D'),
          (DateTime(2024, 7, 29), '🏡', 'A'),
          (DateTime(2024, 8, 5), '🏡', 'F'),
          (DateTime(2024, 8, 12), '🏡', 'C'),
          (DateTime(2024, 8, 19), '🏡', 'B'),
        ]);
      });

      test('allocates three people in four apartments', () {
        final schedule = const {'A', 'B', 'C'}.allocateWeeks(
          from: DateTime(2024, 6, 3),
          weeksPerPerson: 2,
          apartments: const ['🌴', '🏡', '🏩', '⛺️'],
        );

        expect(schedule, [
          (DateTime(2024, 6, 3), '🌴', 'B'),
          (DateTime(2024, 6, 10), '🌴', 'C'),
          (DateTime(2024, 6, 17), '🌴', 'A'),
          (DateTime(2024, 6, 24), '🌴', 'B'),
          (DateTime(2024, 7), '🌴', 'C'),
          (DateTime(2024, 7, 8), '🌴', 'A'),
          (DateTime(2024, 6, 3), '🏡', 'C'),
          (DateTime(2024, 6, 10), '🏡', 'A'),
          (DateTime(2024, 6, 17), '🏡', 'B'),
          (DateTime(2024, 6, 24), '🏡', 'C'),
          (DateTime(2024, 7), '🏡', 'A'),
          (DateTime(2024, 7, 8), '🏡', 'B'),
          (DateTime(2024, 6, 3), '🏩', 'C'),
          (DateTime(2024, 6, 10), '🏩', 'A'),
          (DateTime(2024, 6, 17), '🏩', 'B'),
          (DateTime(2024, 6, 24), '🏩', 'C'),
          (DateTime(2024, 7), '🏩', 'A'),
          (DateTime(2024, 7, 8), '🏩', 'B'),
          (DateTime(2024, 6, 3), '⛺️', 'B'),
          (DateTime(2024, 6, 10), '⛺️', 'C'),
          (DateTime(2024, 6, 17), '⛺️', 'A'),
          (DateTime(2024, 6, 24), '⛺️', 'B'),
          (DateTime(2024, 7), '⛺️', 'C'),
          (DateTime(2024, 7, 8), '⛺️', 'A')
        ]);
      });
    });
  });
}
