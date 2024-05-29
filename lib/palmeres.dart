// ignore_for_file: avoid_print, no_adjacent_strings_in_list

import 'dart:io' show File;
import 'dart:math' show Random;

import 'package:intl/intl.dart' show DateFormat;

final _dM = DateFormat('d/M');
final _yMd = DateFormat('yyyy-MM-dd');

/// A people extension.
extension People on Set<String> {
  /// Allocates each item in this [Set] in weeks starting [from] a date
  /// given the number of [weeksPerPerson].
  ///
  /// Optionally, [seed] can be provided to initialize the internal state of the
  /// random generator.
  List<(DateTime, String, String)> allocateWeeks({
    required DateTime from,
    int weeksPerPerson = 1,
    List<String> labels = const [''],
    int seed = 0,
  }) {
    assert(labels.isNotEmpty, 'Labels must contain at least one item');

    final random = Random(seed * 1000 + from.year);
    final sortedPeople = toList()..shuffle(random);

    return [
      for (var i = 0; i < labels.length; i++)
        ..._allocateWeeks(
          people: sortedPeople,
          from: from,
          weeksPerPerson: weeksPerPerson,
          indexShift: length ~/ (i + 1),
          label: labels[i],
        ).recordEntries,
    ];
  }

  Map<DateTime, ({String label, String person})> _allocateWeeks({
    required List<String> people,
    required DateTime from,
    required String label,
    int indexShift = 0,
    int weeksPerPerson = 1,
  }) {
    final totalWeeks = weeksPerPerson * length;
    final schedule = <DateTime, ({String label, String person})>{};

    var runDate = from;
    for (var i = 0; i < totalWeeks; i++) {
      final person = people[(i + indexShift) % length];
      schedule[runDate] = (label: label, person: person);
      runDate = runDate.add(const Duration(days: 7));
    }

    return schedule..prettyPrint(label: label);
  }
}

extension<K> on Map<K, List<DateTime>> {
  void prettyPrint({String label = ''}) {
    print('== $label ===============');
    for (final entry in entries) {
      print(
        '${entry.key}: '
        '${entry.value.map(_dM.format).join(', ')}',
      );
    }
    print('== $label ===============');
  }
}

extension on Map<DateTime, ({String label, String person})> {
  List<(DateTime, String, String)> get recordEntries => [
        for (final entry in entries)
          (entry.key, entry.value.label, entry.value.person),
      ];

  void prettyPrint({String label = ''}) {
    print('== $label ===============');
    for (final entry in entries) {
      print('${_dM.format(entry.key)}: ${entry.value.person}');
    }
    print('== $label ===============');
  }
}

/// An allocations extension.
extension Allocations on List<(DateTime, String, String)> {
  /// Writes this [Map] in a CSV file with [fileName].
  void writeCSV({required String fileName}) {
    final content = StringBuffer()
      ..writeAll(
        [
          'Date,Label,Person',
          for (final item in this)
            '${_yMd.format(item.$1)},'
                '${item.$2},'
                '${item.$3}',
        ],
        '\n',
      );

    File('out/$fileName').writeAsStringSync(content.toString());
  }
}
