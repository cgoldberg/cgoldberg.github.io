---
title: Git - Named Stashes
description: Git aliases to save and pop stashes by name
date: 2026-04-04
tags: [git]
---

Here are some handy [Git](https://git-scm.com) [aliases](https://git-scm.com/book/en/v2/Git-Basics-Git-Aliases) I am using to save and pop stashes by name:

```ini
[alias]

    # save a stash with a custom name
    stash-save = "!f() { \
        if [ -z \"$*\" ]; then \
            echo \"Error: stash name required\" >&2; \
            return 1; \
        fi; \
        git stash push -m \"$*\"; \
    }; f"

    # pop a stash by its name/message (uses first stash matching partial name)
    stash-pop = "!f() { \
        if [ -z \"$*\" ]; then \
            echo \"Error: stash name required\" >&2; \
            return 1; \
        fi; \
        ref=$(git stash list | grep -F \"$*\" | cut -d: -f1 | head -n1); \
        if [ -n \"$ref\" ]; then \
            git stash pop \"$ref\"; \
        else \
            echo \"Error: no matching stash found\" >&2; \
            return 1; \
        fi; \
    }; f"
```
{: file='.gitconfig'}

Note: requires a shell with compatible tools: `grep`/`cut`/`head`

### Example usage:

save/pop a stash by full name:

```console
$ git stash-save My cool stash
Saved working directory and index state On main: My cool stash
$ git stash list
stash@{0}: On main: My cool stash
$ git stash-pop My cool stash
```

save/pop a stash by partial name:

```console
$ git stash-save FooBarBaz
Saved working directory and index state On main: FooBarBaz
$ git stash-pop Foo
```

save stash with no name:

```console
$ git stash-save
Error: stash name required
```

pop stash with invalid name:

```console
$ g stash-pop Wrong name
Error: no matching stash found
```
