import 'dart:io' show File;

import 'package:args/args.dart' show ArgParser;
import 'package:palmeres/allocations.dart';
import 'package:palmeres/people.dart';

const _from = 'from';
const _person = 'person';
const _weeksPerPerson = 'weeks-per-person';
const _apartment = 'apartment';
const _out = 'out';

Future<void> main(List<String> arguments) async {
  final parser = ArgParser()
    ..addOption(_from, abbr: 'f', mandatory: true, valueHelp: 'date')
    ..addMultiOption(_person, abbr: 'p', valueHelp: 'name')
    ..addOption(_weeksPerPerson, abbr: 'w', valueHelp: 'count')
    ..addMultiOption(_apartment, abbr: 'a', valueHelp: 'name')
    ..addOption(
      _out,
      abbr: 'o',
      defaultsTo: 'out/schedule.tsv',
      valueHelp: 'path',
    );

  final results = parser.parse(arguments);

  final schedule = results.multiOption(_person).toSet().allocateWeeks(
        from: DateTime.parse(results.option(_from)!),
        weeksPerPerson: int.parse(results.option(_weeksPerPerson)!),
        apartments: results.multiOption(_apartment),
        seed: 19,
      );

  await File(results.option(_out)!)
      .writeAsString(schedule.toTSV(header: const ('Data', 'Caseta', 'Germà')));
}

// dart bin/palmeres.dart -f 2024-06-03 -w3 -a "🌴 Palmeres" -a "🏡 Caseta núm. 7" -p "Joan M." -p "M. Mercè" -p "Josep M." -p "M. Teresa" -p "Montse" -p "M. Lledó"
