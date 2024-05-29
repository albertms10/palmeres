import 'package:palmeres/people.dart';
import 'package:test/test.dart';

void main() {
  group('People', () {
    group('.allocateWeeks()', () {
      test('allocates people in weeks', () {
        final schedule = const {'A', 'B', 'C', 'D', 'E', 'F'}.allocateWeeks(
          from: DateTime(2024, 6, 3),
          weeksPerPerson: 2,
          labels: ['🌴', '🏡'],
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
    });
  });
}
