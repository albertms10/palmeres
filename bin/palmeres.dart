// ignore_for_file: avoid_print

import 'dart:io' show File;

import 'package:args/args.dart' show ArgParser;
import 'package:collection/collection.dart' show groupBy;
import 'package:palmeres/allocations.dart';
import 'package:palmeres/people.dart';

const _out = 'out';
const _from = 'from';
const _seed = 'seed';
const _person = 'person';
const _dryRun = 'dry-run';
const _verbose = 'verbose';
const _headers = 'headers';
const _shuffle = 'shuffle';
const _apartment = 'apartment';
const _weeksPerPerson = 'weeks-per-person';

const _outDefault = 'out/schedule.tsv';

final _headersSplitRegExp = RegExp('[,\t]( *)');

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
    _headers,
    abbr: 'h',
    valueHelp: 'Date,Apartment,Person',
    help: 'Specifies the headers to be used in the output TSV file.',
  )
  ..addFlag(
    _shuffle,
    help: 'Specifies whether the list of people should be randomly shuffled. '
        'Use it in conjunction with the --seed option to modify its '
        'generative internal state.',
  )
  ..addOption(
    _seed,
    abbr: 's',
    valueHelp: 'number',
    help: 'Specifies the seed for randomization to ensure reproducibility. '
        'The --shuffle flag must be enabled and the value should be '
        'an integer. If not provided, a default seed will be used.',
  )
  ..addOption(
    _out,
    abbr: 'o',
    defaultsTo: _outDefault,
    valueHelp: 'path',
    help: 'Specifies the output file path for the generated schedule. '
        "If not provided, the default path '$_outDefault' will be used.",
  )
  ..addFlag(
    _verbose,
    abbr: 'v',
    help: 'Specifies whether to run the process in verbose mode '
        'to log helpful details of the suggested schedule',
  )
  ..addFlag(
    _dryRun,
    abbr: 'd',
    help: 'Specifies whether to run the process in dry-run mode '
        'to preview the suggested schedule without writing the file.',
  );

Future<void> main(List<String> arguments) async {
  final results = parser.parse(arguments);
  final seedArg = results.option(_seed);

  final shuffle = results.flag(_shuffle);
  if (!shuffle && seedArg != null) {
    throw ArgumentError.value(
      seedArg,
      'seed',
      'The --shuffle flag must be enabled to use the option',
    );
  }

  final isVerbose = results.flag(_verbose);
  final isDryRun = results.flag(_dryRun);

  final people = (results.multiOption(_person) as List<Person>).toSet();
  final apartments = results.multiOption(_apartment) as List<Apartment>;
  if (isVerbose) {
    print(
      '🛖 Allocating ${people.textualCount} in ${apartments.textualCount}.',
    );
  }

  final schedule = people.allocateApartments(
    from: DateTime.parse(results.option(_from)!),
    weeksPerPerson: int.parse(results.option(_weeksPerPerson)!),
    apartments: results.multiOption(_apartment) as List<Apartment>,
    shuffle: shuffle,
    seed: seedArg != null ? int.parse(seedArg) : null,
  );

  if (isVerbose) {
    print('\n');
    groupBy(schedule, (item) => item.$1).prettyPrint();
    groupBy(schedule, (item) => item.$2).prettyPrint();
    groupBy(schedule, (item) => item.$3).prettyPrint();
  }

  final headersList = results.option(_headers)?.split(_headersSplitRegExp);
  final headers = headersList != null
      ? (headersList[0], headersList[1], headersList[2])
      : null;

  final table = schedule.toTSV(headers: headers);
  final out = results.option(_out)!;

  if (isDryRun) {
    print(table);
    print("🖨️ The schedule would have been written to '$out'.");
  } else {
    await File(out).writeAsString(table);
    print("🖨️ The schedule has been successfully written to '$out'.");
  }
}

// dart bin/palmeres.dart -f 2024-06-03 -w3 -a "🌴" -a "🏡" -p "Joan M." -p "M. Mercè" -p "Josep M." -p "M. Teresa" -p "Montse" -p "M. Lledó" --shuffle -s19 --headers "Data,Caseta,Germà"

extension on Iterable<Person> {
  String get textualCount => '$length ${length == 1 ? 'person' : 'people'}';
}

extension on Iterable<Apartment> {
  String get textualCount =>
      '$length ${length == 1 ? 'apartment' : 'apartments'}';
}
