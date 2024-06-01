# 🌴 palmeres

A simple command-line application with an entrypoint in `bin/` and library code
in `lib/`.

```sh
dart bin/palmeres.dart \
  --from="2024-06-03" --weeks-per-person=2 --apartment="🌴" --apartment="🏡" \
  -p John -p Lydia -p Peter --shuffle
```

Outputs:

```
== 🌴 ===============
3/6: Lydia
10/6: Peter
17/6: John
24/6: Lydia
1/7: Peter
8/7: John
== 🌴 ===============
== 🏡 ===============
3/6: Peter
10/6: John
17/6: Lydia
24/6: Peter
1/7: John
8/7: Lydia
== 🏡 ===============
```
