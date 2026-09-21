---
title: githubtakeout - Export and Archive GitHub Repos
description: Export tool for archiving Git repositories and gists
date: 2025-04-13
tags: [programming, python, git, github, command line, open source]
---

I wrote a command-line utility in Python for exporting Git repos from
GitHub. It clones repos for a given account and compresses them as
zip/tar.gz archives. It supports authentication, public/private repos,
public/secret gists, and various filtering options.

You can install `githubtakeout` from [PyPI][pypi-home], and follow development
on [GitHub][github-repo] ([MIT licensed][mit-license]).

## Usage:

```
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

[pypi-home]: https://pypi.org/project/githubtakeout
[github-repo]: https://github.com/cgoldberg/githubtakeout
[mit-license]: https://raw.githubusercontent.com/cgoldberg/githubtakeout/refs/heads/main/LICENSE
