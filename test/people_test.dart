import 'package:palmeres/people.dart';
import 'package:test/test.dart';

void main() {
  group('People', () {
    group('.allocateApartments()', () {
      test('asserts collections are not empty', () {
        expect(
          () => const <Person>{}.allocateApartments(from: DateTime.now()),
          throwsA(isA<AssertionError>()),
        );
        expect(
          () => const {Person('A'), Person('B')}.allocateApartments(
            from: DateTime.now(),
            apartments: const <Apartment>[],
          ),
          throwsA(isA<AssertionError>()),
        );
      });

      test('allocates four people with default values', () {
        const people = {'A', 'B', 'C', 'D'} as Set<Person>;
        final schedule = people.allocateApartments(from: DateTime(2024, 6, 3));

        expect(schedule, [
          (DateTime(2024, 6, 3), '', 'A'),
          (DateTime(2024, 6, 10), '', 'B'),
          (DateTime(2024, 6, 17), '', 'C'),
          (DateTime(2024, 6, 24), '', 'D'),
        ]);
      });

      test('allocates four people randomly', () {
        const people = {'A', 'B', 'C', 'D'} as Set<Person>;
        final schedule = people.allocateApartments(
          from: DateTime(2024, 6, 3),
          shuffle: true,
        );

        expect(schedule, [
          (DateTime(2024, 6, 3), '', 'D'),
          (DateTime(2024, 6, 10), '', 'C'),
          (DateTime(2024, 6, 17), '', 'B'),
          (DateTime(2024, 6, 24), '', 'A'),
        ]);
      });

      test('allocates four people randomly with a different seed', () {
        const people = {'A', 'B', 'C', 'D'} as Set<Person>;
        final schedule = people.allocateApartments(
          from: DateTime(2024, 6, 3),
          shuffle: true,
          seed: 14,
        );

        expect(schedule, [
          (DateTime(2024, 6, 3), '', 'C'),
          (DateTime(2024, 6, 10), '', 'B'),
          (DateTime(2024, 6, 17), '', 'A'),
          (DateTime(2024, 6, 24), '', 'D'),
        ]);
      });

      test('allocates two people in four weeks each', () {
        const people = {'A', 'B'} as Set<Person>;
        final schedule = people.allocateApartments(
          from: DateTime(2024, 6, 3),
          apartments: const ['⛺️'] as List<Apartment>,
          weeksPerPerson: 4,
          shuffle: true,
        );

        expect(schedule, [
          (DateTime(2024, 6, 3), '⛺️', 'B'),
          (DateTime(2024, 6, 10), '⛺️', 'A'),
          (DateTime(2024, 6, 17), '⛺️', 'B'),
          (DateTime(2024, 6, 24), '⛺️', 'A'),
          (DateTime(2024, 7), '⛺️', 'B'),
          (DateTime(2024, 7, 8), '⛺️', 'A'),
          (DateTime(2024, 7, 15), '⛺️', 'B'),
          (DateTime(2024, 7, 22), '⛺️', 'A'),
        ]);
      });

      test('allocates six people in two apartments', () {
        const people = {'A', 'B', 'C', 'D', 'E', 'F'} as Set<Person>;
        final schedule = people.allocateApartments(
          from: DateTime(2024, 6, 3),
          weeksPerPerson: 2,
          apartments: const ['🌴', '🏡'] as List<Apartment>,
          shuffle: true,
        );

        expect(schedule, [
          (DateTime(2024, 6, 3), '🌴', 'F'),
          (DateTime(2024, 6, 3), '🏡', 'E'),
          (DateTime(2024, 6, 10), '🌴', 'C'),
          (DateTime(2024, 6, 10), '🏡', 'D'),
          (DateTime(2024, 6, 17), '🌴', 'B'),
          (DateTime(2024, 6, 17), '🏡', 'A'),
          (DateTime(2024, 6, 24), '🌴', 'E'),
          (DateTime(2024, 6, 24), '🏡', 'F'),
          (DateTime(2024, 7), '🌴', 'D'),
          (DateTime(2024, 7), '🏡', 'C'),
          (DateTime(2024, 7, 8), '🌴', 'A'),
          (DateTime(2024, 7, 8), '🏡', 'B'),
          (DateTime(2024, 7, 15), '🌴', 'F'),
          (DateTime(2024, 7, 15), '🏡', 'E'),
          (DateTime(2024, 7, 22), '🌴', 'C'),
          (DateTime(2024, 7, 22), '🏡', 'D'),
          (DateTime(2024, 7, 29), '🌴', 'B'),
          (DateTime(2024, 7, 29), '🏡', 'A'),
          (DateTime(2024, 8, 5), '🌴', 'E'),
          (DateTime(2024, 8, 5), '🏡', 'F'),
          (DateTime(2024, 8, 12), '🌴', 'D'),
          (DateTime(2024, 8, 12), '🏡', 'C'),
          (DateTime(2024, 8, 19), '🌴', 'A'),
          (DateTime(2024, 8, 19), '🏡', 'B'),
        ]);
      });

      test('allocates three people in four apartments', () {
        const people = {'A', 'B', 'C'} as Set<Person>;
        final schedule = people.allocateApartments(
          from: DateTime(2024, 6, 3),
          weeksPerPerson: 2,
          apartments: const ['🌴', '🏡', '🏩', '⛺️'] as List<Apartment>,
          shuffle: true,
        );

        expect(schedule, [
          (DateTime(2024, 6, 3), '⛺️', 'B'),
          (DateTime(2024, 6, 3), '🌴', 'B'),
          (DateTime(2024, 6, 3), '🏡', 'C'),
          (DateTime(2024, 6, 3), '🏩', 'C'),
          (DateTime(2024, 6, 10), '⛺️', 'C'),
          (DateTime(2024, 6, 10), '🌴', 'C'),
          (DateTime(2024, 6, 10), '🏡', 'A'),
          (DateTime(2024, 6, 10), '🏩', 'A'),
          (DateTime(2024, 6, 17), '⛺️', 'A'),
          (DateTime(2024, 6, 17), '🌴', 'A'),
          (DateTime(2024, 6, 17), '🏡', 'B'),
          (DateTime(2024, 6, 17), '🏩', 'B'),
          (DateTime(2024, 6, 24), '⛺️', 'B'),
          (DateTime(2024, 6, 24), '🌴', 'B'),
          (DateTime(2024, 6, 24), '🏡', 'C'),
          (DateTime(2024, 6, 24), '🏩', 'C'),
          (DateTime(2024, 7), '⛺️', 'C'),
          (DateTime(2024, 7), '🌴', 'C'),
          (DateTime(2024, 7), '🏡', 'A'),
          (DateTime(2024, 7), '🏩', 'A'),
          (DateTime(2024, 7, 8), '⛺️', 'A'),
          (DateTime(2024, 7, 8), '🌴', 'A'),
          (DateTime(2024, 7, 8), '🏡', 'B'),
          (DateTime(2024, 7, 8), '🏩', 'B'),
        ]);
      });
    });
  });
}
