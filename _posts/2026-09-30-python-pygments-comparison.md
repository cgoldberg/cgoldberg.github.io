---
title: Comparing Pygments Syntax Highlighting Styles
description: Python script to generate HTML previews of installed Pygments styles
date: 2026-09-30
tags: [programming, python]
---

[Pygments](https://pygments.org) is a Python library for syntax highlighting
that is used by [Sphinx](https://www.sphinx-doc.org) and other documentation
and code-rendering tools.

I wrote a small script that renders the same Python
snippet using each Pygments style available in the current environment and
generates an HTML gallery. Since the available styles can vary between
environments, this provides simple way to see exactly which styles are
available and compare them side-by-side in a browser.

```python
#!/usr/bin/env python3
#
# Corey Goldberg 2026 (https://github.com/cgoldberg)

"""Generate an HTML gallery of all installed Pygments styles.

Each installed Pygments style is rendered using the same small Python
snippet, allowing syntax-highlighting styles to be compared visually.

The generated `pygments-styles.html` file can be opened directly in a
web browser.

Usage:
    python compare_pygments_styles.py
"""

from pathlib import Path

import pygments
from pygments import highlight
from pygments.formatters import HtmlFormatter
from pygments.lexers import PythonLexer
from pygments.styles import get_all_styles

code_snippet = """\
from dataclasses import dataclass


@dataclass
class User:
    name: str
    active: bool = True

    def greet(self) -> str:
        return f"Hello, {self.name}!"
"""

html = """\
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pygments Style Comparison</title>
    <link
        rel="stylesheet"
        href="https://fonts.googleapis.com/css2?family=Roboto&display=swap">
    <link
        rel="stylesheet"
        href="https://fonts.googleapis.com/css2?family=Roboto+Mono&display=swap">
    <style>
        body {
            margin: 0;
            padding: 48px 32px;
            background: #f8f9fb;
            color: #24292f;
            font-family: "Roboto", sans-serif;
        }
        .page-header {
            width: 580px;
            margin: 0 auto 40px;
        }
        .page-header h1 {
            margin: 0 0 8px;
            font-size: 28px;
        }
        .page-header p {
            margin: 0;
            color: #6b7280;
        }
        .example {
            width: 520px;
            margin: 0 auto 32px;
            overflow: hidden;
            background: white;
            border: 1px solid #d9dee5;
            border-radius: 10px;
            box-shadow: 0 2px 6px rgb(0 0 0 / 4%);
        }
        .example-header {
            padding: 12px 18px;
            background: #f3f4f6;
            border-bottom: 1px solid #d9dee5;
            color: #374151;
            font-size: 20px;
        }
        .code {
            overflow-x: auto;
        }
        .code pre {
            margin: 0;
            padding: 20px 22px;
            font-family: "Roboto Mono", monospace;
            font-size: 15px;
            line-height: 1.6;
        }
    </style>
</head>
"""

html += f"""\
<body>
    <div class="page-header">
        <h1>Pygments Styles</h1>
        <p>All installed styles · Pygments {pygments.__version__}</p>
    </div>
"""

styles = sorted(set(get_all_styles()))

for style in styles:
    css_class = f"highlight-{style}"
    formatter = HtmlFormatter(style=style, cssclass=css_class)
    highlighted = highlight(code_snippet, PythonLexer(), formatter)
    css = formatter.get_style_defs(f".{css_class}")
    html += f"""\
    <style>
        {css}
    </style>
    <div class="example">
        <div class="example-header">{style}</div>
        <div class="code">
            {highlighted}
        </div>
    </div>
    """

html += """\
</body>
</html>
"""

if __name__ == "__main__":
    out = "pygments-styles.html"
    Path(out).write_text(html, encoding="utf-8")
    print(f"Generated {len(styles)} styles in {out}")
```
{: file='compare_pygments_styles.py'}
