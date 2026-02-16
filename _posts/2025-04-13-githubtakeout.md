---
title: githubtakeout - Export and Archive GitHub Repos
description: Data export tool for archiving Git repositories and gists
date: 2025-04-13
tags: [programming, python, github]
---

I wrote a simple Python CLI for exporting Git repos from GitHub. It clones
repos for a given account and compresses them as zip/tar.gz archives. It
supports authentication, public/private repos, public/secret gists, and
various filtering options.

Available on [PyPI][pypi].

For more informationm, visit the GitHub project:
[https://github.com/cgoldberg/githubtakeout][github]

## CLI Options:

```console
$ githubtakeout --help
usage: githubtakeout [-h] [--dir DIR] [--pattern PATTERN] [--skip_pattern PATTERN]
                     [--format {tar,zip,none}] [--gists] [--history]
                     [--skip_forks] [--keep] [--list] [--token]
                     username

positional arguments:
  username                 github username

options:
  -h, --help               show this help message and exit
  --dir DIR                output directory (default: .)
  --pattern PATTERN        regex matching repo names to include
  --skip_pattern PATTERN   regex matching repo names to skip
  --format {tar,zip,none}  archive format (default: zip)
  --gists                  include gists
  --history                include commit history and branches (.git directory)
  --skip_forks             skip repos that are forks
  --keep                   keep repos after archiving
  --list                   list repos only
  --token                  prompt for auth token
```

## Screenshot:

![githubtakeout screenshot](/assets/img/posts/2025-04-13_githubtakeout_screenshot.png)

[pypi]: https://pypi.org/project/githubtakeout
[github]:  https://github.com/cgoldberg/githubtakeout
