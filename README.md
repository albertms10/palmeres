# 🌴 palmeres

A simple command-line application with an entrypoint in `bin/` and library code
in `lib/`.

```sh
dart bin/palmeres.dart \
  --from="2024-06-03" --weeks-per-person=2 --apartment="🌴" --apartment="🏡" \
  -p John -p Lydia -p Peter --shuffle
```

Outputs to the console:

```
=================
3/6: 🌴 Lydia, 🏡 Peter
10/6: 🌴 Peter, 🏡 John
17/6: 🌴 John, 🏡 Lydia
24/6: 🌴 Lydia, 🏡 Peter
1/7: 🌴 Peter, 🏡 John
8/7: 🌴 John, 🏡 Lydia
=================

=================
Lydia: 🌴 3/6, 🏡 17/6, 🌴 24/6, 🏡 8/7
Peter: 🏡 3/6, 🌴 10/6, 🏡 24/6, 🌴 1/7
John: 🏡 10/6, 🌴 17/6, 🏡 1/7, 🌴 8/7
=================
```

And writes into `out/schedule.tsv`:

```tsv
Date	Apartment	Person
2024-06-03	🌴	Lydia
2024-06-10	🌴	Peter
2024-06-17	🌴	John
2024-06-24	🌴	Lydia
2024-07-01	🌴	Peter
2024-07-08	🌴	John
2024-06-03	🏡	Peter
2024-06-10	🏡	John
2024-06-17	🏡	Lydia
2024-06-24	🏡	Peter
2024-07-01	🏡	John
2024-07-08	🏡	Lydia
```
