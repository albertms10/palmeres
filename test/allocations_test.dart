import 'package:palmeres/allocations.dart';
import 'package:palmeres/people.dart';
import 'package:test/test.dart';

void main() {
  group('Allocations', () {
    group('.toTSV()', () {
      test('returns an empty table when this record list is empty', () {
        expect(const <RowTuple>[].toTSV(), 'Date\tApartment\tPerson');
      });

      test('returns a TSV table with custom headers', () {
        expect(
          [
            (DateTime(2024, 6, 3), const Apartment('🌴'), const Person('F')),
            (DateTime(2024, 6, 10), const Apartment('🌴'), const Person('C')),
          ].toTSV(headers: const ('Data', 'Apartament', 'Persona')),
          '''
Data\tApartament\tPersona
2024-06-03\t🌴\tF
2024-06-10\t🌴\tC''',
        );
      });

      test('returns this record list formatted as TSV', () {
        final schedule = [
          (DateTime(2024, 6, 3), const Apartment('🌴'), const Person('F')),
          (DateTime(2024, 6, 10), const Apartment('🌴'), const Person('C')),
          (DateTime(2024, 6, 17), const Apartment('🌴'), const Person('B')),
          (DateTime(2024, 6, 24), const Apartment('🌴'), const Person('E')),
          (DateTime(2024, 7), const Apartment('🌴'), const Person('D')),
          (DateTime(2024, 7, 8), const Apartment('🌴'), const Person('A')),
          (DateTime(2024, 7, 15), const Apartment('🌴'), const Person('F')),
          (DateTime(2024, 7, 22), const Apartment('🌴'), const Person('C')),
          (DateTime(2024, 7, 29), const Apartment('🌴'), const Person('B')),
          (DateTime(2024, 8, 5), const Apartment('🌴'), const Person('E')),
          (DateTime(2024, 8, 12), const Apartment('🌴'), const Person('D')),
          (DateTime(2024, 8, 19), const Apartment('🌴'), const Person('A')),
          (DateTime(2024, 6, 3), const Apartment('🏡'), const Person('E')),
          (DateTime(2024, 6, 10), const Apartment('🏡'), const Person('D')),
          (DateTime(2024, 6, 17), const Apartment('🏡'), const Person('A')),
          (DateTime(2024, 6, 24), const Apartment('🏡'), const Person('F')),
          (DateTime(2024, 7), const Apartment('🏡'), const Person('C')),
          (DateTime(2024, 7, 8), const Apartment('🏡'), const Person('B')),
          (DateTime(2024, 7, 15), const Apartment('🏡'), const Person('E')),
          (DateTime(2024, 7, 22), const Apartment('🏡'), const Person('D')),
          (DateTime(2024, 7, 29), const Apartment('🏡'), const Person('A')),
          (DateTime(2024, 8, 5), const Apartment('🏡'), const Person('F')),
          (DateTime(2024, 8, 12), const Apartment('🏡'), const Person('C')),
          (DateTime(2024, 8, 19), const Apartment('🏡'), const Person('B')),
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
