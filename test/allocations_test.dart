import 'package:palmeres/allocations.dart';
import 'package:test/test.dart';

void main() {
  group('Allocations', () {
    group('.toTSV()', () {
      test('converts this record list to TSV', () {
        final schedule = [
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
        ];

        expect(schedule.toTSV(), '''
Date\tApartment\tPerson
2024-06-03\t🌴\tF
2024-06-10\t🌴\tC
2024-06-17\t🌴\tB
2024-06-24\t🌴\tE
2024-07-01\t🌴\tD
2024-07-08\t🌴\tA
2024-07-15\t🌴\tF
2024-07-22\t🌴\tC
2024-07-29\t🌴\tB
2024-08-05\t🌴\tE
2024-08-12\t🌴\tD
2024-08-19\t🌴\tA
2024-06-03\t🏡\tE
2024-06-10\t🏡\tD
2024-06-17\t🏡\tA
2024-06-24\t🏡\tF
2024-07-01\t🏡\tC
2024-07-08\t🏡\tB
2024-07-15\t🏡\tE
2024-07-22\t🏡\tD
2024-07-29\t🏡\tA
2024-08-05\t🏡\tF
2024-08-12\t🏡\tC
2024-08-19\t🏡\tB''');
      });
    });
  });
}
