// ignore_for_file: avoid_print

import 'dart:math' show Random;

import 'package:intl/intl.dart' show DateFormat;

final _dM = DateFormat('d/M');
const _oneWeek = Duration(days: 7);

/// A row record representation.
typedef RowTuple = (DateTime date, Apartment apartment, Person person);

/// A people extension.
extension People on Iterable<Person> {
  /// Allocates each person in this collection in weeks starting [from] a date,
  /// given the number of [weeksPerPerson] and a list of [apartments].
  ///
  /// Use [shuffle] to randomize the people collection. Optionally, [seed]
  /// can be provided to initialize the internal state of the random generator.
  List<RowTuple> allocateWeeks({
    required DateTime from,
    int weeksPerPerson = 1,
    List<Apartment> apartments = const [Apartment('')],
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
    ]..sort(_compareToFirst);
  }

  static Map<DateTime, ({Apartment apartment, Person person})> _allocateWeeks({
    required List<Person> people,
    required DateTime from,
    required Apartment apartment,
    int weeksPerPerson = 1,
    int indexShift = 0,
  }) {
    final totalWeeks = weeksPerPerson * people.length;
    final schedule = <DateTime, ({Apartment apartment, Person person})>{};

    var runDate = from;
    for (var i = 0; i < totalWeeks; i++) {
      final person = people[(i + indexShift) % people.length];
      schedule[runDate] = (apartment: apartment, person: person);
      runDate = runDate.add(_oneWeek);
    }

    return schedule;
  }
}

/// A grouped by person schedule extension.
extension GroupedByPersonSchedule on Map<Person, List<RowTuple>> {
  /// Prints a string representation of this collection.
  void prettyPrint() {
    print('== By person =====');
    for (final entry in entries) {
      final formattedItem = (entry.value..sort(_compareToFirst))
          .map((item) => '${item.$2} ${_dM.format(item.$1)}')
          .join(', ');
      print('${entry.key}: $formattedItem');
    }
    print('==================\n');
  }
}

/// A grouped by apartment schedule extension.
extension GroupedByApartmentSchedule on Map<Apartment, List<RowTuple>> {
  /// Prints a string representation of this collection.
  void prettyPrint() {
    print('== By apartment ==');
    for (final entry in entries) {
      final formattedItem = (entry.value..sort(_compareToFirst))
          .map((item) => '${item.$3} ${_dM.format(item.$1)}')
          .join(', ');
      print('${entry.key}: $formattedItem');
    }
    print('==================\n');
  }
}

/// A grouped by date schedule extension.
extension GroupedByDateSchedule on Map<DateTime, List<RowTuple>> {
  /// Prints a string representation of this collection.
  void prettyPrint() {
    print('== By date =======');
    for (final entry in entries) {
      final formattedItem = (entry.value..sort(_compareToFirst))
          .map((item) => '${item.$2} ${item.$3}')
          .join(', ');
      print('${_dM.format(entry.key)}: $formattedItem');
    }
    print('==================\n');
  }
}

extension on Map<DateTime, ({Apartment apartment, Person person})> {
  List<RowTuple> get recordEntries => [
        for (final entry in entries)
          (entry.key, entry.value.apartment, entry.value.person),
      ];
}

Comparator<RowTuple> get _compareToFirst => (a, b) {
      final compareFirst = a.$1.compareTo(b.$1);
      if (compareFirst != 0) return compareFirst;
      return a.$2.compareTo(b.$2);
    };

/// A person representation.
extension type const Person(String name) implements String {}

/// An apartment representation.
extension type const Apartment(String name) implements String {}
