import 'package:intl/intl.dart' show DateFormat;
import 'package:palmeres/people.dart';

final _yMd = DateFormat('yyyy-MM-dd');

/// An allocations extension.
extension Allocations on List<RowTuple> {
  /// This record list formatted as TSV (tab-separated values).
  String toTSV({(String, String, String)? headers}) {
    headers ??= const ('Date', 'Apartment', 'Person');

    final buffer = StringBuffer()
      ..writeAll(
        [
          '${headers.$1}\t${headers.$2}\t${headers.$3}',
          for (final item in this)
            '${_yMd.format(item.$1)}\t${item.$2}\t${item.$3}',
        ],
        '\n',
      );

    return buffer.toString();
  }
}
