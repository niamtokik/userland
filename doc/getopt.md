# getopt

`getopt` mercury module gives the possibility to parse argument and
defines different types to make it easier. At first, we need to define
our options/arguments. `getopt` supports short options (e.g. `-a` or
`-X`) and long options (e.g. `--help`), both can share the same types
or use their own.

```mercury
:- type option
   ---> my_flag
   ;    my_other_flag.
```

```mercury
option_default(my_flag, bool(no)).
option_default(my_other_flag, int(0)).
```

```mercury
long_option("my_flag", my_flag).
long_option("my_other_flag", my_other_flag).
```

```mercury
short_option("f", my_flag).
short_option("o", my_other_flag).
```

