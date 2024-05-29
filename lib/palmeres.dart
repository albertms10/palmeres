// ignore_for_file: avoid_print

import 'dart:collection' show SplayTreeMap;
import 'dart:math' show Random;

import 'package:intl/intl.dart' show DateFormat;

final _dM = DateFormat('d/M');
final _yMd = DateFormat('yyyy-MM-dd');

/// A Date distribution extension.
extension DateDistribution on Set<String> {
  /// Allocates each item in this [Set] in weeks starting [from] a date
  /// given the number of [weeksPerPerson].
  ///
  /// Optionally, [seed] can be provided to initialize the internal state of the
  /// random generator.
  Map<String, List<DateTime>> allocateWeeks({
    required DateTime from,
    int weeksPerPerson = 1,
    int seed = 0,
  }) {
    final random = Random(seed * 1000 + from.year);
    final sortedPeople = toList()..shuffle(random);
    final totalWeeks = weeksPerPerson * length;
    final schedule = <String, List<DateTime>>{};

    var runDate = from;
    for (var i = 0; i < totalWeeks; i++) {
      final person = sortedPeople[i % length];
      if (schedule[person] == null) schedule[person] = [];
      schedule[person]!.add(runDate);
      runDate = runDate.add(const Duration(days: 7));
    }

    return schedule
      ..prettyPrint()
      ..flat().prettyPrint();
  }
}

extension<K> on Map<K, List<DateTime>> {
  Map<DateTime, K> flat() => SplayTreeMap.of({
        for (final entry in entries)
          for (final date in entry.value) date: entry.key,
      });

  void prettyPrint() {
    print('====================');
    for (final entry in entries) {
      print(
        '${entry.key}: '
        '${entry.value.map(_dM.format).join(', ')}',
      );
    }
    print('====================');
  }
}

extension<V> on Map<DateTime, V> {
  void prettyPrint() {
    print('====================');
    for (final entry in entries) {
      print('${_dM.format(entry.key)}: ${entry.value}');
    }
    print('====================');
  }
}
