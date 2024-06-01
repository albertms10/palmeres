// ignore_for_file: avoid_print

import 'dart:math' show Random;

import 'package:intl/intl.dart' show DateFormat;

final _dM = DateFormat('d/M');
const _oneWeek = Duration(days: 7);

/// A people extension.
extension People on Iterable<String> {
  /// Allocates each person in this collection in weeks starting [from] a date,
  /// given the number of [weeksPerPerson] and a list of [apartments].
  ///
  /// Use [shuffle] to randomize the people collection. Optionally, [seed]
  /// can be provided to initialize the internal state of the random generator.
  List<(DateTime date, String apartment, String person)> allocateWeeks({
    required DateTime from,
    int weeksPerPerson = 1,
    List<String> apartments = const [''],
    bool shuffle = false,
    int? seed,
  }) {
    assert(isNotEmpty, 'This collection must contain at least one item');
    assert(apartments.isNotEmpty, 'Apartments must contain at least one item');

    final sortedPeople = toList();
    if (shuffle) {
      final random = Random(seed ?? 0 * 1000 + from.year);
      sortedPeople.shuffle(random);
    }

    return [
      for (var i = 0; i < apartments.length; i++)
        ..._allocateWeeks(
          people: sortedPeople,
          from: from,
          apartment: apartments[i],
          weeksPerPerson: weeksPerPerson,
          indexShift: length ~/ (i + 1),
        ).recordEntries,
    ];
  }

  Map<DateTime, ({String apartment, String person})> _allocateWeeks({
    required List<String> people,
    required DateTime from,
    required String apartment,
    int weeksPerPerson = 1,
    int indexShift = 0,
  }) {
    final totalWeeks = weeksPerPerson * length;
    final schedule = <DateTime, ({String apartment, String person})>{};

    var runDate = from;
    for (var i = 0; i < totalWeeks; i++) {
      final person = people[(i + indexShift) % length];
      schedule[runDate] = (apartment: apartment, person: person);
      runDate = runDate.add(_oneWeek);
    }

    return schedule..prettyPrint();
  }
}

extension on Map<DateTime, ({String apartment, String person})> {
  List<(DateTime, String, String)> get recordEntries => [
        for (final entry in entries)
          (entry.key, entry.value.apartment, entry.value.person),
      ];

  void prettyPrint() {
    final apartment = entries.first.value.apartment;
    print('== $apartment ===============');
    for (final entry in entries) {
      print('${_dM.format(entry.key)}: ${entry.value.person}');
    }
    print('== $apartment ===============');
  }
}
