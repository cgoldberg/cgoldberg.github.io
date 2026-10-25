---
title: "treex: Now With Git Built In (Gitoxide)"
description: "Command-line directory tree utility with metadata and Git ignore support"
date: 2026-10-25
tags: [programming, python, git, treex, command line, open source]
---

Since the [original post][announcement-post], I've updated [treex][github-repo]
(Git-aware directory tree utility), with several new features and a faster way
to evaluate `.gitignore` rules.

You can now control the displayed tree depth and filter files and directories by
glob patterns or regular expressions. Here's the full list of available options:

```console
$ treex --help
usage: treex [OPTIONS] [directory]

List directory contents as a tree with file and directory metadata.

positional arguments:
  directory                    directory to scan (default: current directory)

options:
  -h, --help                   show this help message and exit
  -V, --version                show version information and exit
  -a, --all                    show all files, including those ignored by Git
  -m, --modified               show file modification times
  -q, --quiet                  don't show file metadata
  -d, --dirs                   show directories only
  -s, --summary                show summary only
  -i, --include PATTERN        include paths matching a glob pattern
  -e, --exclude PATTERN        exclude paths matching a glob pattern
  -I, --include-regex PATTERN  include paths matching a regular expression
  -E, --exclude-regex PATTERN  exclude paths matching a regular expression
  -D, --depth DEPTH            limit levels displayed below starting directory
```

The other major update is the switch to [Gitoxide][gitoxide-home] (`gix`) for
evaluating `.gitignore` rules, replacing repeated calls to the Git executable in
a subprocess. This makes scanning deeply nested Git repositories much faster and
allows `treex` to process ignore rules even when Git isn't installed.

You can install `treex` from [PyPI][pypi-home]. Prebuilt installation packages
are available for Python `3.13+` on Linux, macOS, and Windows, covering common
architectures. To install from the [source distribution][pypi-files] or
[source repository][github-repo], or on other platforms without a prebuilt
package, you'll need a [Rust toolchain][rust-install].

[announcement-post]: /posts/treex-cli/
[github-repo]: https://github.com/cgoldberg/treex
[gitoxide-home]: https://rustutils.com/tools/gitoxide
[pypi-home]: https://pypi.org/project/treex-cli
[rust-install]: https://www.rust-lang.org/tools/install
