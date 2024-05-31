import 'dart:io' show File;

import 'package:args/args.dart' show ArgParser;
import 'package:palmeres/allocations.dart';
import 'package:palmeres/people.dart';

const _out = 'out';
const _from = 'from';
const _seed = 'seed';
const _person = 'person';
const _apartment = 'apartment';
const _weeksPerPerson = 'weeks-per-person';

const outDefault = 'out/schedule.tsv';

final parser = ArgParser()
  ..addOption(
    _from,
    abbr: 'f',
    mandatory: true,
    valueHelp: 'date',
    help: 'Specifies the starting date for the schedule. '
        'The date should be in a valid format (e.g., YYYY-MM-DD).',
  )
  ..addMultiOption(
    _person,
    abbr: 'p',
    valueHelp: 'name',
    help: 'Specifies one or more people for the schedule. '
        'Multiple people can be added by repeating this option '
        'or by providing a comma-separated list.',
  )
  ..addOption(
    _weeksPerPerson,
    abbr: 'w',
    valueHelp: 'count',
    help: 'Specifies the number of weeks each person '
        'will be allocated in the schedule. '
        'The value should be a positive integer.',
  )
  ..addMultiOption(
    _apartment,
    abbr: 'a',
    valueHelp: 'name',
    help: 'Specifies one or more apartments to be used in the schedule. '
        'Multiple apartments can be added by repeating this option '
        'or by providing a comma-separated list.',
  )
  ..addOption(
    _seed,
    abbr: 's',
    valueHelp: 'number',
    help: 'Specifies the seed for randomization to ensure reproducibility. '
        'The value should be an integer. '
        'If not provided, a default seed will be used.',
  )
  ..addOption(
    _out,
    abbr: 'o',
    defaultsTo: outDefault,
    valueHelp: 'path',
    help: 'Specifies the output file path for the generated schedule. '
        "If not provided, the default path '$outDefault' will be used.",
  );

Future<void> main(List<String> arguments) async {
  final results = parser.parse(arguments);
  final seedArg = results.option(_seed);
  final schedule = results.multiOption(_person).toSet().allocateWeeks(
        from: DateTime.parse(results.option(_from)!),
        weeksPerPerson: int.parse(results.option(_weeksPerPerson)!),
        apartments: results.multiOption(_apartment),
        seed: seedArg != null ? int.parse(seedArg) : null,
      );

  final table = schedule.toTSV(headers: const ('Data', 'Caseta', 'Germà'));
  await File(results.option(_out)!).writeAsString(table);
}

// dart bin/palmeres.dart -f 2024-06-03 -w3 -a "🌴 Palmeres" -a "🏡 Caseta núm. 7" -p "Joan M." -p "M. Mercè" -p "Josep M." -p "M. Teresa" -p "Montse" -p "M. Lledó"
