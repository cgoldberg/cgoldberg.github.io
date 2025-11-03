---
title: Command Line Utilities
description: Making life in the terminal better
date: 2025-11-03
tags: [linux, bash]
---

I started using the command line over 30 years ago for navigating my operating system and basic scripting. My shell progression was:

1. [MS-DOS](https://wikipedia.org/wiki/MS-DOS) - hobby prgramming
2. [C shell](https://wikipedia.org/wiki/C_shell) on [BSD Unix](https://wikipedia.org/wiki/Berkeley_Software_Distribution) - university
3. [Korn shell](https://wikipedia.org/wiki/KornShell) on [SunOS/Solaris](https://wikipedia.org/wiki/Solaris) - early career
4. [Bash](https://wikipedia.org/wiki/Bash_(Unix_shell)) on [Linux](https://wikipedia.org/wiki/Linux) (and now Windows) - everything since

These days, I spend the majority of my time in the terminal. I use Bash shell inside [Alacritty](https://alacritty.org) or [GNOME Terminal](https://wikipedia.org/wiki/GNOME_Terminal) with a pretty [customized configuration](https://github.com/cgoldberg/dotfiles) (lots of aliases and functions).

It's pretty amazing how many things invented in the early days of Unix are still so useful today. However, there are lots of modern utilities that make using a terminal easier and faster.

Here are my go-to utilities that make life much better:

- [ripgrep](https://github.com/BurntSushi/ripgrep) - a better grep
- [fd](https://github.com/sharkdp/fd) - a better find
- [eza](https://github.com/eza-community/eza) - a better ls
- [bat](https://github.com/sharkdp/bat) - a better cat
- [zoxide](https://github.com/ajeetdsouza/zoxide) - jump to directories
- [fzf](https://github.com/junegunn/fzf) - fuzzy finder

All of these are cross-platform and work in all POSIX (and some not-so-POSIX) shells.
