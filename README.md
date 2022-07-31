tcounter
========

Countup numbers.

```
$ tcounter
[Tally counter]

  Count: 0
```

Usage
-----

```
$ tcounter [<option(s)>]
countup numbers.

options:
      --help   print usage and exit

keys:
  <CR>    count up
  q       finish count and exit
  <C-c>   finish count (for debug)
```

Requirements
------------

- Bash
- Vim

Installation
------------

1. Copy `tcounter` into your `$PATH`.
2. Make `tcounter` executable.

```
$ curl -L https://raw.githubusercontent.com/nil2nekoni2/tcounter/master/tcounter > ~/bin/tcounter
$ chmod +x ~/bin/tcounter
```

Note: In this example, `$HOME/bin` must be included in `$PATH`.

Options
-------

### --help

Print usage and exit.

```
$ ad --help
(Print usage)
```

License
-------

MIT License

Author
------

nil2 <nil2@nil2.org>
