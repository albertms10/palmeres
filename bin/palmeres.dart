import 'package:palmeres/palmeres.dart';

void main(List<String> arguments) {
  final [startDate, weeksPerPerson, people] = arguments;

  people.split(',').map((person) => person.trim()).toSet().allocateWeeks(
        from: DateTime.parse(startDate),
        weeksPerPerson: int.parse(weeksPerPerson),
        seed: 19,
      );
}

// dart bin/palmeres.dart 2024-06-03 3 "Joan M., M. Mercè, Josep M., M. Teresa, Montse, M. Lledó"
