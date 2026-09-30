---
title: Unicode Gotcha
description: When identical looking strings aren't identical
date: 2026-09-22
tags: [programming, python, testing]
---

Here's a surprising testing gotcha I ran into today:

Consider this Python function that removes all characters from a string except
ASCII letters (`A-Z` and `a-z`):

```python
def strip_non_letters(s):
    return re.sub(r"[^A-Za-z]+", "", s)
```

These two tests look like they should behave identically:

```python
def test_strip1():
    assert strip_non_letters("André") == "Andr"

def test_strip2():
    assert strip_non_letters("André") == "Andr"
```

But the first test passes while the second test fails. Why?

The strings look identical, but they aren't.

In `André`, the `é` is a single Unicode code point: `U+00E9`.

In `André`, what looks like `é` is actually two Unicode code points: `U+0065`
(`e`) + `U+0301` (combining mark):

- `e + ◌́`

Our function only keeps `A-Z` and `a-z`, so:

- `André` → `Andr`
- `André` → `Andre`

The `e` in the second test survives because it's an ASCII letter. Only the
combining mark (acute accent) gets removed.

This is just one example. Unicode contains many characters and character
sequences that can look visually identical or nearly identical while having
different underlying representations.

**The takeaway**: strings that look identical can contain different underlying
characters. When processing text, we operate on those actual characters, not on
how the text appears visually.
