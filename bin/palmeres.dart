import 'dart:io' show File;

import 'package:palmeres/allocations.dart';
import 'package:palmeres/people.dart';

Future<void> main(List<String> arguments) async {
  final [startDate, weeksPerPerson, labels, people] = arguments;

  final peopleSet = people.trimSplit(',').toSet();
  final schedule = peopleSet.allocateWeeks(
    from: DateTime.parse(startDate),
    weeksPerPerson: int.parse(weeksPerPerson),
    labels: labels.trimSplit(',').toList(),
    seed: 19,
  );

  await File('out/schedule.tsv')
      .writeAsString(schedule.toTSV(header: const ('Data', 'Caseta', 'Germà')));
}

// dart bin/palmeres.dart 2024-06-03 3 "🌴 Palmeres, 🏡 Caseta núm. 7" "Joan M., M. Mercè, Josep M., M. Teresa, Montse, M. Lledó"

extension on String {
  Iterable<String> trimSplit(Pattern pattern) =>
      split(pattern).map((item) => item.trim());
}
