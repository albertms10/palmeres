import 'package:intl/intl.dart' show DateFormat;

final _yMd = DateFormat('yyyy-MM-dd');

/// An allocations extension.
extension Allocations on List<(DateTime date, String label, String person)> {
  /// This record list formatted as TSV (tab-separated values).
  String toTSV({
    (String, String, String) header = const ('Date', 'Label', 'Person'),
  }) =>
      (StringBuffer()
            ..writeAll(
              [
                '${header.$1}\t${header.$2}\t${header.$3}',
                for (final item in this)
                  '${_yMd.format(item.$1)}\t${item.$2}\t${item.$3}',
              ],
              '\n',
            ))
          .toString();
}
