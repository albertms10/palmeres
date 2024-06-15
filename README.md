# 🌴 palmeres

A simple command-line application with an entrypoint in `bin/` and library code
in `lib/` to fairly allocate bookings.

## Example

Running the following command:

```sh
dart bin/palmeres.dart \
  --from="2024-06-03" --weeks-per-person=2 --apartment="🌴" --apartment="🏡" \
  -p John -p Lydia -p Peter --shuffle
```

Writes the following schedule table into `out/schedule.tsv` (by default):

```tsv
Date	Apartment	Person
2024-06-03	🌴	Lydia
2024-06-03	🏡	Peter
2024-06-10	🌴	Peter
2024-06-10	🏡	John
2024-06-17	🌴	John
2024-06-17	🏡	Lydia
2024-06-24	🌴	Lydia
2024-06-24	🏡	Peter
2024-07-01	🌴	Peter
2024-07-01	🏡	John
2024-07-08	🌴	John
2024-07-08	🏡	Lydia
```

## CLI

Below are the available options and flags that can be used
to customize the behavior of the CLI tool.

### `-f`, `--from`

Specifies the starting date for the schedule.
The date should be in a valid format (e.g., `YYYY-MM-DD`).

```sh
dart bin/palmeres.dart --from 2024-06-15 ...
```

### `-p`, `--person`

Specifies one or more people for the schedule.
Multiple people can be added by repeating this option
or by providing a comma-separated list.

```sh
dart bin/palmeres.dart --person "Alice" --person "Bob" ...
```

or

```sh
dart bin/palmeres.dart --person "Alice,Bob" ...
```

### `-w`, `--weeks-per-person`

Specifies the number of weeks each person will be allocated
in the schedule. The value should be a positive integer.

```sh
dart bin/palmeres.dart --weeks-per-person 2 ...
```

or

```sh
dart bin/palmeres.dart -w2 ...
```

### `-a`, `--apartment`

Specifies one or more apartments to be used in the schedule.
Multiple apartments can be added by repeating this option
or by providing a comma-separated list.

```sh
dart bin/palmeres.dart --apartment "🛖" --apartment "⛺️" ...
```

or

```sh
dart bin/palmeres.dart --apartment "🌴,🏠" ...
```

### `-h`, `--headers`

Specifies the headers to be used in the output TSV file.

```sh
dart bin/palmeres.dart --headers "Date,Apartment,Person" ...
```

### `--shuffle`

Specifies whether the list of people should be randomly shuffled.
Use it in conjunction with the `--seed` option to modify its
generative internal state.

```sh
dart bin/palmeres.dart --shuffle ...
```

### `-s`, `--seed`

Specifies the seed for randomization to ensure reproducibility.
The `--shuffle` flag must be enabled and the value should be an integer.
If not provided, a default seed will be used.

```sh
dart bin/palmeres.dart --shuffle --seed 12345 ...
```

or

```sh
dart bin/palmeres.dart --shuffle -s12345 ...
```

### `-o`, `--out`

Specifies the output file path for the generated schedule.
If not provided, the default path `output.tsv` will be used.

```sh
dart bin/palmeres.dart --out "path/to/output.tsv" ...
```

### `-v`, `--verbose`

Specifies whether to run the process in verbose mode to log
helpful details of the suggested schedule.

```sh
dart bin/palmeres.dart \
  --from="2024-06-03" --weeks-per-person=2 --apartment="🌴" --apartment="🏡" \
  -p John -p Lydia -p Peter --shuffle -v
```

Which outputs to the console:

```
🛖 Allocating 3 people in 2 apartments.

== By date =======
3/6: 🌴 Lydia, 🏡 Peter
10/6: 🌴 Peter, 🏡 John
17/6: 🌴 John, 🏡 Lydia
24/6: 🌴 Lydia, 🏡 Peter
1/7: 🌴 Peter, 🏡 John
8/7: 🌴 John, 🏡 Lydia
==================

== By apartment ==
🌴: Lydia 3/6, Peter 10/6, John 17/6, Lydia 24/6, Peter 1/7, John 8/7
🏡: Peter 3/6, John 10/6, Lydia 17/6, Peter 24/6, John 1/7, Lydia 8/7
==================

== By person =====
Lydia: 🌴 3/6, 🏡 17/6, 🌴 24/6, 🏡 8/7
Peter: 🏡 3/6, 🌴 10/6, 🏡 24/6, 🌴 1/7
John: 🏡 10/6, 🌴 17/6, 🏡 1/7, 🌴 8/7
==================

🖨️ The schedule has been successfully written to 'out/schedule.tsv'.
```

### `-d`, `--dry-run`

Specifies whether to run the process in dry-run mode to preview
the suggested schedule without writing the file.

```sh
dart bin/palmeres.dart --dry-run ...
```
