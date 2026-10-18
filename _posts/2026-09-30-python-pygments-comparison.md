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

### Generate the Pygments Style Gallery

Python script to generate the HTML gallery:

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


## Rendered Output

<style>
.pygments-gallery {
    box-sizing: border-box;
    margin: 0;
    padding: 48px 32px;
    background: #f8f9fb;
    color: #24292f;
    font-family: Arial, Helvetica, sans-serif;
}
.pygments-gallery *,
.pygments-gallery *::before,
.pygments-gallery *::after { box-sizing: border-box; }
.pygments-gallery .page-header { width: min(580px, 100%); margin: 0 auto 40px; }
.pygments-gallery .page-header h1 { margin: 0 0 8px; font-size: 28px; }
.pygments-gallery .page-header p { margin: 0; color: #6b7280; }
.pygments-gallery .example {
    width: min(520px, 100%); margin: 0 auto 32px; overflow: hidden;
    background: #fff; border: 1px solid #d9dee5; border-radius: 10px;
    box-shadow: 0 2px 6px rgb(0 0 0 / 4%);
}
.pygments-gallery .example-header {
    padding: 12px 18px; background: #f3f4f6; border-bottom: 1px solid #d9dee5;
    color: #374151; font-size: 20px;
}
.pygments-gallery .code { overflow-x: auto; }
.pygments-gallery .code pre {
    margin: 0; padding: 20px 22px; font-family: "SFMono-Regular", Consolas, "Liberation Mono", monospace;
    font-size: 15px; line-height: 1.6; white-space: pre;
}
@media (max-width: 600px) {
    .pygments-gallery { padding: 24px 12px; }
    .pygments-gallery .code pre { padding: 16px; font-size: 13px; }
}

/* Consolidated Pygments token rules; theme classes are preserved. */
.pygments-gallery pre { line-height: 125%; }
.pygments-gallery td.linenos .normal { color: #5d6262; background-color: #353535; padding-left: 5px; padding-right: 5px; }
.pygments-gallery span.linenos { color: #5d6262; background-color: #353535; padding-left: 5px; padding-right: 5px; }
.pygments-gallery td.linenos .special { color: #7a8080; background-color: #353535; padding-left: 5px; padding-right: 5px; }
.pygments-gallery span.linenos.special { color: #7a8080; background-color: #353535; padding-left: 5px; padding-right: 5px; }
.pygments-gallery .highlight-a11y-dark .hll { background-color: #ffd9002e }
.pygments-gallery .highlight-a11y-dark { background: #2b2b2b; color: #F8F8F2 }
.pygments-gallery .highlight-a11y-dark .c { color: #D4D0AB }
.pygments-gallery .highlight-a11y-dark .err { color: #FFA07A }
.pygments-gallery .highlight-a11y-dark .k { color: #DCC6E0 }
.pygments-gallery .highlight-a11y-dark .l { color: #F5AB35 }
.pygments-gallery .highlight-a11y-dark .n { color: #F8F8F2 }
.pygments-gallery .highlight-a11y-dark .o { color: #ABE338 }
.pygments-gallery .highlight-a11y-dark .p { color: #F8F8F2 }
.pygments-gallery .highlight-a11y-dark .ch { color: #D4D0AB }
.pygments-gallery .highlight-a11y-dark .cm { color: #D4D0AB }
.pygments-gallery .highlight-a11y-dark .cp { color: #D4D0AB }
.pygments-gallery .highlight-a11y-dark .cpf { color: #D4D0AB }
.pygments-gallery .highlight-a11y-dark .c1 { color: #D4D0AB }
.pygments-gallery .highlight-a11y-dark .cs { color: #D4D0AB }
.pygments-gallery .highlight-a11y-dark .gd { color: #00E0E0 }
.pygments-gallery .highlight-a11y-dark .ge { font-style: italic }
.pygments-gallery .highlight-a11y-dark .gh { color: #00E0E0 }
.pygments-gallery .highlight-a11y-dark .gs { font-weight: bold }
.pygments-gallery .highlight-a11y-dark .gu { color: #00E0E0 }
.pygments-gallery .highlight-a11y-dark .kc { color: #DCC6E0 }
.pygments-gallery .highlight-a11y-dark .kd { color: #DCC6E0 }
.pygments-gallery .highlight-a11y-dark .kn { color: #DCC6E0 }
.pygments-gallery .highlight-a11y-dark .kp { color: #DCC6E0 }
.pygments-gallery .highlight-a11y-dark .kr { color: #DCC6E0 }
.pygments-gallery .highlight-a11y-dark .kt { color: #F5AB35 }
.pygments-gallery .highlight-a11y-dark .ld { color: #F5AB35 }
.pygments-gallery .highlight-a11y-dark .m { color: #F5AB35 }
.pygments-gallery .highlight-a11y-dark .s { color: #ABE338 }
.pygments-gallery .highlight-a11y-dark .na { color: #FFD700 }
.pygments-gallery .highlight-a11y-dark .nb { color: #F5AB35 }
.pygments-gallery .highlight-a11y-dark .nc { color: #00E0E0 }
.pygments-gallery .highlight-a11y-dark .no { color: #00E0E0 }
.pygments-gallery .highlight-a11y-dark .nd { color: #F5AB35 }
.pygments-gallery .highlight-a11y-dark .ni { color: #ABE338 }
.pygments-gallery .highlight-a11y-dark .ne { color: #DCC6E0 }
.pygments-gallery .highlight-a11y-dark .nf { color: #00E0E0 }
.pygments-gallery .highlight-a11y-dark .nl { color: #F5AB35 }
.pygments-gallery .highlight-a11y-dark .nn { color: #F8F8F2 }
.pygments-gallery .highlight-a11y-dark .nx { color: #F8F8F2 }
.pygments-gallery .highlight-a11y-dark .py { color: #00E0E0 }
.pygments-gallery .highlight-a11y-dark .nt { color: #00E0E0 }
.pygments-gallery .highlight-a11y-dark .nv { color: #FFA07A }
.pygments-gallery .highlight-a11y-dark .ow { color: #DCC6E0 }
.pygments-gallery .highlight-a11y-dark .pm { color: #F8F8F2 }
.pygments-gallery .highlight-a11y-dark .w { color: #F8F8F2 }
.pygments-gallery .highlight-a11y-dark .mb { color: #F5AB35 }
.pygments-gallery .highlight-a11y-dark .mf { color: #F5AB35 }
.pygments-gallery .highlight-a11y-dark .mh { color: #F5AB35 }
.pygments-gallery .highlight-a11y-dark .mi { color: #F5AB35 }
.pygments-gallery .highlight-a11y-dark .mo { color: #F5AB35 }
.pygments-gallery .highlight-a11y-dark .sa { color: #ABE338 }
.pygments-gallery .highlight-a11y-dark .sb { color: #ABE338 }
.pygments-gallery .highlight-a11y-dark .sc { color: #ABE338 }
.pygments-gallery .highlight-a11y-dark .dl { color: #ABE338 }
.pygments-gallery .highlight-a11y-dark .sd { color: #ABE338 }
.pygments-gallery .highlight-a11y-dark .s2 { color: #ABE338 }
.pygments-gallery .highlight-a11y-dark .se { color: #ABE338 }
.pygments-gallery .highlight-a11y-dark .sh { color: #ABE338 }
.pygments-gallery .highlight-a11y-dark .si { color: #ABE338 }
.pygments-gallery .highlight-a11y-dark .sx { color: #ABE338 }
.pygments-gallery .highlight-a11y-dark .sr { color: #FFA07A }
.pygments-gallery .highlight-a11y-dark .s1 { color: #ABE338 }
.pygments-gallery .highlight-a11y-dark .ss { color: #00E0E0 }
.pygments-gallery .highlight-a11y-dark .bp { color: #F5AB35 }
.pygments-gallery .highlight-a11y-dark .fm { color: #00E0E0 }
.pygments-gallery .highlight-a11y-dark .vc { color: #FFA07A }
.pygments-gallery .highlight-a11y-dark .vg { color: #FFA07A }
.pygments-gallery .highlight-a11y-dark .vi { color: #FFA07A }
.pygments-gallery .highlight-a11y-dark .vm { color: #F5AB35 }
.pygments-gallery .highlight-a11y-dark .il { color: #F5AB35 }
.pygments-gallery .highlight-a11y-high-contrast-dark .hll { background-color: #ffd9002e }
.pygments-gallery .highlight-a11y-high-contrast-dark { background: #2b2b2b; color: #F8F8F2 }
.pygments-gallery .highlight-a11y-high-contrast-dark .c { color: #FFD900 }
.pygments-gallery .highlight-a11y-high-contrast-dark .err { color: #FFA07A }
.pygments-gallery .highlight-a11y-high-contrast-dark .k { color: #DCC6E0 }
.pygments-gallery .highlight-a11y-high-contrast-dark .l { color: #FFD900 }
.pygments-gallery .highlight-a11y-high-contrast-dark .n { color: #F8F8F2 }
.pygments-gallery .highlight-a11y-high-contrast-dark .o { color: #ABE338 }
.pygments-gallery .highlight-a11y-high-contrast-dark .p { color: #F8F8F2 }
.pygments-gallery .highlight-a11y-high-contrast-dark .ch { color: #FFD900 }
.pygments-gallery .highlight-a11y-high-contrast-dark .cm { color: #FFD900 }
.pygments-gallery .highlight-a11y-high-contrast-dark .cp { color: #FFD900 }
.pygments-gallery .highlight-a11y-high-contrast-dark .cpf { color: #FFD900 }
.pygments-gallery .highlight-a11y-high-contrast-dark .c1 { color: #FFD900 }
.pygments-gallery .highlight-a11y-high-contrast-dark .cs { color: #FFD900 }
.pygments-gallery .highlight-a11y-high-contrast-dark .gd { color: #00E0E0 }
.pygments-gallery .highlight-a11y-high-contrast-dark .ge { font-style: italic }
.pygments-gallery .highlight-a11y-high-contrast-dark .gh { color: #00E0E0 }
.pygments-gallery .highlight-a11y-high-contrast-dark .gs { font-weight: bold }
.pygments-gallery .highlight-a11y-high-contrast-dark .gu { color: #00E0E0 }
.pygments-gallery .highlight-a11y-high-contrast-dark .kc { color: #DCC6E0 }
.pygments-gallery .highlight-a11y-high-contrast-dark .kd { color: #DCC6E0 }
.pygments-gallery .highlight-a11y-high-contrast-dark .kn { color: #DCC6E0 }
.pygments-gallery .highlight-a11y-high-contrast-dark .kp { color: #DCC6E0 }
.pygments-gallery .highlight-a11y-high-contrast-dark .kr { color: #DCC6E0 }
.pygments-gallery .highlight-a11y-high-contrast-dark .kt { color: #FFD900 }
.pygments-gallery .highlight-a11y-high-contrast-dark .ld { color: #FFD900 }
.pygments-gallery .highlight-a11y-high-contrast-dark .m { color: #FFD900 }
.pygments-gallery .highlight-a11y-high-contrast-dark .s { color: #ABE338 }
.pygments-gallery .highlight-a11y-high-contrast-dark .na { color: #FFD900 }
.pygments-gallery .highlight-a11y-high-contrast-dark .nb { color: #FFD900 }
.pygments-gallery .highlight-a11y-high-contrast-dark .nc { color: #00E0E0 }
.pygments-gallery .highlight-a11y-high-contrast-dark .no { color: #00E0E0 }
.pygments-gallery .highlight-a11y-high-contrast-dark .nd { color: #FFD900 }
.pygments-gallery .highlight-a11y-high-contrast-dark .ni { color: #ABE338 }
.pygments-gallery .highlight-a11y-high-contrast-dark .ne { color: #DCC6E0 }
.pygments-gallery .highlight-a11y-high-contrast-dark .nf { color: #00E0E0 }
.pygments-gallery .highlight-a11y-high-contrast-dark .nl { color: #FFD900 }
.pygments-gallery .highlight-a11y-high-contrast-dark .nn { color: #F8F8F2 }
.pygments-gallery .highlight-a11y-high-contrast-dark .nx { color: #F8F8F2 }
.pygments-gallery .highlight-a11y-high-contrast-dark .py { color: #00E0E0 }
.pygments-gallery .highlight-a11y-high-contrast-dark .nt { color: #00E0E0 }
.pygments-gallery .highlight-a11y-high-contrast-dark .nv { color: #FFA07A }
.pygments-gallery .highlight-a11y-high-contrast-dark .ow { color: #DCC6E0 }
.pygments-gallery .highlight-a11y-high-contrast-dark .pm { color: #F8F8F2 }
.pygments-gallery .highlight-a11y-high-contrast-dark .w { color: #F8F8F2 }
.pygments-gallery .highlight-a11y-high-contrast-dark .mb { color: #FFD900 }
.pygments-gallery .highlight-a11y-high-contrast-dark .mf { color: #FFD900 }
.pygments-gallery .highlight-a11y-high-contrast-dark .mh { color: #FFD900 }
.pygments-gallery .highlight-a11y-high-contrast-dark .mi { color: #FFD900 }
.pygments-gallery .highlight-a11y-high-contrast-dark .mo { color: #FFD900 }
.pygments-gallery .highlight-a11y-high-contrast-dark .sa { color: #ABE338 }
.pygments-gallery .highlight-a11y-high-contrast-dark .sb { color: #ABE338 }
.pygments-gallery .highlight-a11y-high-contrast-dark .sc { color: #ABE338 }
.pygments-gallery .highlight-a11y-high-contrast-dark .dl { color: #ABE338 }
.pygments-gallery .highlight-a11y-high-contrast-dark .sd { color: #ABE338 }
.pygments-gallery .highlight-a11y-high-contrast-dark .s2 { color: #ABE338 }
.pygments-gallery .highlight-a11y-high-contrast-dark .se { color: #ABE338 }
.pygments-gallery .highlight-a11y-high-contrast-dark .sh { color: #ABE338 }
.pygments-gallery .highlight-a11y-high-contrast-dark .si { color: #ABE338 }
.pygments-gallery .highlight-a11y-high-contrast-dark .sx { color: #ABE338 }
.pygments-gallery .highlight-a11y-high-contrast-dark .sr { color: #FFA07A }
.pygments-gallery .highlight-a11y-high-contrast-dark .s1 { color: #ABE338 }
.pygments-gallery .highlight-a11y-high-contrast-dark .ss { color: #00E0E0 }
.pygments-gallery .highlight-a11y-high-contrast-dark .bp { color: #FFD900 }
.pygments-gallery .highlight-a11y-high-contrast-dark .fm { color: #00E0E0 }
.pygments-gallery .highlight-a11y-high-contrast-dark .vc { color: #FFA07A }
.pygments-gallery .highlight-a11y-high-contrast-dark .vg { color: #FFA07A }
.pygments-gallery .highlight-a11y-high-contrast-dark .vi { color: #FFA07A }
.pygments-gallery .highlight-a11y-high-contrast-dark .vm { color: #FFD900 }
.pygments-gallery .highlight-a11y-high-contrast-dark .il { color: #FFD900 }
.pygments-gallery .highlight-a11y-high-contrast-light .hll { background-color: #fae4c2 }
.pygments-gallery .highlight-a11y-high-contrast-light { background: #fefefe; color: #080808 }
.pygments-gallery .highlight-a11y-high-contrast-light .c { color: #515151 }
.pygments-gallery .highlight-a11y-high-contrast-light .err { color: #A12236 }
.pygments-gallery .highlight-a11y-high-contrast-light .k { color: #6730C5 }
.pygments-gallery .highlight-a11y-high-contrast-light .l { color: #7F4707 }
.pygments-gallery .highlight-a11y-high-contrast-light .n { color: #080808 }
.pygments-gallery .highlight-a11y-high-contrast-light .o { color: #00622F }
.pygments-gallery .highlight-a11y-high-contrast-light .p { color: #080808 }
.pygments-gallery .highlight-a11y-high-contrast-light .ch { color: #515151 }
.pygments-gallery .highlight-a11y-high-contrast-light .cm { color: #515151 }
.pygments-gallery .highlight-a11y-high-contrast-light .cp { color: #515151 }
.pygments-gallery .highlight-a11y-high-contrast-light .cpf { color: #515151 }
.pygments-gallery .highlight-a11y-high-contrast-light .c1 { color: #515151 }
.pygments-gallery .highlight-a11y-high-contrast-light .cs { color: #515151 }
.pygments-gallery .highlight-a11y-high-contrast-light .gd { color: #005B82 }
.pygments-gallery .highlight-a11y-high-contrast-light .ge { font-style: italic }
.pygments-gallery .highlight-a11y-high-contrast-light .gh { color: #005B82 }
.pygments-gallery .highlight-a11y-high-contrast-light .gs { font-weight: bold }
.pygments-gallery .highlight-a11y-high-contrast-light .gu { color: #005B82 }
.pygments-gallery .highlight-a11y-high-contrast-light .kc { color: #6730C5 }
.pygments-gallery .highlight-a11y-high-contrast-light .kd { color: #6730C5 }
.pygments-gallery .highlight-a11y-high-contrast-light .kn { color: #6730C5 }
.pygments-gallery .highlight-a11y-high-contrast-light .kp { color: #6730C5 }
.pygments-gallery .highlight-a11y-high-contrast-light .kr { color: #6730C5 }
.pygments-gallery .highlight-a11y-high-contrast-light .kt { color: #7F4707 }
.pygments-gallery .highlight-a11y-high-contrast-light .ld { color: #7F4707 }
.pygments-gallery .highlight-a11y-high-contrast-light .m { color: #7F4707 }
.pygments-gallery .highlight-a11y-high-contrast-light .s { color: #00622F }
.pygments-gallery .highlight-a11y-high-contrast-light .na { color: #912583 }
.pygments-gallery .highlight-a11y-high-contrast-light .nb { color: #7F4707 }
.pygments-gallery .highlight-a11y-high-contrast-light .nc { color: #005B82 }
.pygments-gallery .highlight-a11y-high-contrast-light .no { color: #005B82 }
.pygments-gallery .highlight-a11y-high-contrast-light .nd { color: #7F4707 }
.pygments-gallery .highlight-a11y-high-contrast-light .ni { color: #00622F }
.pygments-gallery .highlight-a11y-high-contrast-light .ne { color: #6730C5 }
.pygments-gallery .highlight-a11y-high-contrast-light .nf { color: #005B82 }
.pygments-gallery .highlight-a11y-high-contrast-light .nl { color: #7F4707 }
.pygments-gallery .highlight-a11y-high-contrast-light .nn { color: #080808 }
.pygments-gallery .highlight-a11y-high-contrast-light .nx { color: #080808 }
.pygments-gallery .highlight-a11y-high-contrast-light .py { color: #005B82 }
.pygments-gallery .highlight-a11y-high-contrast-light .nt { color: #005B82 }
.pygments-gallery .highlight-a11y-high-contrast-light .nv { color: #A12236 }
.pygments-gallery .highlight-a11y-high-contrast-light .ow { color: #6730C5 }
.pygments-gallery .highlight-a11y-high-contrast-light .pm { color: #080808 }
.pygments-gallery .highlight-a11y-high-contrast-light .w { color: #080808 }
.pygments-gallery .highlight-a11y-high-contrast-light .mb { color: #7F4707 }
.pygments-gallery .highlight-a11y-high-contrast-light .mf { color: #7F4707 }
.pygments-gallery .highlight-a11y-high-contrast-light .mh { color: #7F4707 }
.pygments-gallery .highlight-a11y-high-contrast-light .mi { color: #7F4707 }
.pygments-gallery .highlight-a11y-high-contrast-light .mo { color: #7F4707 }
.pygments-gallery .highlight-a11y-high-contrast-light .sa { color: #00622F }
.pygments-gallery .highlight-a11y-high-contrast-light .sb { color: #00622F }
.pygments-gallery .highlight-a11y-high-contrast-light .sc { color: #00622F }
.pygments-gallery .highlight-a11y-high-contrast-light .dl { color: #00622F }
.pygments-gallery .highlight-a11y-high-contrast-light .sd { color: #00622F }
.pygments-gallery .highlight-a11y-high-contrast-light .s2 { color: #00622F }
.pygments-gallery .highlight-a11y-high-contrast-light .se { color: #00622F }
.pygments-gallery .highlight-a11y-high-contrast-light .sh { color: #00622F }
.pygments-gallery .highlight-a11y-high-contrast-light .si { color: #00622F }
.pygments-gallery .highlight-a11y-high-contrast-light .sx { color: #00622F }
.pygments-gallery .highlight-a11y-high-contrast-light .sr { color: #A12236 }
.pygments-gallery .highlight-a11y-high-contrast-light .s1 { color: #00622F }
.pygments-gallery .highlight-a11y-high-contrast-light .ss { color: #005B82 }
.pygments-gallery .highlight-a11y-high-contrast-light .bp { color: #7F4707 }
.pygments-gallery .highlight-a11y-high-contrast-light .fm { color: #005B82 }
.pygments-gallery .highlight-a11y-high-contrast-light .vc { color: #A12236 }
.pygments-gallery .highlight-a11y-high-contrast-light .vg { color: #A12236 }
.pygments-gallery .highlight-a11y-high-contrast-light .vi { color: #A12236 }
.pygments-gallery .highlight-a11y-high-contrast-light .vm { color: #7F4707 }
.pygments-gallery .highlight-a11y-high-contrast-light .il { color: #7F4707 }
.pygments-gallery .highlight-a11y-light .hll { background-color: #fdf2e2 }
.pygments-gallery .highlight-a11y-light { background: #f2f2f2; color: #1E1E1E }
.pygments-gallery .highlight-a11y-light .c { color: #515151 }
.pygments-gallery .highlight-a11y-light .err { color: #D71835 }
.pygments-gallery .highlight-a11y-light .k { color: #8045E5 }
.pygments-gallery .highlight-a11y-light .l { color: #7F4707 }
.pygments-gallery .highlight-a11y-light .n { color: #1E1E1E }
.pygments-gallery .highlight-a11y-light .o { color: #163 }
.pygments-gallery .highlight-a11y-light .p { color: #1E1E1E }
.pygments-gallery .highlight-a11y-light .ch { color: #515151 }
.pygments-gallery .highlight-a11y-light .cm { color: #515151 }
.pygments-gallery .highlight-a11y-light .cp { color: #515151 }
.pygments-gallery .highlight-a11y-light .cpf { color: #515151 }
.pygments-gallery .highlight-a11y-light .c1 { color: #515151 }
.pygments-gallery .highlight-a11y-light .cs { color: #515151 }
.pygments-gallery .highlight-a11y-light .gd { color: #00749C }
.pygments-gallery .highlight-a11y-light .ge { font-style: italic }
.pygments-gallery .highlight-a11y-light .gh { color: #00749C }
.pygments-gallery .highlight-a11y-light .gs { font-weight: bold }
.pygments-gallery .highlight-a11y-light .gu { color: #00749C }
.pygments-gallery .highlight-a11y-light .kc { color: #8045E5 }
.pygments-gallery .highlight-a11y-light .kd { color: #8045E5 }
.pygments-gallery .highlight-a11y-light .kn { color: #8045E5 }
.pygments-gallery .highlight-a11y-light .kp { color: #8045E5 }
.pygments-gallery .highlight-a11y-light .kr { color: #8045E5 }
.pygments-gallery .highlight-a11y-light .kt { color: #7F4707 }
.pygments-gallery .highlight-a11y-light .ld { color: #7F4707 }
.pygments-gallery .highlight-a11y-light .m { color: #7F4707 }
.pygments-gallery .highlight-a11y-light .s { color: #163 }
.pygments-gallery .highlight-a11y-light .na { color: #7F4707 }
.pygments-gallery .highlight-a11y-light .nb { color: #7F4707 }
.pygments-gallery .highlight-a11y-light .nc { color: #00749C }
.pygments-gallery .highlight-a11y-light .no { color: #00749C }
.pygments-gallery .highlight-a11y-light .nd { color: #7F4707 }
.pygments-gallery .highlight-a11y-light .ni { color: #163 }
.pygments-gallery .highlight-a11y-light .ne { color: #8045E5 }
.pygments-gallery .highlight-a11y-light .nf { color: #00749C }
.pygments-gallery .highlight-a11y-light .nl { color: #7F4707 }
.pygments-gallery .highlight-a11y-light .nn { color: #1E1E1E }
.pygments-gallery .highlight-a11y-light .nx { color: #1E1E1E }
.pygments-gallery .highlight-a11y-light .py { color: #00749C }
.pygments-gallery .highlight-a11y-light .nt { color: #00749C }
.pygments-gallery .highlight-a11y-light .nv { color: #D71835 }
.pygments-gallery .highlight-a11y-light .ow { color: #8045E5 }
.pygments-gallery .highlight-a11y-light .pm { color: #1E1E1E }
.pygments-gallery .highlight-a11y-light .w { color: #1E1E1E }
.pygments-gallery .highlight-a11y-light .mb { color: #7F4707 }
.pygments-gallery .highlight-a11y-light .mf { color: #7F4707 }
.pygments-gallery .highlight-a11y-light .mh { color: #7F4707 }
.pygments-gallery .highlight-a11y-light .mi { color: #7F4707 }
.pygments-gallery .highlight-a11y-light .mo { color: #7F4707 }
.pygments-gallery .highlight-a11y-light .sa { color: #163 }
.pygments-gallery .highlight-a11y-light .sb { color: #163 }
.pygments-gallery .highlight-a11y-light .sc { color: #163 }
.pygments-gallery .highlight-a11y-light .dl { color: #163 }
.pygments-gallery .highlight-a11y-light .sd { color: #163 }
.pygments-gallery .highlight-a11y-light .s2 { color: #163 }
.pygments-gallery .highlight-a11y-light .se { color: #163 }
.pygments-gallery .highlight-a11y-light .sh { color: #163 }
.pygments-gallery .highlight-a11y-light .si { color: #163 }
.pygments-gallery .highlight-a11y-light .sx { color: #163 }
.pygments-gallery .highlight-a11y-light .sr { color: #D71835 }
.pygments-gallery .highlight-a11y-light .s1 { color: #163 }
.pygments-gallery .highlight-a11y-light .ss { color: #00749C }
.pygments-gallery .highlight-a11y-light .bp { color: #7F4707 }
.pygments-gallery .highlight-a11y-light .fm { color: #00749C }
.pygments-gallery .highlight-a11y-light .vc { color: #D71835 }
.pygments-gallery .highlight-a11y-light .vg { color: #D71835 }
.pygments-gallery .highlight-a11y-light .vi { color: #D71835 }
.pygments-gallery .highlight-a11y-light .vm { color: #7F4707 }
.pygments-gallery .highlight-a11y-light .il { color: #7F4707 }
.pygments-gallery .highlight-abap .hll { background-color: #ffffcc }
.pygments-gallery .highlight-abap { background: #ffffff; }
.pygments-gallery .highlight-abap .c { color: #888; font-style: italic }
.pygments-gallery .highlight-abap .err { color: #F00 }
.pygments-gallery .highlight-abap .k { color: #00F }
.pygments-gallery .highlight-abap .n { color: #000 }
.pygments-gallery .highlight-abap .ch { color: #888; font-style: italic }
.pygments-gallery .highlight-abap .cm { color: #888; font-style: italic }
.pygments-gallery .highlight-abap .cp { color: #888; font-style: italic }
.pygments-gallery .highlight-abap .cpf { color: #888; font-style: italic }
.pygments-gallery .highlight-abap .c1 { color: #888; font-style: italic }
.pygments-gallery .highlight-abap .cs { color: #888; font-style: italic }
.pygments-gallery .highlight-abap .kc { color: #00F }
.pygments-gallery .highlight-abap .kd { color: #00F }
.pygments-gallery .highlight-abap .kn { color: #00F }
.pygments-gallery .highlight-abap .kp { color: #00F }
.pygments-gallery .highlight-abap .kr { color: #00F }
.pygments-gallery .highlight-abap .kt { color: #00F }
.pygments-gallery .highlight-abap .m { color: #3AF }
.pygments-gallery .highlight-abap .s { color: #5A2 }
.pygments-gallery .highlight-abap .na { color: #000 }
.pygments-gallery .highlight-abap .nb { color: #000 }
.pygments-gallery .highlight-abap .nc { color: #000 }
.pygments-gallery .highlight-abap .no { color: #000 }
.pygments-gallery .highlight-abap .nd { color: #000 }
.pygments-gallery .highlight-abap .ni { color: #000 }
.pygments-gallery .highlight-abap .ne { color: #000 }
.pygments-gallery .highlight-abap .nf { color: #000 }
.pygments-gallery .highlight-abap .nl { color: #000 }
.pygments-gallery .highlight-abap .nn { color: #000 }
.pygments-gallery .highlight-abap .nx { color: #000 }
.pygments-gallery .highlight-abap .py { color: #000 }
.pygments-gallery .highlight-abap .nt { color: #000 }
.pygments-gallery .highlight-abap .nv { color: #000 }
.pygments-gallery .highlight-abap .ow { color: #00F }
.pygments-gallery .highlight-abap .mb { color: #3AF }
.pygments-gallery .highlight-abap .mf { color: #3AF }
.pygments-gallery .highlight-abap .mh { color: #3AF }
.pygments-gallery .highlight-abap .mi { color: #3AF }
.pygments-gallery .highlight-abap .mo { color: #3AF }
.pygments-gallery .highlight-abap .sa { color: #5A2 }
.pygments-gallery .highlight-abap .sb { color: #5A2 }
.pygments-gallery .highlight-abap .sc { color: #5A2 }
.pygments-gallery .highlight-abap .dl { color: #5A2 }
.pygments-gallery .highlight-abap .sd { color: #5A2 }
.pygments-gallery .highlight-abap .s2 { color: #5A2 }
.pygments-gallery .highlight-abap .se { color: #5A2 }
.pygments-gallery .highlight-abap .sh { color: #5A2 }
.pygments-gallery .highlight-abap .si { color: #5A2 }
.pygments-gallery .highlight-abap .sx { color: #5A2 }
.pygments-gallery .highlight-abap .sr { color: #5A2 }
.pygments-gallery .highlight-abap .s1 { color: #5A2 }
.pygments-gallery .highlight-abap .ss { color: #5A2 }
.pygments-gallery .highlight-abap .bp { color: #000 }
.pygments-gallery .highlight-abap .fm { color: #000 }
.pygments-gallery .highlight-abap .vc { color: #000 }
.pygments-gallery .highlight-abap .vg { color: #000 }
.pygments-gallery .highlight-abap .vi { color: #000 }
.pygments-gallery .highlight-abap .vm { color: #000 }
.pygments-gallery .highlight-abap .il { color: #3AF }
.pygments-gallery .highlight-algol .hll { background-color: #ffffcc }
.pygments-gallery .highlight-algol { background: #ffffff; }
.pygments-gallery .highlight-algol .c { color: #888; font-style: italic }
.pygments-gallery .highlight-algol .err { border: 1px solid #F00 }
.pygments-gallery .highlight-algol .k { font-weight: bold; text-decoration: underline }
.pygments-gallery .highlight-algol .ch { color: #888; font-style: italic }
.pygments-gallery .highlight-algol .cm { color: #888; font-style: italic }
.pygments-gallery .highlight-algol .cp { color: #888; font-weight: bold }
.pygments-gallery .highlight-algol .cpf { color: #888; font-style: italic }
.pygments-gallery .highlight-algol .c1 { color: #888; font-style: italic }
.pygments-gallery .highlight-algol .cs { color: #888; font-weight: bold }
.pygments-gallery .highlight-algol .kc { font-weight: bold; text-decoration: underline }
.pygments-gallery .highlight-algol .kd { font-weight: bold; font-style: italic; text-decoration: underline }
.pygments-gallery .highlight-algol .kn { font-weight: bold; text-decoration: underline }
.pygments-gallery .highlight-algol .kp { font-weight: bold; text-decoration: underline }
.pygments-gallery .highlight-algol .kr { font-weight: bold; text-decoration: underline }
.pygments-gallery .highlight-algol .kt { font-weight: bold; text-decoration: underline }
.pygments-gallery .highlight-algol .s { color: #666; font-style: italic }
.pygments-gallery .highlight-algol .nb { font-weight: bold; font-style: italic }
.pygments-gallery .highlight-algol .nc { color: #666; font-weight: bold; font-style: italic }
.pygments-gallery .highlight-algol .no { color: #666; font-weight: bold; font-style: italic }
.pygments-gallery .highlight-algol .nf { color: #666; font-weight: bold; font-style: italic }
.pygments-gallery .highlight-algol .nn { color: #666; font-weight: bold; font-style: italic }
.pygments-gallery .highlight-algol .nv { color: #666; font-weight: bold; font-style: italic }
.pygments-gallery .highlight-algol .ow { font-weight: bold }
.pygments-gallery .highlight-algol .sa { color: #666; font-style: italic }
.pygments-gallery .highlight-algol .sb { color: #666; font-style: italic }
.pygments-gallery .highlight-algol .sc { color: #666; font-style: italic }
.pygments-gallery .highlight-algol .dl { color: #666; font-style: italic }
.pygments-gallery .highlight-algol .sd { color: #666; font-style: italic }
.pygments-gallery .highlight-algol .s2 { color: #666; font-style: italic }
.pygments-gallery .highlight-algol .se { color: #666; font-style: italic }
.pygments-gallery .highlight-algol .sh { color: #666; font-style: italic }
.pygments-gallery .highlight-algol .si { color: #666; font-style: italic }
.pygments-gallery .highlight-algol .sx { color: #666; font-style: italic }
.pygments-gallery .highlight-algol .sr { color: #666; font-style: italic }
.pygments-gallery .highlight-algol .s1 { color: #666; font-style: italic }
.pygments-gallery .highlight-algol .ss { color: #666; font-style: italic }
.pygments-gallery .highlight-algol .bp { font-weight: bold; font-style: italic }
.pygments-gallery .highlight-algol .fm { color: #666; font-weight: bold; font-style: italic }
.pygments-gallery .highlight-algol .vc { color: #666; font-weight: bold; font-style: italic }
.pygments-gallery .highlight-algol .vg { color: #666; font-weight: bold; font-style: italic }
.pygments-gallery .highlight-algol .vi { color: #666; font-weight: bold; font-style: italic }
.pygments-gallery .highlight-algol .vm { color: #666; font-weight: bold; font-style: italic }
.pygments-gallery .highlight-algol_nu .hll { background-color: #ffffcc }
.pygments-gallery .highlight-algol_nu { background: #ffffff; }
.pygments-gallery .highlight-algol_nu .c { color: #888; font-style: italic }
.pygments-gallery .highlight-algol_nu .err { border: 1px solid #F00 }
.pygments-gallery .highlight-algol_nu .k { font-weight: bold }
.pygments-gallery .highlight-algol_nu .ch { color: #888; font-style: italic }
.pygments-gallery .highlight-algol_nu .cm { color: #888; font-style: italic }
.pygments-gallery .highlight-algol_nu .cp { color: #888; font-weight: bold }
.pygments-gallery .highlight-algol_nu .cpf { color: #888; font-style: italic }
.pygments-gallery .highlight-algol_nu .c1 { color: #888; font-style: italic }
.pygments-gallery .highlight-algol_nu .cs { color: #888; font-weight: bold }
.pygments-gallery .highlight-algol_nu .kc { font-weight: bold }
.pygments-gallery .highlight-algol_nu .kd { font-weight: bold; font-style: italic }
.pygments-gallery .highlight-algol_nu .kn { font-weight: bold }
.pygments-gallery .highlight-algol_nu .kp { font-weight: bold }
.pygments-gallery .highlight-algol_nu .kr { font-weight: bold }
.pygments-gallery .highlight-algol_nu .kt { font-weight: bold }
.pygments-gallery .highlight-algol_nu .s { color: #666; font-style: italic }
.pygments-gallery .highlight-algol_nu .nb { font-weight: bold; font-style: italic }
.pygments-gallery .highlight-algol_nu .nc { color: #666; font-weight: bold; font-style: italic }
.pygments-gallery .highlight-algol_nu .no { color: #666; font-weight: bold; font-style: italic }
.pygments-gallery .highlight-algol_nu .nf { color: #666; font-weight: bold; font-style: italic }
.pygments-gallery .highlight-algol_nu .nn { color: #666; font-weight: bold; font-style: italic }
.pygments-gallery .highlight-algol_nu .nv { color: #666; font-weight: bold; font-style: italic }
.pygments-gallery .highlight-algol_nu .ow { font-weight: bold }
.pygments-gallery .highlight-algol_nu .sa { color: #666; font-style: italic }
.pygments-gallery .highlight-algol_nu .sb { color: #666; font-style: italic }
.pygments-gallery .highlight-algol_nu .sc { color: #666; font-style: italic }
.pygments-gallery .highlight-algol_nu .dl { color: #666; font-style: italic }
.pygments-gallery .highlight-algol_nu .sd { color: #666; font-style: italic }
.pygments-gallery .highlight-algol_nu .s2 { color: #666; font-style: italic }
.pygments-gallery .highlight-algol_nu .se { color: #666; font-style: italic }
.pygments-gallery .highlight-algol_nu .sh { color: #666; font-style: italic }
.pygments-gallery .highlight-algol_nu .si { color: #666; font-style: italic }
.pygments-gallery .highlight-algol_nu .sx { color: #666; font-style: italic }
.pygments-gallery .highlight-algol_nu .sr { color: #666; font-style: italic }
.pygments-gallery .highlight-algol_nu .s1 { color: #666; font-style: italic }
.pygments-gallery .highlight-algol_nu .ss { color: #666; font-style: italic }
.pygments-gallery .highlight-algol_nu .bp { font-weight: bold; font-style: italic }
.pygments-gallery .highlight-algol_nu .fm { color: #666; font-weight: bold; font-style: italic }
.pygments-gallery .highlight-algol_nu .vc { color: #666; font-weight: bold; font-style: italic }
.pygments-gallery .highlight-algol_nu .vg { color: #666; font-weight: bold; font-style: italic }
.pygments-gallery .highlight-algol_nu .vi { color: #666; font-weight: bold; font-style: italic }
.pygments-gallery .highlight-algol_nu .vm { color: #666; font-weight: bold; font-style: italic }
.pygments-gallery .highlight-arduino .hll { background-color: #ffffcc }
.pygments-gallery .highlight-arduino { background: #ffffff; }
.pygments-gallery .highlight-arduino .c { color: #95A5A6 }
.pygments-gallery .highlight-arduino .err { color: #A61717 }
.pygments-gallery .highlight-arduino .k { color: #728E00 }
.pygments-gallery .highlight-arduino .n { color: #434F54 }
.pygments-gallery .highlight-arduino .o { color: #728E00 }
.pygments-gallery .highlight-arduino .ch { color: #95A5A6 }
.pygments-gallery .highlight-arduino .cm { color: #95A5A6 }
.pygments-gallery .highlight-arduino .cp { color: #728E00 }
.pygments-gallery .highlight-arduino .cpf { color: #95A5A6 }
.pygments-gallery .highlight-arduino .c1 { color: #95A5A6 }
.pygments-gallery .highlight-arduino .cs { color: #95A5A6 }
.pygments-gallery .highlight-arduino .kc { color: #00979D }
.pygments-gallery .highlight-arduino .kd { color: #728E00 }
.pygments-gallery .highlight-arduino .kn { color: #728E00 }
.pygments-gallery .highlight-arduino .kp { color: #00979D }
.pygments-gallery .highlight-arduino .kr { color: #00979D }
.pygments-gallery .highlight-arduino .kt { color: #00979D }
.pygments-gallery .highlight-arduino .m { color: #8A7B52 }
.pygments-gallery .highlight-arduino .s { color: #7F8C8D }
.pygments-gallery .highlight-arduino .na { color: #434F54 }
.pygments-gallery .highlight-arduino .nb { color: #728E00 }
.pygments-gallery .highlight-arduino .nc { color: #434F54 }
.pygments-gallery .highlight-arduino .no { color: #434F54 }
.pygments-gallery .highlight-arduino .nd { color: #434F54 }
.pygments-gallery .highlight-arduino .ni { color: #434F54 }
.pygments-gallery .highlight-arduino .ne { color: #434F54 }
.pygments-gallery .highlight-arduino .nf { color: #D35400 }
.pygments-gallery .highlight-arduino .nl { color: #434F54 }
.pygments-gallery .highlight-arduino .nn { color: #434F54 }
.pygments-gallery .highlight-arduino .nx { color: #728E00 }
.pygments-gallery .highlight-arduino .py { color: #434F54 }
.pygments-gallery .highlight-arduino .nt { color: #434F54 }
.pygments-gallery .highlight-arduino .nv { color: #434F54 }
.pygments-gallery .highlight-arduino .ow { color: #728E00 }
.pygments-gallery .highlight-arduino .mb { color: #8A7B52 }
.pygments-gallery .highlight-arduino .mf { color: #8A7B52 }
.pygments-gallery .highlight-arduino .mh { color: #8A7B52 }
.pygments-gallery .highlight-arduino .mi { color: #8A7B52 }
.pygments-gallery .highlight-arduino .mo { color: #8A7B52 }
.pygments-gallery .highlight-arduino .sa { color: #7F8C8D }
.pygments-gallery .highlight-arduino .sb { color: #7F8C8D }
.pygments-gallery .highlight-arduino .sc { color: #7F8C8D }
.pygments-gallery .highlight-arduino .dl { color: #7F8C8D }
.pygments-gallery .highlight-arduino .sd { color: #7F8C8D }
.pygments-gallery .highlight-arduino .s2 { color: #7F8C8D }
.pygments-gallery .highlight-arduino .se { color: #7F8C8D }
.pygments-gallery .highlight-arduino .sh { color: #7F8C8D }
.pygments-gallery .highlight-arduino .si { color: #7F8C8D }
.pygments-gallery .highlight-arduino .sx { color: #7F8C8D }
.pygments-gallery .highlight-arduino .sr { color: #7F8C8D }
.pygments-gallery .highlight-arduino .s1 { color: #7F8C8D }
.pygments-gallery .highlight-arduino .ss { color: #7F8C8D }
.pygments-gallery .highlight-arduino .bp { color: #728E00 }
.pygments-gallery .highlight-arduino .fm { color: #D35400 }
.pygments-gallery .highlight-arduino .vc { color: #434F54 }
.pygments-gallery .highlight-arduino .vg { color: #434F54 }
.pygments-gallery .highlight-arduino .vi { color: #434F54 }
.pygments-gallery .highlight-arduino .vm { color: #434F54 }
.pygments-gallery .highlight-arduino .il { color: #8A7B52 }
.pygments-gallery .highlight-autumn .hll { background-color: #ffffcc }
.pygments-gallery .highlight-autumn { background: #ffffff; }
.pygments-gallery .highlight-autumn .c { color: #AAA; font-style: italic }
.pygments-gallery .highlight-autumn .err { color: #F00; background-color: #FAA }
.pygments-gallery .highlight-autumn .k { color: #00A }
.pygments-gallery .highlight-autumn .ch { color: #AAA; font-style: italic }
.pygments-gallery .highlight-autumn .cm { color: #AAA; font-style: italic }
.pygments-gallery .highlight-autumn .cp { color: #4C8317 }
.pygments-gallery .highlight-autumn .cpf { color: #AAA; font-style: italic }
.pygments-gallery .highlight-autumn .c1 { color: #AAA; font-style: italic }
.pygments-gallery .highlight-autumn .cs { color: #00A; font-style: italic }
.pygments-gallery .highlight-autumn .gd { color: #A00 }
.pygments-gallery .highlight-autumn .ge { font-style: italic }
.pygments-gallery .highlight-autumn .ges { font-weight: bold; font-style: italic }
.pygments-gallery .highlight-autumn .gr { color: #A00 }
.pygments-gallery .highlight-autumn .gh { color: #000080; font-weight: bold }
.pygments-gallery .highlight-autumn .gi { color: #0A0 }
.pygments-gallery .highlight-autumn .go { color: #888 }
.pygments-gallery .highlight-autumn .gp { color: #555 }
.pygments-gallery .highlight-autumn .gs { font-weight: bold }
.pygments-gallery .highlight-autumn .gu { color: #800080; font-weight: bold }
.pygments-gallery .highlight-autumn .gt { color: #A00 }
.pygments-gallery .highlight-autumn .kc { color: #00A }
.pygments-gallery .highlight-autumn .kd { color: #00A }
.pygments-gallery .highlight-autumn .kn { color: #00A }
.pygments-gallery .highlight-autumn .kp { color: #00A }
.pygments-gallery .highlight-autumn .kr { color: #00A }
.pygments-gallery .highlight-autumn .kt { color: #0AA }
.pygments-gallery .highlight-autumn .m { color: #099 }
.pygments-gallery .highlight-autumn .s { color: #A50 }
.pygments-gallery .highlight-autumn .na { color: #1E90FF }
.pygments-gallery .highlight-autumn .nb { color: #0AA }
.pygments-gallery .highlight-autumn .nc { color: #0A0; text-decoration: underline }
.pygments-gallery .highlight-autumn .no { color: #A00 }
.pygments-gallery .highlight-autumn .nd { color: #888 }
.pygments-gallery .highlight-autumn .ni { color: #800; font-weight: bold }
.pygments-gallery .highlight-autumn .nf { color: #0A0 }
.pygments-gallery .highlight-autumn .nn { color: #0AA; text-decoration: underline }
.pygments-gallery .highlight-autumn .nt { color: #1E90FF; font-weight: bold }
.pygments-gallery .highlight-autumn .nv { color: #A00 }
.pygments-gallery .highlight-autumn .ow { color: #00A }
.pygments-gallery .highlight-autumn .w { color: #BBB }
.pygments-gallery .highlight-autumn .mb { color: #099 }
.pygments-gallery .highlight-autumn .mf { color: #099 }
.pygments-gallery .highlight-autumn .mh { color: #099 }
.pygments-gallery .highlight-autumn .mi { color: #099 }
.pygments-gallery .highlight-autumn .mo { color: #099 }
.pygments-gallery .highlight-autumn .sa { color: #A50 }
.pygments-gallery .highlight-autumn .sb { color: #A50 }
.pygments-gallery .highlight-autumn .sc { color: #A50 }
.pygments-gallery .highlight-autumn .dl { color: #A50 }
.pygments-gallery .highlight-autumn .sd { color: #A50 }
.pygments-gallery .highlight-autumn .s2 { color: #A50 }
.pygments-gallery .highlight-autumn .se { color: #A50 }
.pygments-gallery .highlight-autumn .sh { color: #A50 }
.pygments-gallery .highlight-autumn .si { color: #A50 }
.pygments-gallery .highlight-autumn .sx { color: #A50 }
.pygments-gallery .highlight-autumn .sr { color: #099 }
.pygments-gallery .highlight-autumn .s1 { color: #A50 }
.pygments-gallery .highlight-autumn .ss { color: #00A }
.pygments-gallery .highlight-autumn .bp { color: #0AA }
.pygments-gallery .highlight-autumn .fm { color: #0A0 }
.pygments-gallery .highlight-autumn .vc { color: #A00 }
.pygments-gallery .highlight-autumn .vg { color: #A00 }
.pygments-gallery .highlight-autumn .vi { color: #A00 }
.pygments-gallery .highlight-autumn .vm { color: #A00 }
.pygments-gallery .highlight-autumn .il { color: #099 }
.pygments-gallery .highlight-blinds-dark .hll { background-color: #66666691 }
.pygments-gallery .highlight-blinds-dark { background: #242424; color: #BBB }
.pygments-gallery .highlight-blinds-dark .c { color: #8C8C8C }
.pygments-gallery .highlight-blinds-dark .err { color: #5391CF }
.pygments-gallery .highlight-blinds-dark .k { color: #D166A3 }
.pygments-gallery .highlight-blinds-dark .l { color: #5391CF }
.pygments-gallery .highlight-blinds-dark .n { color: #5391CF }
.pygments-gallery .highlight-blinds-dark .o { color: #E67 }
.pygments-gallery .highlight-blinds-dark .p { color: #BBB }
.pygments-gallery .highlight-blinds-dark .ch { color: #8C8C8C }
.pygments-gallery .highlight-blinds-dark .cm { color: #8C8C8C }
.pygments-gallery .highlight-blinds-dark .cp { color: #8C8C8C }
.pygments-gallery .highlight-blinds-dark .cpf { color: #8C8C8C }
.pygments-gallery .highlight-blinds-dark .c1 { color: #8C8C8C }
.pygments-gallery .highlight-blinds-dark .cs { color: #8C8C8C }
.pygments-gallery .highlight-blinds-dark .gd { color: #5391CF }
.pygments-gallery .highlight-blinds-dark .ge { font-style: italic }
.pygments-gallery .highlight-blinds-dark .gh { color: #5391CF }
.pygments-gallery .highlight-blinds-dark .gs { font-weight: bold }
.pygments-gallery .highlight-blinds-dark .gu { color: #5391CF }
.pygments-gallery .highlight-blinds-dark .kc { color: #D166A3 }
.pygments-gallery .highlight-blinds-dark .kd { color: #D166A3 }
.pygments-gallery .highlight-blinds-dark .kn { color: #D166A3 }
.pygments-gallery .highlight-blinds-dark .kp { color: #D166A3 }
.pygments-gallery .highlight-blinds-dark .kr { color: #D166A3 }
.pygments-gallery .highlight-blinds-dark .kt { color: #6CE }
.pygments-gallery .highlight-blinds-dark .ld { color: #5391CF }
.pygments-gallery .highlight-blinds-dark .m { color: #BBB }
.pygments-gallery .highlight-blinds-dark .s { color: #D166A3 }
.pygments-gallery .highlight-blinds-dark .na { color: #D166A3 }
.pygments-gallery .highlight-blinds-dark .nb { color: #6CE }
.pygments-gallery .highlight-blinds-dark .nc { color: #E67 }
.pygments-gallery .highlight-blinds-dark .no { color: #E67 }
.pygments-gallery .highlight-blinds-dark .nd { color: #CB4 }
.pygments-gallery .highlight-blinds-dark .ni { color: #CB4 }
.pygments-gallery .highlight-blinds-dark .ne { color: #5391CF }
.pygments-gallery .highlight-blinds-dark .nf { color: #6CE }
.pygments-gallery .highlight-blinds-dark .nl { color: #E67 }
.pygments-gallery .highlight-blinds-dark .nn { color: #6CE }
.pygments-gallery .highlight-blinds-dark .nx { color: #5391CF }
.pygments-gallery .highlight-blinds-dark .py { color: #5391CF }
.pygments-gallery .highlight-blinds-dark .nt { color: #6CE }
.pygments-gallery .highlight-blinds-dark .nv { color: #5391CF }
.pygments-gallery .highlight-blinds-dark .ow { color: #D166A3 }
.pygments-gallery .highlight-blinds-dark .pm { color: #BBB }
.pygments-gallery .highlight-blinds-dark .w { color: #BBB }
.pygments-gallery .highlight-blinds-dark .mb { color: #BBB }
.pygments-gallery .highlight-blinds-dark .mf { color: #BBB }
.pygments-gallery .highlight-blinds-dark .mh { color: #BBB }
.pygments-gallery .highlight-blinds-dark .mi { color: #BBB }
.pygments-gallery .highlight-blinds-dark .mo { color: #BBB }
.pygments-gallery .highlight-blinds-dark .sa { color: #D166A3 }
.pygments-gallery .highlight-blinds-dark .sb { color: #D166A3 }
.pygments-gallery .highlight-blinds-dark .sc { color: #D166A3 }
.pygments-gallery .highlight-blinds-dark .dl { color: #D166A3 }
.pygments-gallery .highlight-blinds-dark .sd { color: #D166A3 }
.pygments-gallery .highlight-blinds-dark .s2 { color: #D166A3 }
.pygments-gallery .highlight-blinds-dark .se { color: #D166A3 }
.pygments-gallery .highlight-blinds-dark .sh { color: #D166A3 }
.pygments-gallery .highlight-blinds-dark .si { color: #D166A3 }
.pygments-gallery .highlight-blinds-dark .sx { color: #D166A3 }
.pygments-gallery .highlight-blinds-dark .sr { color: #D166A3 }
.pygments-gallery .highlight-blinds-dark .s1 { color: #D166A3 }
.pygments-gallery .highlight-blinds-dark .ss { color: #E67 }
.pygments-gallery .highlight-blinds-dark .bp { color: #6CE }
.pygments-gallery .highlight-blinds-dark .fm { color: #6CE }
.pygments-gallery .highlight-blinds-dark .vc { color: #5391CF }
.pygments-gallery .highlight-blinds-dark .vg { color: #5391CF }
.pygments-gallery .highlight-blinds-dark .vi { color: #5391CF }
.pygments-gallery .highlight-blinds-dark .vm { color: #E67 }
.pygments-gallery .highlight-blinds-dark .il { color: #BBB }
.pygments-gallery .highlight-blinds-light .hll { background-color: #add6ff }
.pygments-gallery .highlight-blinds-light { background: #fcfcfc; color: #000 }
.pygments-gallery .highlight-blinds-light .c { color: #737373 }
.pygments-gallery .highlight-blinds-light .err { color: #0072B2 }
.pygments-gallery .highlight-blinds-light .k { color: #CC398B }
.pygments-gallery .highlight-blinds-light .l { color: #0072B2 }
.pygments-gallery .highlight-blinds-light .n { color: #0072B2 }
.pygments-gallery .highlight-blinds-light .o { color: #BF5400 }
.pygments-gallery .highlight-blinds-light .p { color: #000 }
.pygments-gallery .highlight-blinds-light .ch { color: #737373 }
.pygments-gallery .highlight-blinds-light .cm { color: #737373 }
.pygments-gallery .highlight-blinds-light .cp { color: #737373 }
.pygments-gallery .highlight-blinds-light .cpf { color: #737373 }
.pygments-gallery .highlight-blinds-light .c1 { color: #737373 }
.pygments-gallery .highlight-blinds-light .cs { color: #737373 }
.pygments-gallery .highlight-blinds-light .gd { color: #0072B2 }
.pygments-gallery .highlight-blinds-light .ge { font-style: italic }
.pygments-gallery .highlight-blinds-light .gh { color: #0072B2 }
.pygments-gallery .highlight-blinds-light .gs { font-weight: bold }
.pygments-gallery .highlight-blinds-light .gu { color: #0072B2 }
.pygments-gallery .highlight-blinds-light .kc { color: #CC398B }
.pygments-gallery .highlight-blinds-light .kd { color: #CC398B }
.pygments-gallery .highlight-blinds-light .kn { color: #CC398B }
.pygments-gallery .highlight-blinds-light .kp { color: #CC398B }
.pygments-gallery .highlight-blinds-light .kr { color: #CC398B }
.pygments-gallery .highlight-blinds-light .kt { color: #008561 }
.pygments-gallery .highlight-blinds-light .ld { color: #0072B2 }
.pygments-gallery .highlight-blinds-light .m { color: #000 }
.pygments-gallery .highlight-blinds-light .s { color: #CC398B }
.pygments-gallery .highlight-blinds-light .na { color: #CC398B }
.pygments-gallery .highlight-blinds-light .nb { color: #008561 }
.pygments-gallery .highlight-blinds-light .nc { color: #BF5400 }
.pygments-gallery .highlight-blinds-light .no { color: #BF5400 }
.pygments-gallery .highlight-blinds-light .nd { color: #996B00 }
.pygments-gallery .highlight-blinds-light .ni { color: #0072B2 }
.pygments-gallery .highlight-blinds-light .ne { color: #0072B2 }
.pygments-gallery .highlight-blinds-light .nf { color: #008561 }
.pygments-gallery .highlight-blinds-light .nl { color: #BF5400 }
.pygments-gallery .highlight-blinds-light .nn { color: #008561 }
.pygments-gallery .highlight-blinds-light .nx { color: #0072B2 }
.pygments-gallery .highlight-blinds-light .py { color: #0072B2 }
.pygments-gallery .highlight-blinds-light .nt { color: #008561 }
.pygments-gallery .highlight-blinds-light .nv { color: #0072B2 }
.pygments-gallery .highlight-blinds-light .ow { color: #CC398B }
.pygments-gallery .highlight-blinds-light .pm { color: #000 }
.pygments-gallery .highlight-blinds-light .w { color: #000 }
.pygments-gallery .highlight-blinds-light .mb { color: #000 }
.pygments-gallery .highlight-blinds-light .mf { color: #000 }
.pygments-gallery .highlight-blinds-light .mh { color: #000 }
.pygments-gallery .highlight-blinds-light .mi { color: #000 }
.pygments-gallery .highlight-blinds-light .mo { color: #000 }
.pygments-gallery .highlight-blinds-light .sa { color: #CC398B }
.pygments-gallery .highlight-blinds-light .sb { color: #CC398B }
.pygments-gallery .highlight-blinds-light .sc { color: #CC398B }
.pygments-gallery .highlight-blinds-light .dl { color: #CC398B }
.pygments-gallery .highlight-blinds-light .sd { color: #CC398B }
.pygments-gallery .highlight-blinds-light .s2 { color: #CC398B }
.pygments-gallery .highlight-blinds-light .se { color: #CC398B }
.pygments-gallery .highlight-blinds-light .sh { color: #CC398B }
.pygments-gallery .highlight-blinds-light .si { color: #CC398B }
.pygments-gallery .highlight-blinds-light .sx { color: #CC398B }
.pygments-gallery .highlight-blinds-light .sr { color: #CC398B }
.pygments-gallery .highlight-blinds-light .s1 { color: #CC398B }
.pygments-gallery .highlight-blinds-light .ss { color: #BF5400 }
.pygments-gallery .highlight-blinds-light .bp { color: #008561 }
.pygments-gallery .highlight-blinds-light .fm { color: #008561 }
.pygments-gallery .highlight-blinds-light .vc { color: #0072B2 }
.pygments-gallery .highlight-blinds-light .vg { color: #0072B2 }
.pygments-gallery .highlight-blinds-light .vi { color: #0072B2 }
.pygments-gallery .highlight-blinds-light .vm { color: #BF5400 }
.pygments-gallery .highlight-blinds-light .il { color: #000 }
.pygments-gallery .highlight-borland .hll { background-color: #ffffcc }
.pygments-gallery .highlight-borland { background: #ffffff; }
.pygments-gallery .highlight-borland .c { color: #080; font-style: italic }
.pygments-gallery .highlight-borland .err { color: #A61717; background-color: #E3D2D2 }
.pygments-gallery .highlight-borland .k { color: #000080; font-weight: bold }
.pygments-gallery .highlight-borland .ch { color: #080; font-style: italic }
.pygments-gallery .highlight-borland .cm { color: #080; font-style: italic }
.pygments-gallery .highlight-borland .cp { color: #008080 }
.pygments-gallery .highlight-borland .cpf { color: #080; font-style: italic }
.pygments-gallery .highlight-borland .c1 { color: #080; font-style: italic }
.pygments-gallery .highlight-borland .cs { color: #080; font-weight: bold }
.pygments-gallery .highlight-borland .gd { color: #000; background-color: #FDD }
.pygments-gallery .highlight-borland .ge { font-style: italic }
.pygments-gallery .highlight-borland .ges { font-weight: bold; font-style: italic }
.pygments-gallery .highlight-borland .gr { color: #A00 }
.pygments-gallery .highlight-borland .gh { color: #999 }
.pygments-gallery .highlight-borland .gi { color: #000; background-color: #DFD }
.pygments-gallery .highlight-borland .go { color: #888 }
.pygments-gallery .highlight-borland .gp { color: #555 }
.pygments-gallery .highlight-borland .gs { font-weight: bold }
.pygments-gallery .highlight-borland .gu { color: #AAA }
.pygments-gallery .highlight-borland .gt { color: #A00 }
.pygments-gallery .highlight-borland .kc { color: #000080; font-weight: bold }
.pygments-gallery .highlight-borland .kd { color: #000080; font-weight: bold }
.pygments-gallery .highlight-borland .kn { color: #000080; font-weight: bold }
.pygments-gallery .highlight-borland .kp { color: #000080; font-weight: bold }
.pygments-gallery .highlight-borland .kr { color: #000080; font-weight: bold }
.pygments-gallery .highlight-borland .kt { color: #000080; font-weight: bold }
.pygments-gallery .highlight-borland .m { color: #00F }
.pygments-gallery .highlight-borland .s { color: #00F }
.pygments-gallery .highlight-borland .na { color: #F00 }
.pygments-gallery .highlight-borland .nt { color: #000080; font-weight: bold }
.pygments-gallery .highlight-borland .ow { font-weight: bold }
.pygments-gallery .highlight-borland .w { color: #BBB }
.pygments-gallery .highlight-borland .mb { color: #00F }
.pygments-gallery .highlight-borland .mf { color: #00F }
.pygments-gallery .highlight-borland .mh { color: #00F }
.pygments-gallery .highlight-borland .mi { color: #00F }
.pygments-gallery .highlight-borland .mo { color: #00F }
.pygments-gallery .highlight-borland .sa { color: #00F }
.pygments-gallery .highlight-borland .sb { color: #00F }
.pygments-gallery .highlight-borland .sc { color: #800080 }
.pygments-gallery .highlight-borland .dl { color: #00F }
.pygments-gallery .highlight-borland .sd { color: #00F }
.pygments-gallery .highlight-borland .s2 { color: #00F }
.pygments-gallery .highlight-borland .se { color: #00F }
.pygments-gallery .highlight-borland .sh { color: #00F }
.pygments-gallery .highlight-borland .si { color: #00F }
.pygments-gallery .highlight-borland .sx { color: #00F }
.pygments-gallery .highlight-borland .sr { color: #00F }
.pygments-gallery .highlight-borland .s1 { color: #00F }
.pygments-gallery .highlight-borland .ss { color: #00F }
.pygments-gallery .highlight-borland .il { color: #00F }
.pygments-gallery .highlight-bw .hll { background-color: #ffffcc }
.pygments-gallery .highlight-bw { background: #ffffff; }
.pygments-gallery .highlight-bw .c { font-style: italic }
.pygments-gallery .highlight-bw .err { border: 1px solid #F00 }
.pygments-gallery .highlight-bw .k { font-weight: bold }
.pygments-gallery .highlight-bw .ch { font-style: italic }
.pygments-gallery .highlight-bw .cm { font-style: italic }
.pygments-gallery .highlight-bw .cpf { font-style: italic }
.pygments-gallery .highlight-bw .c1 { font-style: italic }
.pygments-gallery .highlight-bw .cs { font-style: italic }
.pygments-gallery .highlight-bw .ge { font-style: italic }
.pygments-gallery .highlight-bw .ges { font-weight: bold; font-style: italic }
.pygments-gallery .highlight-bw .gh { font-weight: bold }
.pygments-gallery .highlight-bw .gp { font-weight: bold }
.pygments-gallery .highlight-bw .gs { font-weight: bold }
.pygments-gallery .highlight-bw .gu { font-weight: bold }
.pygments-gallery .highlight-bw .kc { font-weight: bold }
.pygments-gallery .highlight-bw .kd { font-weight: bold }
.pygments-gallery .highlight-bw .kn { font-weight: bold }
.pygments-gallery .highlight-bw .kr { font-weight: bold }
.pygments-gallery .highlight-bw .s { font-style: italic }
.pygments-gallery .highlight-bw .nc { font-weight: bold }
.pygments-gallery .highlight-bw .ni { font-weight: bold }
.pygments-gallery .highlight-bw .ne { font-weight: bold }
.pygments-gallery .highlight-bw .nn { font-weight: bold }
.pygments-gallery .highlight-bw .nt { font-weight: bold }
.pygments-gallery .highlight-bw .ow { font-weight: bold }
.pygments-gallery .highlight-bw .sa { font-style: italic }
.pygments-gallery .highlight-bw .sb { font-style: italic }
.pygments-gallery .highlight-bw .sc { font-style: italic }
.pygments-gallery .highlight-bw .dl { font-style: italic }
.pygments-gallery .highlight-bw .sd { font-style: italic }
.pygments-gallery .highlight-bw .s2 { font-style: italic }
.pygments-gallery .highlight-bw .se { font-weight: bold; font-style: italic }
.pygments-gallery .highlight-bw .sh { font-style: italic }
.pygments-gallery .highlight-bw .si { font-weight: bold; font-style: italic }
.pygments-gallery .highlight-bw .sx { font-style: italic }
.pygments-gallery .highlight-bw .sr { font-style: italic }
.pygments-gallery .highlight-bw .s1 { font-style: italic }
.pygments-gallery .highlight-bw .ss { font-style: italic }
.pygments-gallery .highlight-coffee .hll { background-color: #ddd0c0 }
.pygments-gallery .highlight-coffee { background: #262220; color: #DDD0C0 }
.pygments-gallery .highlight-coffee .c { color: #70757A }
.pygments-gallery .highlight-coffee .err { color: #AF5F5F }
.pygments-gallery .highlight-coffee .esc { color: #DDD0C0 }
.pygments-gallery .highlight-coffee .g { color: #DDD0C0 }
.pygments-gallery .highlight-coffee .k { color: #919191 }
.pygments-gallery .highlight-coffee .l { color: #AF875F }
.pygments-gallery .highlight-coffee .n { color: #DDD0C0 }
.pygments-gallery .highlight-coffee .o { color: #878787 }
.pygments-gallery .highlight-coffee .x { color: #DDD0C0 }
.pygments-gallery .highlight-coffee .p { color: #DDD0C0 }
.pygments-gallery .highlight-coffee .ch { color: #8F9F9F }
.pygments-gallery .highlight-coffee .cm { color: #70757A }
.pygments-gallery .highlight-coffee .cp { color: #FDD0C0 }
.pygments-gallery .highlight-coffee .cpf { color: #C9B98F }
.pygments-gallery .highlight-coffee .c1 { color: #70757A }
.pygments-gallery .highlight-coffee .cs { color: #AF5F5F }
.pygments-gallery .highlight-coffee .gd { color: #BB6868 }
.pygments-gallery .highlight-coffee .ge { color: #DDD0C0; font-style: italic }
.pygments-gallery .highlight-coffee .ges { color: #DDD0C0 }
.pygments-gallery .highlight-coffee .gr { color: #AF5F5F }
.pygments-gallery .highlight-coffee .gh { color: #DDD0C0 }
.pygments-gallery .highlight-coffee .gi { color: #849155 }
.pygments-gallery .highlight-coffee .go { color: #DDD0C0 }
.pygments-gallery .highlight-coffee .gp { color: #DDD0C0 }
.pygments-gallery .highlight-coffee .gs { color: #DDD0C0; font-weight: bold }
.pygments-gallery .highlight-coffee .gu { color: #DDD0C0 }
.pygments-gallery .highlight-coffee .gt { color: #AF5F5F }
.pygments-gallery .highlight-coffee .kc { color: #875F5F }
.pygments-gallery .highlight-coffee .kd { color: #875F5F }
.pygments-gallery .highlight-coffee .kn { color: #875F5F }
.pygments-gallery .highlight-coffee .kp { color: #919191 }
.pygments-gallery .highlight-coffee .kr { color: #B46276 }
.pygments-gallery .highlight-coffee .kt { color: #AF875F }
.pygments-gallery .highlight-coffee .ld { color: #AF875F }
.pygments-gallery .highlight-coffee .m { color: #87AFAF }
.pygments-gallery .highlight-coffee .s { color: #C9B98F }
.pygments-gallery .highlight-coffee .na { color: #DDD0C0 }
.pygments-gallery .highlight-coffee .nb { color: #DDD0C0 }
.pygments-gallery .highlight-coffee .nc { color: #875F5F }
.pygments-gallery .highlight-coffee .no { color: #AF8787 }
.pygments-gallery .highlight-coffee .nd { color: #FDD0C0 }
.pygments-gallery .highlight-coffee .ni { color: #DDD0C0 }
.pygments-gallery .highlight-coffee .ne { color: #877575 }
.pygments-gallery .highlight-coffee .nf { color: #FDD0C0 }
.pygments-gallery .highlight-coffee .nl { color: #DDD0C0 }
.pygments-gallery .highlight-coffee .nn { color: #DDD0C0 }
.pygments-gallery .highlight-coffee .nx { color: #DDD0C0 }
.pygments-gallery .highlight-coffee .py { color: #DFAF87 }
.pygments-gallery .highlight-coffee .nt { color: #87AFAF }
.pygments-gallery .highlight-coffee .nv { color: #DDD0C0 }
.pygments-gallery .highlight-coffee .ow { color: #878787 }
.pygments-gallery .highlight-coffee .pm { color: #DDD0C0 }
.pygments-gallery .highlight-coffee .w { color: #DDD0C0 }
.pygments-gallery .highlight-coffee .mb { color: #87AFAF }
.pygments-gallery .highlight-coffee .mf { color: #87AFAF }
.pygments-gallery .highlight-coffee .mh { color: #87AFAF }
.pygments-gallery .highlight-coffee .mi { color: #87AFAF }
.pygments-gallery .highlight-coffee .mo { color: #87AFAF }
.pygments-gallery .highlight-coffee .sa { color: #DFAF87 }
.pygments-gallery .highlight-coffee .sb { color: #C9B98F }
.pygments-gallery .highlight-coffee .sc { color: #C9B98F }
.pygments-gallery .highlight-coffee .dl { color: #C9B98F }
.pygments-gallery .highlight-coffee .sd { color: #878787 }
.pygments-gallery .highlight-coffee .s2 { color: #C9B98F }
.pygments-gallery .highlight-coffee .se { color: #AF5F5F }
.pygments-gallery .highlight-coffee .sh { color: #C9B98F }
.pygments-gallery .highlight-coffee .si { color: #AF5F5F }
.pygments-gallery .highlight-coffee .sx { color: #FDD0C0 }
.pygments-gallery .highlight-coffee .sr { color: #AF5F5F }
.pygments-gallery .highlight-coffee .s1 { color: #C9B98F }
.pygments-gallery .highlight-coffee .ss { color: #AF5F5F }
.pygments-gallery .highlight-coffee .bp { color: #87AFAF }
.pygments-gallery .highlight-coffee .fm { color: #FDD0C0 }
.pygments-gallery .highlight-coffee .vc { color: #DDD0C0 }
.pygments-gallery .highlight-coffee .vg { color: #DDD0C0 }
.pygments-gallery .highlight-coffee .vi { color: #DDD0C0 }
.pygments-gallery .highlight-coffee .vm { color: #DDD0C0 }
.pygments-gallery .highlight-coffee .il { color: #87AFAF }
.pygments-gallery .highlight-colorful .hll { background-color: #ffffcc }
.pygments-gallery .highlight-colorful { background: #ffffff; }
.pygments-gallery .highlight-colorful .c { color: #888 }
.pygments-gallery .highlight-colorful .err { color: #F00; background-color: #FAA }
.pygments-gallery .highlight-colorful .k { color: #080; font-weight: bold }
.pygments-gallery .highlight-colorful .o { color: #333 }
.pygments-gallery .highlight-colorful .ch { color: #888 }
.pygments-gallery .highlight-colorful .cm { color: #888 }
.pygments-gallery .highlight-colorful .cp { color: #579 }
.pygments-gallery .highlight-colorful .cpf { color: #888 }
.pygments-gallery .highlight-colorful .c1 { color: #888 }
.pygments-gallery .highlight-colorful .cs { color: #C00; font-weight: bold }
.pygments-gallery .highlight-colorful .gd { color: #A00000 }
.pygments-gallery .highlight-colorful .ge { font-style: italic }
.pygments-gallery .highlight-colorful .ges { font-weight: bold; font-style: italic }
.pygments-gallery .highlight-colorful .gr { color: #F00 }
.pygments-gallery .highlight-colorful .gh { color: #000080; font-weight: bold }
.pygments-gallery .highlight-colorful .gi { color: #00A000 }
.pygments-gallery .highlight-colorful .go { color: #888 }
.pygments-gallery .highlight-colorful .gp { color: #C65D09; font-weight: bold }
.pygments-gallery .highlight-colorful .gs { font-weight: bold }
.pygments-gallery .highlight-colorful .gu { color: #800080; font-weight: bold }
.pygments-gallery .highlight-colorful .gt { color: #04D }
.pygments-gallery .highlight-colorful .kc { color: #080; font-weight: bold }
.pygments-gallery .highlight-colorful .kd { color: #080; font-weight: bold }
.pygments-gallery .highlight-colorful .kn { color: #080; font-weight: bold }
.pygments-gallery .highlight-colorful .kp { color: #038; font-weight: bold }
.pygments-gallery .highlight-colorful .kr { color: #080; font-weight: bold }
.pygments-gallery .highlight-colorful .kt { color: #339; font-weight: bold }
.pygments-gallery .highlight-colorful .m { color: #60E; font-weight: bold }
.pygments-gallery .highlight-colorful .s { background-color: #FFF0F0 }
.pygments-gallery .highlight-colorful .na { color: #00C }
.pygments-gallery .highlight-colorful .nb { color: #007020 }
.pygments-gallery .highlight-colorful .nc { color: #B06; font-weight: bold }
.pygments-gallery .highlight-colorful .no { color: #036; font-weight: bold }
.pygments-gallery .highlight-colorful .nd { color: #555; font-weight: bold }
.pygments-gallery .highlight-colorful .ni { color: #800; font-weight: bold }
.pygments-gallery .highlight-colorful .ne { color: #F00; font-weight: bold }
.pygments-gallery .highlight-colorful .nf { color: #06B; font-weight: bold }
.pygments-gallery .highlight-colorful .nl { color: #970; font-weight: bold }
.pygments-gallery .highlight-colorful .nn { color: #0E84B5; font-weight: bold }
.pygments-gallery .highlight-colorful .nt { color: #070 }
.pygments-gallery .highlight-colorful .nv { color: #963 }
.pygments-gallery .highlight-colorful .ow { color: #000; font-weight: bold }
.pygments-gallery .highlight-colorful .w { color: #BBB }
.pygments-gallery .highlight-colorful .mb { color: #60E; font-weight: bold }
.pygments-gallery .highlight-colorful .mf { color: #60E; font-weight: bold }
.pygments-gallery .highlight-colorful .mh { color: #058; font-weight: bold }
.pygments-gallery .highlight-colorful .mi { color: #00D; font-weight: bold }
.pygments-gallery .highlight-colorful .mo { color: #40E; font-weight: bold }
.pygments-gallery .highlight-colorful .sa { background-color: #FFF0F0 }
.pygments-gallery .highlight-colorful .sb { background-color: #FFF0F0 }
.pygments-gallery .highlight-colorful .sc { color: #04D }
.pygments-gallery .highlight-colorful .dl { background-color: #FFF0F0 }
.pygments-gallery .highlight-colorful .sd { color: #D42 }
.pygments-gallery .highlight-colorful .s2 { background-color: #FFF0F0 }
.pygments-gallery .highlight-colorful .se { color: #666; font-weight: bold; background-color: #FFF0F0 }
.pygments-gallery .highlight-colorful .sh { background-color: #FFF0F0 }
.pygments-gallery .highlight-colorful .si { background-color: #EEE }
.pygments-gallery .highlight-colorful .sx { color: #D20; background-color: #FFF0F0 }
.pygments-gallery .highlight-colorful .sr { color: #000; background-color: #FFF0FF }
.pygments-gallery .highlight-colorful .s1 { background-color: #FFF0F0 }
.pygments-gallery .highlight-colorful .ss { color: #A60 }
.pygments-gallery .highlight-colorful .bp { color: #007020 }
.pygments-gallery .highlight-colorful .fm { color: #06B; font-weight: bold }
.pygments-gallery .highlight-colorful .vc { color: #369 }
.pygments-gallery .highlight-colorful .vg { color: #D70; font-weight: bold }
.pygments-gallery .highlight-colorful .vi { color: #33B }
.pygments-gallery .highlight-colorful .vm { color: #963 }
.pygments-gallery .highlight-colorful .il { color: #00D; font-weight: bold }
.pygments-gallery .highlight-default .hll { background-color: #ffffcc }
.pygments-gallery .highlight-default { background: #f8f8f8; }
.pygments-gallery .highlight-default .c { color: #3D7B7B; font-style: italic }
.pygments-gallery .highlight-default .err { border: 1px solid #F00 }
.pygments-gallery .highlight-default .k { color: #008000; font-weight: bold }
.pygments-gallery .highlight-default .o { color: #666 }
.pygments-gallery .highlight-default .ch { color: #3D7B7B; font-style: italic }
.pygments-gallery .highlight-default .cm { color: #3D7B7B; font-style: italic }
.pygments-gallery .highlight-default .cp { color: #9C6500 }
.pygments-gallery .highlight-default .cpf { color: #3D7B7B; font-style: italic }
.pygments-gallery .highlight-default .c1 { color: #3D7B7B; font-style: italic }
.pygments-gallery .highlight-default .cs { color: #3D7B7B; font-style: italic }
.pygments-gallery .highlight-default .gd { color: #A00000 }
.pygments-gallery .highlight-default .ge { font-style: italic }
.pygments-gallery .highlight-default .ges { font-weight: bold; font-style: italic }
.pygments-gallery .highlight-default .gr { color: #E40000 }
.pygments-gallery .highlight-default .gh { color: #000080; font-weight: bold }
.pygments-gallery .highlight-default .gi { color: #008400 }
.pygments-gallery .highlight-default .go { color: #717171 }
.pygments-gallery .highlight-default .gp { color: #000080; font-weight: bold }
.pygments-gallery .highlight-default .gs { font-weight: bold }
.pygments-gallery .highlight-default .gu { color: #800080; font-weight: bold }
.pygments-gallery .highlight-default .gt { color: #04D }
.pygments-gallery .highlight-default .kc { color: #008000; font-weight: bold }
.pygments-gallery .highlight-default .kd { color: #008000; font-weight: bold }
.pygments-gallery .highlight-default .kn { color: #008000; font-weight: bold }
.pygments-gallery .highlight-default .kp { color: #008000 }
.pygments-gallery .highlight-default .kr { color: #008000; font-weight: bold }
.pygments-gallery .highlight-default .kt { color: #B00040 }
.pygments-gallery .highlight-default .m { color: #666 }
.pygments-gallery .highlight-default .s { color: #BA2121 }
.pygments-gallery .highlight-default .na { color: #687822 }
.pygments-gallery .highlight-default .nb { color: #008000 }
.pygments-gallery .highlight-default .nc { color: #00F; font-weight: bold }
.pygments-gallery .highlight-default .no { color: #800 }
.pygments-gallery .highlight-default .nd { color: #A2F }
.pygments-gallery .highlight-default .ni { color: #717171; font-weight: bold }
.pygments-gallery .highlight-default .ne { color: #CB3F38; font-weight: bold }
.pygments-gallery .highlight-default .nf { color: #00F }
.pygments-gallery .highlight-default .nl { color: #767600 }
.pygments-gallery .highlight-default .nn { color: #00F; font-weight: bold }
.pygments-gallery .highlight-default .nt { color: #008000; font-weight: bold }
.pygments-gallery .highlight-default .nv { color: #19177C }
.pygments-gallery .highlight-default .ow { color: #A2F; font-weight: bold }
.pygments-gallery .highlight-default .w { color: #BBB }
.pygments-gallery .highlight-default .mb { color: #666 }
.pygments-gallery .highlight-default .mf { color: #666 }
.pygments-gallery .highlight-default .mh { color: #666 }
.pygments-gallery .highlight-default .mi { color: #666 }
.pygments-gallery .highlight-default .mo { color: #666 }
.pygments-gallery .highlight-default .sa { color: #BA2121 }
.pygments-gallery .highlight-default .sb { color: #BA2121 }
.pygments-gallery .highlight-default .sc { color: #BA2121 }
.pygments-gallery .highlight-default .dl { color: #BA2121 }
.pygments-gallery .highlight-default .sd { color: #BA2121; font-style: italic }
.pygments-gallery .highlight-default .s2 { color: #BA2121 }
.pygments-gallery .highlight-default .se { color: #AA5D1F; font-weight: bold }
.pygments-gallery .highlight-default .sh { color: #BA2121 }
.pygments-gallery .highlight-default .si { color: #A45A77; font-weight: bold }
.pygments-gallery .highlight-default .sx { color: #008000 }
.pygments-gallery .highlight-default .sr { color: #A45A77 }
.pygments-gallery .highlight-default .s1 { color: #BA2121 }
.pygments-gallery .highlight-default .ss { color: #19177C }
.pygments-gallery .highlight-default .bp { color: #008000 }
.pygments-gallery .highlight-default .fm { color: #00F }
.pygments-gallery .highlight-default .vc { color: #19177C }
.pygments-gallery .highlight-default .vg { color: #19177C }
.pygments-gallery .highlight-default .vi { color: #19177C }
.pygments-gallery .highlight-default .vm { color: #19177C }
.pygments-gallery .highlight-default .il { color: #666 }
.pygments-gallery .highlight-dracula .hll { background-color: #44475a }
.pygments-gallery .highlight-dracula { background: #282a36; color: #F8F8F2 }
.pygments-gallery .highlight-dracula .c { color: #6272A4 }
.pygments-gallery .highlight-dracula .err { color: #F8F8F2 }
.pygments-gallery .highlight-dracula .g { color: #F8F8F2 }
.pygments-gallery .highlight-dracula .k { color: #FF79C6 }
.pygments-gallery .highlight-dracula .l { color: #F8F8F2 }
.pygments-gallery .highlight-dracula .n { color: #F8F8F2 }
.pygments-gallery .highlight-dracula .o { color: #FF79C6 }
.pygments-gallery .highlight-dracula .x { color: #F8F8F2 }
.pygments-gallery .highlight-dracula .p { color: #F8F8F2 }
.pygments-gallery .highlight-dracula .ch { color: #6272A4 }
.pygments-gallery .highlight-dracula .cm { color: #6272A4 }
.pygments-gallery .highlight-dracula .cp { color: #FF79C6 }
.pygments-gallery .highlight-dracula .cpf { color: #6272A4 }
.pygments-gallery .highlight-dracula .c1 { color: #6272A4 }
.pygments-gallery .highlight-dracula .cs { color: #6272A4 }
.pygments-gallery .highlight-dracula .gd { color: #8B080B }
.pygments-gallery .highlight-dracula .ge { color: #F8F8F2; text-decoration: underline }
.pygments-gallery .highlight-dracula .ges { color: #F8F8F2; text-decoration: underline }
.pygments-gallery .highlight-dracula .gr { color: #F8F8F2 }
.pygments-gallery .highlight-dracula .gh { color: #F8F8F2; font-weight: bold }
.pygments-gallery .highlight-dracula .gi { color: #F8F8F2; font-weight: bold }
.pygments-gallery .highlight-dracula .go { color: #44475A }
.pygments-gallery .highlight-dracula .gp { color: #F8F8F2 }
.pygments-gallery .highlight-dracula .gs { color: #F8F8F2 }
.pygments-gallery .highlight-dracula .gu { color: #F8F8F2; font-weight: bold }
.pygments-gallery .highlight-dracula .gt { color: #F8F8F2 }
.pygments-gallery .highlight-dracula .kc { color: #FF79C6 }
.pygments-gallery .highlight-dracula .kd { color: #8BE9FD; font-style: italic }
.pygments-gallery .highlight-dracula .kn { color: #FF79C6 }
.pygments-gallery .highlight-dracula .kp { color: #FF79C6 }
.pygments-gallery .highlight-dracula .kr { color: #FF79C6 }
.pygments-gallery .highlight-dracula .kt { color: #8BE9FD }
.pygments-gallery .highlight-dracula .ld { color: #F8F8F2 }
.pygments-gallery .highlight-dracula .m { color: #FFB86C }
.pygments-gallery .highlight-dracula .s { color: #BD93F9 }
.pygments-gallery .highlight-dracula .na { color: #50FA7B }
.pygments-gallery .highlight-dracula .nb { color: #8BE9FD; font-style: italic }
.pygments-gallery .highlight-dracula .nc { color: #50FA7B }
.pygments-gallery .highlight-dracula .no { color: #F8F8F2 }
.pygments-gallery .highlight-dracula .nd { color: #F8F8F2 }
.pygments-gallery .highlight-dracula .ni { color: #F8F8F2 }
.pygments-gallery .highlight-dracula .ne { color: #F8F8F2 }
.pygments-gallery .highlight-dracula .nf { color: #50FA7B }
.pygments-gallery .highlight-dracula .nl { color: #8BE9FD; font-style: italic }
.pygments-gallery .highlight-dracula .nn { color: #F8F8F2 }
.pygments-gallery .highlight-dracula .nx { color: #F8F8F2 }
.pygments-gallery .highlight-dracula .py { color: #F8F8F2 }
.pygments-gallery .highlight-dracula .nt { color: #FF79C6 }
.pygments-gallery .highlight-dracula .nv { color: #8BE9FD; font-style: italic }
.pygments-gallery .highlight-dracula .ow { color: #FF79C6 }
.pygments-gallery .highlight-dracula .pm { color: #F8F8F2 }
.pygments-gallery .highlight-dracula .w { color: #F8F8F2 }
.pygments-gallery .highlight-dracula .mb { color: #FFB86C }
.pygments-gallery .highlight-dracula .mf { color: #FFB86C }
.pygments-gallery .highlight-dracula .mh { color: #FFB86C }
.pygments-gallery .highlight-dracula .mi { color: #FFB86C }
.pygments-gallery .highlight-dracula .mo { color: #FFB86C }
.pygments-gallery .highlight-dracula .sa { color: #BD93F9 }
.pygments-gallery .highlight-dracula .sb { color: #BD93F9 }
.pygments-gallery .highlight-dracula .sc { color: #BD93F9 }
.pygments-gallery .highlight-dracula .dl { color: #BD93F9 }
.pygments-gallery .highlight-dracula .sd { color: #BD93F9 }
.pygments-gallery .highlight-dracula .s2 { color: #BD93F9 }
.pygments-gallery .highlight-dracula .se { color: #BD93F9 }
.pygments-gallery .highlight-dracula .sh { color: #BD93F9 }
.pygments-gallery .highlight-dracula .si { color: #BD93F9 }
.pygments-gallery .highlight-dracula .sx { color: #BD93F9 }
.pygments-gallery .highlight-dracula .sr { color: #BD93F9 }
.pygments-gallery .highlight-dracula .s1 { color: #BD93F9 }
.pygments-gallery .highlight-dracula .ss { color: #BD93F9 }
.pygments-gallery .highlight-dracula .bp { color: #F8F8F2; font-style: italic }
.pygments-gallery .highlight-dracula .fm { color: #50FA7B }
.pygments-gallery .highlight-dracula .vc { color: #8BE9FD; font-style: italic }
.pygments-gallery .highlight-dracula .vg { color: #8BE9FD; font-style: italic }
.pygments-gallery .highlight-dracula .vi { color: #8BE9FD; font-style: italic }
.pygments-gallery .highlight-dracula .vm { color: #8BE9FD; font-style: italic }
.pygments-gallery .highlight-dracula .il { color: #FFB86C }
.pygments-gallery .highlight-emacs .hll { background-color: #ffffcc }
.pygments-gallery .highlight-emacs { background: #f8f8f8; }
.pygments-gallery .highlight-emacs .c { color: #080; font-style: italic }
.pygments-gallery .highlight-emacs .err { border: 1px solid #F00 }
.pygments-gallery .highlight-emacs .k { color: #A2F; font-weight: bold }
.pygments-gallery .highlight-emacs .o { color: #666 }
.pygments-gallery .highlight-emacs .ch { color: #080; font-style: italic }
.pygments-gallery .highlight-emacs .cm { color: #080; font-style: italic }
.pygments-gallery .highlight-emacs .cp { color: #080 }
.pygments-gallery .highlight-emacs .cpf { color: #080; font-style: italic }
.pygments-gallery .highlight-emacs .c1 { color: #080; font-style: italic }
.pygments-gallery .highlight-emacs .cs { color: #080; font-weight: bold }
.pygments-gallery .highlight-emacs .gd { color: #A00000 }
.pygments-gallery .highlight-emacs .ge { font-style: italic }
.pygments-gallery .highlight-emacs .ges { font-weight: bold; font-style: italic }
.pygments-gallery .highlight-emacs .gr { color: #F00 }
.pygments-gallery .highlight-emacs .gh { color: #000080; font-weight: bold }
.pygments-gallery .highlight-emacs .gi { color: #00A000 }
.pygments-gallery .highlight-emacs .go { color: #888 }
.pygments-gallery .highlight-emacs .gp { color: #000080; font-weight: bold }
.pygments-gallery .highlight-emacs .gs { font-weight: bold }
.pygments-gallery .highlight-emacs .gu { color: #800080; font-weight: bold }
.pygments-gallery .highlight-emacs .gt { color: #04D }
.pygments-gallery .highlight-emacs .kc { color: #A2F; font-weight: bold }
.pygments-gallery .highlight-emacs .kd { color: #A2F; font-weight: bold }
.pygments-gallery .highlight-emacs .kn { color: #A2F; font-weight: bold }
.pygments-gallery .highlight-emacs .kp { color: #A2F }
.pygments-gallery .highlight-emacs .kr { color: #A2F; font-weight: bold }
.pygments-gallery .highlight-emacs .kt { color: #0B0; font-weight: bold }
.pygments-gallery .highlight-emacs .m { color: #666 }
.pygments-gallery .highlight-emacs .s { color: #B44 }
.pygments-gallery .highlight-emacs .na { color: #B44 }
.pygments-gallery .highlight-emacs .nb { color: #A2F }
.pygments-gallery .highlight-emacs .nc { color: #00F }
.pygments-gallery .highlight-emacs .no { color: #800 }
.pygments-gallery .highlight-emacs .nd { color: #A2F }
.pygments-gallery .highlight-emacs .ni { color: #999; font-weight: bold }
.pygments-gallery .highlight-emacs .ne { color: #D2413A; font-weight: bold }
.pygments-gallery .highlight-emacs .nf { color: #00A000 }
.pygments-gallery .highlight-emacs .nl { color: #A0A000 }
.pygments-gallery .highlight-emacs .nn { color: #00F; font-weight: bold }
.pygments-gallery .highlight-emacs .nt { color: #008000; font-weight: bold }
.pygments-gallery .highlight-emacs .nv { color: #B8860B }
.pygments-gallery .highlight-emacs .ow { color: #A2F; font-weight: bold }
.pygments-gallery .highlight-emacs .w { color: #BBB }
.pygments-gallery .highlight-emacs .mb { color: #666 }
.pygments-gallery .highlight-emacs .mf { color: #666 }
.pygments-gallery .highlight-emacs .mh { color: #666 }
.pygments-gallery .highlight-emacs .mi { color: #666 }
.pygments-gallery .highlight-emacs .mo { color: #666 }
.pygments-gallery .highlight-emacs .sa { color: #B44 }
.pygments-gallery .highlight-emacs .sb { color: #B44 }
.pygments-gallery .highlight-emacs .sc { color: #B44 }
.pygments-gallery .highlight-emacs .dl { color: #B44 }
.pygments-gallery .highlight-emacs .sd { color: #B44; font-style: italic }
.pygments-gallery .highlight-emacs .s2 { color: #B44 }
.pygments-gallery .highlight-emacs .se { color: #B62; font-weight: bold }
.pygments-gallery .highlight-emacs .sh { color: #B44 }
.pygments-gallery .highlight-emacs .si { color: #B68; font-weight: bold }
.pygments-gallery .highlight-emacs .sx { color: #008000 }
.pygments-gallery .highlight-emacs .sr { color: #B68 }
.pygments-gallery .highlight-emacs .s1 { color: #B44 }
.pygments-gallery .highlight-emacs .ss { color: #B8860B }
.pygments-gallery .highlight-emacs .bp { color: #A2F }
.pygments-gallery .highlight-emacs .fm { color: #00A000 }
.pygments-gallery .highlight-emacs .vc { color: #B8860B }
.pygments-gallery .highlight-emacs .vg { color: #B8860B }
.pygments-gallery .highlight-emacs .vi { color: #B8860B }
.pygments-gallery .highlight-emacs .vm { color: #B8860B }
.pygments-gallery .highlight-emacs .il { color: #666 }
.pygments-gallery .highlight-friendly .hll { background-color: #ffffcc }
.pygments-gallery .highlight-friendly { background: #f0f0f0; }
.pygments-gallery .highlight-friendly .c { color: #60A0B0; font-style: italic }
.pygments-gallery .highlight-friendly .err { border: 1px solid #F00 }
.pygments-gallery .highlight-friendly .k { color: #007020; font-weight: bold }
.pygments-gallery .highlight-friendly .o { color: #666 }
.pygments-gallery .highlight-friendly .ch { color: #60A0B0; font-style: italic }
.pygments-gallery .highlight-friendly .cm { color: #60A0B0; font-style: italic }
.pygments-gallery .highlight-friendly .cp { color: #007020 }
.pygments-gallery .highlight-friendly .cpf { color: #60A0B0; font-style: italic }
.pygments-gallery .highlight-friendly .c1 { color: #60A0B0; font-style: italic }
.pygments-gallery .highlight-friendly .cs { color: #60A0B0; background-color: #FFF0F0 }
.pygments-gallery .highlight-friendly .gd { color: #A00000 }
.pygments-gallery .highlight-friendly .ge { font-style: italic }
.pygments-gallery .highlight-friendly .ges { font-weight: bold; font-style: italic }
.pygments-gallery .highlight-friendly .gr { color: #F00 }
.pygments-gallery .highlight-friendly .gh { color: #000080; font-weight: bold }
.pygments-gallery .highlight-friendly .gi { color: #00A000 }
.pygments-gallery .highlight-friendly .go { color: #888 }
.pygments-gallery .highlight-friendly .gp { color: #C65D09; font-weight: bold }
.pygments-gallery .highlight-friendly .gs { font-weight: bold }
.pygments-gallery .highlight-friendly .gu { color: #800080; font-weight: bold }
.pygments-gallery .highlight-friendly .gt { color: #04D }
.pygments-gallery .highlight-friendly .kc { color: #007020; font-weight: bold }
.pygments-gallery .highlight-friendly .kd { color: #007020; font-weight: bold }
.pygments-gallery .highlight-friendly .kn { color: #007020; font-weight: bold }
.pygments-gallery .highlight-friendly .kp { color: #007020 }
.pygments-gallery .highlight-friendly .kr { color: #007020; font-weight: bold }
.pygments-gallery .highlight-friendly .kt { color: #902000 }
.pygments-gallery .highlight-friendly .m { color: #40A070 }
.pygments-gallery .highlight-friendly .s { color: #4070A0 }
.pygments-gallery .highlight-friendly .na { color: #4070A0 }
.pygments-gallery .highlight-friendly .nb { color: #007020 }
.pygments-gallery .highlight-friendly .nc { color: #0E84B5; font-weight: bold }
.pygments-gallery .highlight-friendly .no { color: #60ADD5 }
.pygments-gallery .highlight-friendly .nd { color: #555; font-weight: bold }
.pygments-gallery .highlight-friendly .ni { color: #D55537; font-weight: bold }
.pygments-gallery .highlight-friendly .ne { color: #007020 }
.pygments-gallery .highlight-friendly .nf { color: #06287E }
.pygments-gallery .highlight-friendly .nl { color: #002070; font-weight: bold }
.pygments-gallery .highlight-friendly .nn { color: #0E84B5; font-weight: bold }
.pygments-gallery .highlight-friendly .nt { color: #062873; font-weight: bold }
.pygments-gallery .highlight-friendly .nv { color: #BB60D5 }
.pygments-gallery .highlight-friendly .ow { color: #007020; font-weight: bold }
.pygments-gallery .highlight-friendly .w { color: #BBB }
.pygments-gallery .highlight-friendly .mb { color: #40A070 }
.pygments-gallery .highlight-friendly .mf { color: #40A070 }
.pygments-gallery .highlight-friendly .mh { color: #40A070 }
.pygments-gallery .highlight-friendly .mi { color: #40A070 }
.pygments-gallery .highlight-friendly .mo { color: #40A070 }
.pygments-gallery .highlight-friendly .sa { color: #4070A0 }
.pygments-gallery .highlight-friendly .sb { color: #4070A0 }
.pygments-gallery .highlight-friendly .sc { color: #4070A0 }
.pygments-gallery .highlight-friendly .dl { color: #4070A0 }
.pygments-gallery .highlight-friendly .sd { color: #4070A0; font-style: italic }
.pygments-gallery .highlight-friendly .s2 { color: #4070A0 }
.pygments-gallery .highlight-friendly .se { color: #4070A0; font-weight: bold }
.pygments-gallery .highlight-friendly .sh { color: #4070A0 }
.pygments-gallery .highlight-friendly .si { color: #70A0D0; font-style: italic }
.pygments-gallery .highlight-friendly .sx { color: #C65D09 }
.pygments-gallery .highlight-friendly .sr { color: #235388 }
.pygments-gallery .highlight-friendly .s1 { color: #4070A0 }
.pygments-gallery .highlight-friendly .ss { color: #517918 }
.pygments-gallery .highlight-friendly .bp { color: #007020 }
.pygments-gallery .highlight-friendly .fm { color: #06287E }
.pygments-gallery .highlight-friendly .vc { color: #BB60D5 }
.pygments-gallery .highlight-friendly .vg { color: #BB60D5 }
.pygments-gallery .highlight-friendly .vi { color: #BB60D5 }
.pygments-gallery .highlight-friendly .vm { color: #BB60D5 }
.pygments-gallery .highlight-friendly .il { color: #40A070 }
.pygments-gallery .highlight-friendly_grayscale .hll { background-color: #ffffcc }
.pygments-gallery .highlight-friendly_grayscale { background: #f0f0f0; }
.pygments-gallery .highlight-friendly_grayscale .c { color: #959595; font-style: italic }
.pygments-gallery .highlight-friendly_grayscale .err { border: 1px solid #898989 }
.pygments-gallery .highlight-friendly_grayscale .k { color: #575757; font-weight: bold }
.pygments-gallery .highlight-friendly_grayscale .o { color: #666 }
.pygments-gallery .highlight-friendly_grayscale .ch { color: #959595; font-style: italic }
.pygments-gallery .highlight-friendly_grayscale .cm { color: #959595; font-style: italic }
.pygments-gallery .highlight-friendly_grayscale .cp { color: #575757 }
.pygments-gallery .highlight-friendly_grayscale .cpf { color: #959595; font-style: italic }
.pygments-gallery .highlight-friendly_grayscale .c1 { color: #959595; font-style: italic }
.pygments-gallery .highlight-friendly_grayscale .cs { color: #959595; background-color: #F4F4F4 }
.pygments-gallery .highlight-friendly_grayscale .gd { color: #545454 }
.pygments-gallery .highlight-friendly_grayscale .ge { font-style: italic }
.pygments-gallery .highlight-friendly_grayscale .ges { font-weight: bold; font-style: italic }
.pygments-gallery .highlight-friendly_grayscale .gr { color: #898989 }
.pygments-gallery .highlight-friendly_grayscale .gh { color: #373737; font-weight: bold }
.pygments-gallery .highlight-friendly_grayscale .gi { color: #7D7D7D }
.pygments-gallery .highlight-friendly_grayscale .go { color: #888 }
.pygments-gallery .highlight-friendly_grayscale .gp { color: #7E7E7E; font-weight: bold }
.pygments-gallery .highlight-friendly_grayscale .gs { font-weight: bold }
.pygments-gallery .highlight-friendly_grayscale .gu { color: #5A5A5A; font-weight: bold }
.pygments-gallery .highlight-friendly_grayscale .gt { color: #6D6D6D }
.pygments-gallery .highlight-friendly_grayscale .kc { color: #575757; font-weight: bold }
.pygments-gallery .highlight-friendly_grayscale .kd { color: #575757; font-weight: bold }
.pygments-gallery .highlight-friendly_grayscale .kn { color: #575757; font-weight: bold }
.pygments-gallery .highlight-friendly_grayscale .kp { color: #575757 }
.pygments-gallery .highlight-friendly_grayscale .kr { color: #575757; font-weight: bold }
.pygments-gallery .highlight-friendly_grayscale .kt { color: #4F4F4F }
.pygments-gallery .highlight-friendly_grayscale .m { color: #888 }
.pygments-gallery .highlight-friendly_grayscale .s { color: #717171 }
.pygments-gallery .highlight-friendly_grayscale .na { color: #707070 }
.pygments-gallery .highlight-friendly_grayscale .nb { color: #575757 }
.pygments-gallery .highlight-friendly_grayscale .nc { color: #7E7E7E; font-weight: bold }
.pygments-gallery .highlight-friendly_grayscale .no { color: #A5A5A5 }
.pygments-gallery .highlight-friendly_grayscale .nd { color: #555; font-weight: bold }
.pygments-gallery .highlight-friendly_grayscale .ni { color: #848484; font-weight: bold }
.pygments-gallery .highlight-friendly_grayscale .ne { color: #575757 }
.pygments-gallery .highlight-friendly_grayscale .nf { color: #3F3F3F }
.pygments-gallery .highlight-friendly_grayscale .nl { color: #363636; font-weight: bold }
.pygments-gallery .highlight-friendly_grayscale .nn { color: #7E7E7E; font-weight: bold }
.pygments-gallery .highlight-friendly_grayscale .nt { color: #3B3B3B; font-weight: bold }
.pygments-gallery .highlight-friendly_grayscale .nv { color: #9A9A9A }
.pygments-gallery .highlight-friendly_grayscale .ow { color: #575757; font-weight: bold }
.pygments-gallery .highlight-friendly_grayscale .w { color: #BBB }
.pygments-gallery .highlight-friendly_grayscale .mb { color: #888 }
.pygments-gallery .highlight-friendly_grayscale .mf { color: #888 }
.pygments-gallery .highlight-friendly_grayscale .mh { color: #888 }
.pygments-gallery .highlight-friendly_grayscale .mi { color: #888 }
.pygments-gallery .highlight-friendly_grayscale .mo { color: #888 }
.pygments-gallery .highlight-friendly_grayscale .sa { color: #717171 }
.pygments-gallery .highlight-friendly_grayscale .sb { color: #717171 }
.pygments-gallery .highlight-friendly_grayscale .sc { color: #717171 }
.pygments-gallery .highlight-friendly_grayscale .dl { color: #717171 }
.pygments-gallery .highlight-friendly_grayscale .sd { color: #717171; font-style: italic }
.pygments-gallery .highlight-friendly_grayscale .s2 { color: #717171 }
.pygments-gallery .highlight-friendly_grayscale .se { color: #717171; font-weight: bold }
.pygments-gallery .highlight-friendly_grayscale .sh { color: #717171 }
.pygments-gallery .highlight-friendly_grayscale .si { color: #9F9F9F; font-style: italic }
.pygments-gallery .highlight-friendly_grayscale .sx { color: #7E7E7E }
.pygments-gallery .highlight-friendly_grayscale .sr { color: #575757 }
.pygments-gallery .highlight-friendly_grayscale .s1 { color: #717171 }
.pygments-gallery .highlight-friendly_grayscale .ss { color: #676767 }
.pygments-gallery .highlight-friendly_grayscale .bp { color: #575757 }
.pygments-gallery .highlight-friendly_grayscale .fm { color: #3F3F3F }
.pygments-gallery .highlight-friendly_grayscale .vc { color: #9A9A9A }
.pygments-gallery .highlight-friendly_grayscale .vg { color: #9A9A9A }
.pygments-gallery .highlight-friendly_grayscale .vi { color: #9A9A9A }
.pygments-gallery .highlight-friendly_grayscale .vm { color: #9A9A9A }
.pygments-gallery .highlight-friendly_grayscale .il { color: #888 }
.pygments-gallery .highlight-fruity .hll { background-color: #333333 }
.pygments-gallery .highlight-fruity { background: #111111; color: #FFF }
.pygments-gallery .highlight-fruity .c { color: #080; font-style: italic; background-color: #0F140F }
.pygments-gallery .highlight-fruity .err { color: #FFF }
.pygments-gallery .highlight-fruity .esc { color: #FFF }
.pygments-gallery .highlight-fruity .g { color: #FFF }
.pygments-gallery .highlight-fruity .k { color: #FB660A; font-weight: bold }
.pygments-gallery .highlight-fruity .l { color: #FFF }
.pygments-gallery .highlight-fruity .n { color: #FFF }
.pygments-gallery .highlight-fruity .o { color: #FFF }
.pygments-gallery .highlight-fruity .x { color: #FFF }
.pygments-gallery .highlight-fruity .p { color: #FFF }
.pygments-gallery .highlight-fruity .ch { color: #080; font-style: italic; background-color: #0F140F }
.pygments-gallery .highlight-fruity .cm { color: #080; font-style: italic; background-color: #0F140F }
.pygments-gallery .highlight-fruity .cp { color: #FF0007; font-weight: bold; font-style: italic; background-color: #0F140F }
.pygments-gallery .highlight-fruity .cpf { color: #080; font-style: italic; background-color: #0F140F }
.pygments-gallery .highlight-fruity .c1 { color: #080; font-style: italic; background-color: #0F140F }
.pygments-gallery .highlight-fruity .cs { color: #080; font-style: italic; background-color: #0F140F }
.pygments-gallery .highlight-fruity .gd { color: #FFF }
.pygments-gallery .highlight-fruity .ge { color: #FFF }
.pygments-gallery .highlight-fruity .ges { color: #FFF }
.pygments-gallery .highlight-fruity .gr { color: #FFF }
.pygments-gallery .highlight-fruity .gh { color: #FFF; font-weight: bold }
.pygments-gallery .highlight-fruity .gi { color: #FFF }
.pygments-gallery .highlight-fruity .go { color: #444; background-color: #222 }
.pygments-gallery .highlight-fruity .gp { color: #FFF }
.pygments-gallery .highlight-fruity .gs { color: #FFF }
.pygments-gallery .highlight-fruity .gu { color: #FFF; font-weight: bold }
.pygments-gallery .highlight-fruity .gt { color: #FFF }
.pygments-gallery .highlight-fruity .kc { color: #FB660A; font-weight: bold }
.pygments-gallery .highlight-fruity .kd { color: #FB660A; font-weight: bold }
.pygments-gallery .highlight-fruity .kn { color: #FB660A; font-weight: bold }
.pygments-gallery .highlight-fruity .kp { color: #FB660A }
.pygments-gallery .highlight-fruity .kr { color: #FB660A; font-weight: bold }
.pygments-gallery .highlight-fruity .kt { color: #CDCAA9; font-weight: bold }
.pygments-gallery .highlight-fruity .ld { color: #FFF }
.pygments-gallery .highlight-fruity .m { color: #0086F7; font-weight: bold }
.pygments-gallery .highlight-fruity .s { color: #0086D2 }
.pygments-gallery .highlight-fruity .na { color: #FF0086; font-weight: bold }
.pygments-gallery .highlight-fruity .nb { color: #FFF }
.pygments-gallery .highlight-fruity .nc { color: #FFF }
.pygments-gallery .highlight-fruity .no { color: #0086D2 }
.pygments-gallery .highlight-fruity .nd { color: #FFF }
.pygments-gallery .highlight-fruity .ni { color: #FFF }
.pygments-gallery .highlight-fruity .ne { color: #FFF }
.pygments-gallery .highlight-fruity .nf { color: #FF0086; font-weight: bold }
.pygments-gallery .highlight-fruity .nl { color: #FFF }
.pygments-gallery .highlight-fruity .nn { color: #FFF }
.pygments-gallery .highlight-fruity .nx { color: #FFF }
.pygments-gallery .highlight-fruity .py { color: #FFF }
.pygments-gallery .highlight-fruity .nt { color: #FB660A; font-weight: bold }
.pygments-gallery .highlight-fruity .nv { color: #FB660A }
.pygments-gallery .highlight-fruity .ow { color: #FFF }
.pygments-gallery .highlight-fruity .pm { color: #FFF }
.pygments-gallery .highlight-fruity .w { color: #888 }
.pygments-gallery .highlight-fruity .mb { color: #0086F7; font-weight: bold }
.pygments-gallery .highlight-fruity .mf { color: #0086F7; font-weight: bold }
.pygments-gallery .highlight-fruity .mh { color: #0086F7; font-weight: bold }
.pygments-gallery .highlight-fruity .mi { color: #0086F7; font-weight: bold }
.pygments-gallery .highlight-fruity .mo { color: #0086F7; font-weight: bold }
.pygments-gallery .highlight-fruity .sa { color: #0086D2 }
.pygments-gallery .highlight-fruity .sb { color: #0086D2 }
.pygments-gallery .highlight-fruity .sc { color: #0086D2 }
.pygments-gallery .highlight-fruity .dl { color: #0086D2 }
.pygments-gallery .highlight-fruity .sd { color: #0086D2 }
.pygments-gallery .highlight-fruity .s2 { color: #0086D2 }
.pygments-gallery .highlight-fruity .se { color: #0086D2 }
.pygments-gallery .highlight-fruity .sh { color: #0086D2 }
.pygments-gallery .highlight-fruity .si { color: #0086D2 }
.pygments-gallery .highlight-fruity .sx { color: #0086D2 }
.pygments-gallery .highlight-fruity .sr { color: #0086D2 }
.pygments-gallery .highlight-fruity .s1 { color: #0086D2 }
.pygments-gallery .highlight-fruity .ss { color: #0086D2 }
.pygments-gallery .highlight-fruity .bp { color: #FFF }
.pygments-gallery .highlight-fruity .fm { color: #FF0086; font-weight: bold }
.pygments-gallery .highlight-fruity .vc { color: #FB660A }
.pygments-gallery .highlight-fruity .vg { color: #FB660A }
.pygments-gallery .highlight-fruity .vi { color: #FB660A }
.pygments-gallery .highlight-fruity .vm { color: #FB660A }
.pygments-gallery .highlight-fruity .il { color: #0086F7; font-weight: bold }
.pygments-gallery .highlight-github-dark .hll { background-color: #6e7681 }
.pygments-gallery .highlight-github-dark { background: #0d1117; color: #E6EDF3 }
.pygments-gallery .highlight-github-dark .c { color: #8B949E; font-style: italic }
.pygments-gallery .highlight-github-dark .err { color: #F85149 }
.pygments-gallery .highlight-github-dark .esc { color: #E6EDF3 }
.pygments-gallery .highlight-github-dark .g { color: #E6EDF3 }
.pygments-gallery .highlight-github-dark .k { color: #FF7B72 }
.pygments-gallery .highlight-github-dark .l { color: #A5D6FF }
.pygments-gallery .highlight-github-dark .n { color: #E6EDF3 }
.pygments-gallery .highlight-github-dark .o { color: #FF7B72; font-weight: bold }
.pygments-gallery .highlight-github-dark .x { color: #E6EDF3 }
.pygments-gallery .highlight-github-dark .p { color: #E6EDF3 }
.pygments-gallery .highlight-github-dark .ch { color: #8B949E; font-style: italic }
.pygments-gallery .highlight-github-dark .cm { color: #8B949E; font-style: italic }
.pygments-gallery .highlight-github-dark .cp { color: #8B949E; font-weight: bold; font-style: italic }
.pygments-gallery .highlight-github-dark .cpf { color: #8B949E; font-style: italic }
.pygments-gallery .highlight-github-dark .c1 { color: #8B949E; font-style: italic }
.pygments-gallery .highlight-github-dark .cs { color: #8B949E; font-weight: bold; font-style: italic }
.pygments-gallery .highlight-github-dark .gd { color: #FFA198; background-color: #490202 }
.pygments-gallery .highlight-github-dark .ge { color: #E6EDF3; font-style: italic }
.pygments-gallery .highlight-github-dark .ges { color: #E6EDF3; font-weight: bold; font-style: italic }
.pygments-gallery .highlight-github-dark .gr { color: #FFA198 }
.pygments-gallery .highlight-github-dark .gh { color: #79C0FF; font-weight: bold }
.pygments-gallery .highlight-github-dark .gi { color: #56D364; background-color: #0F5323 }
.pygments-gallery .highlight-github-dark .go { color: #8B949E }
.pygments-gallery .highlight-github-dark .gp { color: #8B949E }
.pygments-gallery .highlight-github-dark .gs { color: #E6EDF3; font-weight: bold }
.pygments-gallery .highlight-github-dark .gu { color: #79C0FF }
.pygments-gallery .highlight-github-dark .gt { color: #FF7B72 }
.pygments-gallery .highlight-github-dark .g-Underline { color: #E6EDF3; text-decoration: underline }
.pygments-gallery .highlight-github-dark .kc { color: #79C0FF }
.pygments-gallery .highlight-github-dark .kd { color: #FF7B72 }
.pygments-gallery .highlight-github-dark .kn { color: #FF7B72 }
.pygments-gallery .highlight-github-dark .kp { color: #79C0FF }
.pygments-gallery .highlight-github-dark .kr { color: #FF7B72 }
.pygments-gallery .highlight-github-dark .kt { color: #FF7B72 }
.pygments-gallery .highlight-github-dark .ld { color: #79C0FF }
.pygments-gallery .highlight-github-dark .m { color: #A5D6FF }
.pygments-gallery .highlight-github-dark .s { color: #A5D6FF }
.pygments-gallery .highlight-github-dark .na { color: #E6EDF3 }
.pygments-gallery .highlight-github-dark .nb { color: #E6EDF3 }
.pygments-gallery .highlight-github-dark .nc { color: #F0883E; font-weight: bold }
.pygments-gallery .highlight-github-dark .no { color: #79C0FF; font-weight: bold }
.pygments-gallery .highlight-github-dark .nd { color: #D2A8FF; font-weight: bold }
.pygments-gallery .highlight-github-dark .ni { color: #FFA657 }
.pygments-gallery .highlight-github-dark .ne { color: #F0883E; font-weight: bold }
.pygments-gallery .highlight-github-dark .nf { color: #D2A8FF; font-weight: bold }
.pygments-gallery .highlight-github-dark .nl { color: #79C0FF; font-weight: bold }
.pygments-gallery .highlight-github-dark .nn { color: #FF7B72 }
.pygments-gallery .highlight-github-dark .nx { color: #E6EDF3 }
.pygments-gallery .highlight-github-dark .py { color: #79C0FF }
.pygments-gallery .highlight-github-dark .nt { color: #7EE787 }
.pygments-gallery .highlight-github-dark .nv { color: #79C0FF }
.pygments-gallery .highlight-github-dark .ow { color: #FF7B72; font-weight: bold }
.pygments-gallery .highlight-github-dark .pm { color: #E6EDF3 }
.pygments-gallery .highlight-github-dark .w { color: #6E7681 }
.pygments-gallery .highlight-github-dark .mb { color: #A5D6FF }
.pygments-gallery .highlight-github-dark .mf { color: #A5D6FF }
.pygments-gallery .highlight-github-dark .mh { color: #A5D6FF }
.pygments-gallery .highlight-github-dark .mi { color: #A5D6FF }
.pygments-gallery .highlight-github-dark .mo { color: #A5D6FF }
.pygments-gallery .highlight-github-dark .sa { color: #79C0FF }
.pygments-gallery .highlight-github-dark .sb { color: #A5D6FF }
.pygments-gallery .highlight-github-dark .sc { color: #A5D6FF }
.pygments-gallery .highlight-github-dark .dl { color: #79C0FF }
.pygments-gallery .highlight-github-dark .sd { color: #A5D6FF }
.pygments-gallery .highlight-github-dark .s2 { color: #A5D6FF }
.pygments-gallery .highlight-github-dark .se { color: #79C0FF }
.pygments-gallery .highlight-github-dark .sh { color: #79C0FF }
.pygments-gallery .highlight-github-dark .si { color: #A5D6FF }
.pygments-gallery .highlight-github-dark .sx { color: #A5D6FF }
.pygments-gallery .highlight-github-dark .sr { color: #79C0FF }
.pygments-gallery .highlight-github-dark .s1 { color: #A5D6FF }
.pygments-gallery .highlight-github-dark .ss { color: #A5D6FF }
.pygments-gallery .highlight-github-dark .bp { color: #E6EDF3 }
.pygments-gallery .highlight-github-dark .fm { color: #D2A8FF; font-weight: bold }
.pygments-gallery .highlight-github-dark .vc { color: #79C0FF }
.pygments-gallery .highlight-github-dark .vg { color: #79C0FF }
.pygments-gallery .highlight-github-dark .vi { color: #79C0FF }
.pygments-gallery .highlight-github-dark .vm { color: #79C0FF }
.pygments-gallery .highlight-github-dark .il { color: #A5D6FF }
.pygments-gallery .highlight-github-dark-colorblind .hll { background-color: #58a6ff70 }
.pygments-gallery .highlight-github-dark-colorblind { background: #0d1117; color: #C9D1D9 }
.pygments-gallery .highlight-github-dark-colorblind .c { color: #B1BAC4 }
.pygments-gallery .highlight-github-dark-colorblind .err { color: #EC8E2C }
.pygments-gallery .highlight-github-dark-colorblind .k { color: #EC8E2C }
.pygments-gallery .highlight-github-dark-colorblind .l { color: #FDAC54 }
.pygments-gallery .highlight-github-dark-colorblind .n { color: #D2A8FF }
.pygments-gallery .highlight-github-dark-colorblind .o { color: #A5D6FF }
.pygments-gallery .highlight-github-dark-colorblind .p { color: #C9D1D9 }
.pygments-gallery .highlight-github-dark-colorblind .ch { color: #B1BAC4 }
.pygments-gallery .highlight-github-dark-colorblind .cm { color: #B1BAC4 }
.pygments-gallery .highlight-github-dark-colorblind .cp { color: #B1BAC4 }
.pygments-gallery .highlight-github-dark-colorblind .cpf { color: #B1BAC4 }
.pygments-gallery .highlight-github-dark-colorblind .c1 { color: #B1BAC4 }
.pygments-gallery .highlight-github-dark-colorblind .cs { color: #B1BAC4 }
.pygments-gallery .highlight-github-dark-colorblind .gd { color: #79C0FF }
.pygments-gallery .highlight-github-dark-colorblind .ge { font-style: italic }
.pygments-gallery .highlight-github-dark-colorblind .gr { color: #EC8E2C }
.pygments-gallery .highlight-github-dark-colorblind .gh { color: #79C0FF }
.pygments-gallery .highlight-github-dark-colorblind .gs { font-weight: bold }
.pygments-gallery .highlight-github-dark-colorblind .gu { color: #79C0FF }
.pygments-gallery .highlight-github-dark-colorblind .kc { color: #79C0FF }
.pygments-gallery .highlight-github-dark-colorblind .kd { color: #EC8E2C }
.pygments-gallery .highlight-github-dark-colorblind .kn { color: #EC8E2C }
.pygments-gallery .highlight-github-dark-colorblind .kp { color: #EC8E2C }
.pygments-gallery .highlight-github-dark-colorblind .kr { color: #EC8E2C }
.pygments-gallery .highlight-github-dark-colorblind .kt { color: #EC8E2C }
.pygments-gallery .highlight-github-dark-colorblind .ld { color: #FDAC54 }
.pygments-gallery .highlight-github-dark-colorblind .m { color: #FDAC54 }
.pygments-gallery .highlight-github-dark-colorblind .s { color: #79C0FF }
.pygments-gallery .highlight-github-dark-colorblind .na { color: #FDAC54 }
.pygments-gallery .highlight-github-dark-colorblind .nb { color: #FDAC54 }
.pygments-gallery .highlight-github-dark-colorblind .nc { color: #79C0FF }
.pygments-gallery .highlight-github-dark-colorblind .no { color: #79C0FF }
.pygments-gallery .highlight-github-dark-colorblind .nd { color: #FDAC54 }
.pygments-gallery .highlight-github-dark-colorblind .ni { color: #A5D6FF }
.pygments-gallery .highlight-github-dark-colorblind .ne { color: #D2A8FF }
.pygments-gallery .highlight-github-dark-colorblind .nf { color: #79C0FF }
.pygments-gallery .highlight-github-dark-colorblind .nl { color: #FDAC54 }
.pygments-gallery .highlight-github-dark-colorblind .nn { color: #C9D1D9 }
.pygments-gallery .highlight-github-dark-colorblind .nx { color: #D2A8FF }
.pygments-gallery .highlight-github-dark-colorblind .py { color: #79C0FF }
.pygments-gallery .highlight-github-dark-colorblind .nt { color: #A5D6FF }
.pygments-gallery .highlight-github-dark-colorblind .nv { color: #FDAC54 }
.pygments-gallery .highlight-github-dark-colorblind .ow { color: #D2A8FF }
.pygments-gallery .highlight-github-dark-colorblind .pm { color: #C9D1D9 }
.pygments-gallery .highlight-github-dark-colorblind .w { color: #C9D1D9 }
.pygments-gallery .highlight-github-dark-colorblind .mb { color: #FDAC54 }
.pygments-gallery .highlight-github-dark-colorblind .mf { color: #FDAC54 }
.pygments-gallery .highlight-github-dark-colorblind .mh { color: #FDAC54 }
.pygments-gallery .highlight-github-dark-colorblind .mi { color: #FDAC54 }
.pygments-gallery .highlight-github-dark-colorblind .mo { color: #FDAC54 }
.pygments-gallery .highlight-github-dark-colorblind .sa { color: #79C0FF }
.pygments-gallery .highlight-github-dark-colorblind .sb { color: #79C0FF }
.pygments-gallery .highlight-github-dark-colorblind .sc { color: #79C0FF }
.pygments-gallery .highlight-github-dark-colorblind .dl { color: #79C0FF }
.pygments-gallery .highlight-github-dark-colorblind .sd { color: #79C0FF }
.pygments-gallery .highlight-github-dark-colorblind .s2 { color: #79C0FF }
.pygments-gallery .highlight-github-dark-colorblind .se { color: #79C0FF }
.pygments-gallery .highlight-github-dark-colorblind .sh { color: #79C0FF }
.pygments-gallery .highlight-github-dark-colorblind .si { color: #79C0FF }
.pygments-gallery .highlight-github-dark-colorblind .sx { color: #79C0FF }
.pygments-gallery .highlight-github-dark-colorblind .sr { color: #79C0FF }
.pygments-gallery .highlight-github-dark-colorblind .s1 { color: #79C0FF }
.pygments-gallery .highlight-github-dark-colorblind .ss { color: #79C0FF }
.pygments-gallery .highlight-github-dark-colorblind .bp { color: #FDAC54 }
.pygments-gallery .highlight-github-dark-colorblind .fm { color: #79C0FF }
.pygments-gallery .highlight-github-dark-colorblind .vc { color: #FDAC54 }
.pygments-gallery .highlight-github-dark-colorblind .vg { color: #FDAC54 }
.pygments-gallery .highlight-github-dark-colorblind .vi { color: #FDAC54 }
.pygments-gallery .highlight-github-dark-colorblind .vm { color: #FDAC54 }
.pygments-gallery .highlight-github-dark-colorblind .il { color: #FDAC54 }
.pygments-gallery .highlight-github-dark-high-contrast .hll { background-color: #58a6ff70 }
.pygments-gallery .highlight-github-dark-high-contrast { background: #0d1117; color: #C9D1D9 }
.pygments-gallery .highlight-github-dark-high-contrast .c { color: #D9DEE3 }
.pygments-gallery .highlight-github-dark-high-contrast .err { color: #FF9492 }
.pygments-gallery .highlight-github-dark-high-contrast .k { color: #FF9492 }
.pygments-gallery .highlight-github-dark-high-contrast .l { color: #FFB757 }
.pygments-gallery .highlight-github-dark-high-contrast .n { color: #DBB7FF }
.pygments-gallery .highlight-github-dark-high-contrast .o { color: #72F088 }
.pygments-gallery .highlight-github-dark-high-contrast .p { color: #C9D1D9 }
.pygments-gallery .highlight-github-dark-high-contrast .ch { color: #D9DEE3 }
.pygments-gallery .highlight-github-dark-high-contrast .cm { color: #D9DEE3 }
.pygments-gallery .highlight-github-dark-high-contrast .cp { color: #D9DEE3 }
.pygments-gallery .highlight-github-dark-high-contrast .cpf { color: #D9DEE3 }
.pygments-gallery .highlight-github-dark-high-contrast .c1 { color: #D9DEE3 }
.pygments-gallery .highlight-github-dark-high-contrast .cs { color: #D9DEE3 }
.pygments-gallery .highlight-github-dark-high-contrast .gd { color: #91CBFF }
.pygments-gallery .highlight-github-dark-high-contrast .ge { font-style: italic }
.pygments-gallery .highlight-github-dark-high-contrast .gr { color: #FF9492 }
.pygments-gallery .highlight-github-dark-high-contrast .gh { color: #91CBFF }
.pygments-gallery .highlight-github-dark-high-contrast .gs { font-weight: bold }
.pygments-gallery .highlight-github-dark-high-contrast .gu { color: #91CBFF }
.pygments-gallery .highlight-github-dark-high-contrast .kc { color: #91CBFF }
.pygments-gallery .highlight-github-dark-high-contrast .kd { color: #FF9492 }
.pygments-gallery .highlight-github-dark-high-contrast .kn { color: #FF9492 }
.pygments-gallery .highlight-github-dark-high-contrast .kp { color: #FF9492 }
.pygments-gallery .highlight-github-dark-high-contrast .kr { color: #FF9492 }
.pygments-gallery .highlight-github-dark-high-contrast .kt { color: #FF9492 }
.pygments-gallery .highlight-github-dark-high-contrast .ld { color: #FFB757 }
.pygments-gallery .highlight-github-dark-high-contrast .m { color: #FFB757 }
.pygments-gallery .highlight-github-dark-high-contrast .s { color: #91CBFF }
.pygments-gallery .highlight-github-dark-high-contrast .na { color: #FFB757 }
.pygments-gallery .highlight-github-dark-high-contrast .nb { color: #FFB757 }
.pygments-gallery .highlight-github-dark-high-contrast .nc { color: #91CBFF }
.pygments-gallery .highlight-github-dark-high-contrast .no { color: #91CBFF }
.pygments-gallery .highlight-github-dark-high-contrast .nd { color: #FFB757 }
.pygments-gallery .highlight-github-dark-high-contrast .ni { color: #72F088 }
.pygments-gallery .highlight-github-dark-high-contrast .ne { color: #DBB7FF }
.pygments-gallery .highlight-github-dark-high-contrast .nf { color: #91CBFF }
.pygments-gallery .highlight-github-dark-high-contrast .nl { color: #FFB757 }
.pygments-gallery .highlight-github-dark-high-contrast .nn { color: #C9D1D9 }
.pygments-gallery .highlight-github-dark-high-contrast .nx { color: #DBB7FF }
.pygments-gallery .highlight-github-dark-high-contrast .py { color: #91CBFF }
.pygments-gallery .highlight-github-dark-high-contrast .nt { color: #72F088 }
.pygments-gallery .highlight-github-dark-high-contrast .nv { color: #FFB757 }
.pygments-gallery .highlight-github-dark-high-contrast .ow { color: #DBB7FF }
.pygments-gallery .highlight-github-dark-high-contrast .pm { color: #C9D1D9 }
.pygments-gallery .highlight-github-dark-high-contrast .w { color: #C9D1D9 }
.pygments-gallery .highlight-github-dark-high-contrast .mb { color: #FFB757 }
.pygments-gallery .highlight-github-dark-high-contrast .mf { color: #FFB757 }
.pygments-gallery .highlight-github-dark-high-contrast .mh { color: #FFB757 }
.pygments-gallery .highlight-github-dark-high-contrast .mi { color: #FFB757 }
.pygments-gallery .highlight-github-dark-high-contrast .mo { color: #FFB757 }
.pygments-gallery .highlight-github-dark-high-contrast .sa { color: #91CBFF }
.pygments-gallery .highlight-github-dark-high-contrast .sb { color: #91CBFF }
.pygments-gallery .highlight-github-dark-high-contrast .sc { color: #91CBFF }
.pygments-gallery .highlight-github-dark-high-contrast .dl { color: #91CBFF }
.pygments-gallery .highlight-github-dark-high-contrast .sd { color: #91CBFF }
.pygments-gallery .highlight-github-dark-high-contrast .s2 { color: #91CBFF }
.pygments-gallery .highlight-github-dark-high-contrast .se { color: #91CBFF }
.pygments-gallery .highlight-github-dark-high-contrast .sh { color: #91CBFF }
.pygments-gallery .highlight-github-dark-high-contrast .si { color: #91CBFF }
.pygments-gallery .highlight-github-dark-high-contrast .sx { color: #91CBFF }
.pygments-gallery .highlight-github-dark-high-contrast .sr { color: #91CBFF }
.pygments-gallery .highlight-github-dark-high-contrast .s1 { color: #91CBFF }
.pygments-gallery .highlight-github-dark-high-contrast .ss { color: #91CBFF }
.pygments-gallery .highlight-github-dark-high-contrast .bp { color: #FFB757 }
.pygments-gallery .highlight-github-dark-high-contrast .fm { color: #91CBFF }
.pygments-gallery .highlight-github-dark-high-contrast .vc { color: #FFB757 }
.pygments-gallery .highlight-github-dark-high-contrast .vg { color: #FFB757 }
.pygments-gallery .highlight-github-dark-high-contrast .vi { color: #FFB757 }
.pygments-gallery .highlight-github-dark-high-contrast .vm { color: #FFB757 }
.pygments-gallery .highlight-github-dark-high-contrast .il { color: #FFB757 }
.pygments-gallery .highlight-github-light .hll { background-color: #0969da4a }
.pygments-gallery .highlight-github-light { background: #ffffff; color: #24292F }
.pygments-gallery .highlight-github-light .c { color: #6E7781 }
.pygments-gallery .highlight-github-light .err { color: #CF222E }
.pygments-gallery .highlight-github-light .k { color: #CF222E }
.pygments-gallery .highlight-github-light .l { color: #953800 }
.pygments-gallery .highlight-github-light .n { color: #8250DF }
.pygments-gallery .highlight-github-light .o { color: #116329 }
.pygments-gallery .highlight-github-light .p { color: #24292F }
.pygments-gallery .highlight-github-light .ch { color: #6E7781 }
.pygments-gallery .highlight-github-light .cm { color: #6E7781 }
.pygments-gallery .highlight-github-light .cp { color: #6E7781 }
.pygments-gallery .highlight-github-light .cpf { color: #6E7781 }
.pygments-gallery .highlight-github-light .c1 { color: #6E7781 }
.pygments-gallery .highlight-github-light .cs { color: #6E7781 }
.pygments-gallery .highlight-github-light .gd { color: #0550AE }
.pygments-gallery .highlight-github-light .ge { font-style: italic }
.pygments-gallery .highlight-github-light .gr { color: #CF222E }
.pygments-gallery .highlight-github-light .gh { color: #0550AE }
.pygments-gallery .highlight-github-light .gs { font-weight: bold }
.pygments-gallery .highlight-github-light .gu { color: #0550AE }
.pygments-gallery .highlight-github-light .kc { color: #0550AE }
.pygments-gallery .highlight-github-light .kd { color: #CF222E }
.pygments-gallery .highlight-github-light .kn { color: #CF222E }
.pygments-gallery .highlight-github-light .kp { color: #CF222E }
.pygments-gallery .highlight-github-light .kr { color: #CF222E }
.pygments-gallery .highlight-github-light .kt { color: #CF222E }
.pygments-gallery .highlight-github-light .ld { color: #953800 }
.pygments-gallery .highlight-github-light .m { color: #953800 }
.pygments-gallery .highlight-github-light .s { color: #0550AE }
.pygments-gallery .highlight-github-light .na { color: #953800 }
.pygments-gallery .highlight-github-light .nb { color: #953800 }
.pygments-gallery .highlight-github-light .nc { color: #0550AE }
.pygments-gallery .highlight-github-light .no { color: #0550AE }
.pygments-gallery .highlight-github-light .nd { color: #953800 }
.pygments-gallery .highlight-github-light .ni { color: #116329 }
.pygments-gallery .highlight-github-light .ne { color: #8250DF }
.pygments-gallery .highlight-github-light .nf { color: #0550AE }
.pygments-gallery .highlight-github-light .nl { color: #953800 }
.pygments-gallery .highlight-github-light .nn { color: #24292F }
.pygments-gallery .highlight-github-light .nx { color: #8250DF }
.pygments-gallery .highlight-github-light .py { color: #0550AE }
.pygments-gallery .highlight-github-light .nt { color: #116329 }
.pygments-gallery .highlight-github-light .nv { color: #953800 }
.pygments-gallery .highlight-github-light .ow { color: #8250DF }
.pygments-gallery .highlight-github-light .pm { color: #24292F }
.pygments-gallery .highlight-github-light .w { color: #24292F }
.pygments-gallery .highlight-github-light .mb { color: #953800 }
.pygments-gallery .highlight-github-light .mf { color: #953800 }
.pygments-gallery .highlight-github-light .mh { color: #953800 }
.pygments-gallery .highlight-github-light .mi { color: #953800 }
.pygments-gallery .highlight-github-light .mo { color: #953800 }
.pygments-gallery .highlight-github-light .sa { color: #0550AE }
.pygments-gallery .highlight-github-light .sb { color: #0550AE }
.pygments-gallery .highlight-github-light .sc { color: #0550AE }
.pygments-gallery .highlight-github-light .dl { color: #0550AE }
.pygments-gallery .highlight-github-light .sd { color: #0550AE }
.pygments-gallery .highlight-github-light .s2 { color: #0550AE }
.pygments-gallery .highlight-github-light .se { color: #0550AE }
.pygments-gallery .highlight-github-light .sh { color: #0550AE }
.pygments-gallery .highlight-github-light .si { color: #0550AE }
.pygments-gallery .highlight-github-light .sx { color: #0550AE }
.pygments-gallery .highlight-github-light .sr { color: #0550AE }
.pygments-gallery .highlight-github-light .s1 { color: #0550AE }
.pygments-gallery .highlight-github-light .ss { color: #0550AE }
.pygments-gallery .highlight-github-light .bp { color: #953800 }
.pygments-gallery .highlight-github-light .fm { color: #0550AE }
.pygments-gallery .highlight-github-light .vc { color: #953800 }
.pygments-gallery .highlight-github-light .vg { color: #953800 }
.pygments-gallery .highlight-github-light .vi { color: #953800 }
.pygments-gallery .highlight-github-light .vm { color: #953800 }
.pygments-gallery .highlight-github-light .il { color: #953800 }
.pygments-gallery .highlight-github-light-colorblind .hll { background-color: #0969da4a }
.pygments-gallery .highlight-github-light-colorblind { background: #ffffff; color: #24292F }
.pygments-gallery .highlight-github-light-colorblind .c { color: #6E7781 }
.pygments-gallery .highlight-github-light-colorblind .err { color: #B35900 }
.pygments-gallery .highlight-github-light-colorblind .k { color: #B35900 }
.pygments-gallery .highlight-github-light-colorblind .l { color: #8A4600 }
.pygments-gallery .highlight-github-light-colorblind .n { color: #8250DF }
.pygments-gallery .highlight-github-light-colorblind .o { color: #0550AE }
.pygments-gallery .highlight-github-light-colorblind .p { color: #24292F }
.pygments-gallery .highlight-github-light-colorblind .ch { color: #6E7781 }
.pygments-gallery .highlight-github-light-colorblind .cm { color: #6E7781 }
.pygments-gallery .highlight-github-light-colorblind .cp { color: #6E7781 }
.pygments-gallery .highlight-github-light-colorblind .cpf { color: #6E7781 }
.pygments-gallery .highlight-github-light-colorblind .c1 { color: #6E7781 }
.pygments-gallery .highlight-github-light-colorblind .cs { color: #6E7781 }
.pygments-gallery .highlight-github-light-colorblind .gd { color: #0550AE }
.pygments-gallery .highlight-github-light-colorblind .ge { font-style: italic }
.pygments-gallery .highlight-github-light-colorblind .gr { color: #B35900 }
.pygments-gallery .highlight-github-light-colorblind .gh { color: #0550AE }
.pygments-gallery .highlight-github-light-colorblind .gs { font-weight: bold }
.pygments-gallery .highlight-github-light-colorblind .gu { color: #0550AE }
.pygments-gallery .highlight-github-light-colorblind .kc { color: #0550AE }
.pygments-gallery .highlight-github-light-colorblind .kd { color: #B35900 }
.pygments-gallery .highlight-github-light-colorblind .kn { color: #B35900 }
.pygments-gallery .highlight-github-light-colorblind .kp { color: #B35900 }
.pygments-gallery .highlight-github-light-colorblind .kr { color: #B35900 }
.pygments-gallery .highlight-github-light-colorblind .kt { color: #B35900 }
.pygments-gallery .highlight-github-light-colorblind .ld { color: #8A4600 }
.pygments-gallery .highlight-github-light-colorblind .m { color: #8A4600 }
.pygments-gallery .highlight-github-light-colorblind .s { color: #0550AE }
.pygments-gallery .highlight-github-light-colorblind .na { color: #8A4600 }
.pygments-gallery .highlight-github-light-colorblind .nb { color: #8A4600 }
.pygments-gallery .highlight-github-light-colorblind .nc { color: #0550AE }
.pygments-gallery .highlight-github-light-colorblind .no { color: #0550AE }
.pygments-gallery .highlight-github-light-colorblind .nd { color: #8A4600 }
.pygments-gallery .highlight-github-light-colorblind .ni { color: #0550AE }
.pygments-gallery .highlight-github-light-colorblind .ne { color: #8250DF }
.pygments-gallery .highlight-github-light-colorblind .nf { color: #0550AE }
.pygments-gallery .highlight-github-light-colorblind .nl { color: #8A4600 }
.pygments-gallery .highlight-github-light-colorblind .nn { color: #24292F }
.pygments-gallery .highlight-github-light-colorblind .nx { color: #8250DF }
.pygments-gallery .highlight-github-light-colorblind .py { color: #0550AE }
.pygments-gallery .highlight-github-light-colorblind .nt { color: #0550AE }
.pygments-gallery .highlight-github-light-colorblind .nv { color: #8A4600 }
.pygments-gallery .highlight-github-light-colorblind .ow { color: #8250DF }
.pygments-gallery .highlight-github-light-colorblind .pm { color: #24292F }
.pygments-gallery .highlight-github-light-colorblind .w { color: #24292F }
.pygments-gallery .highlight-github-light-colorblind .mb { color: #8A4600 }
.pygments-gallery .highlight-github-light-colorblind .mf { color: #8A4600 }
.pygments-gallery .highlight-github-light-colorblind .mh { color: #8A4600 }
.pygments-gallery .highlight-github-light-colorblind .mi { color: #8A4600 }
.pygments-gallery .highlight-github-light-colorblind .mo { color: #8A4600 }
.pygments-gallery .highlight-github-light-colorblind .sa { color: #0550AE }
.pygments-gallery .highlight-github-light-colorblind .sb { color: #0550AE }
.pygments-gallery .highlight-github-light-colorblind .sc { color: #0550AE }
.pygments-gallery .highlight-github-light-colorblind .dl { color: #0550AE }
.pygments-gallery .highlight-github-light-colorblind .sd { color: #0550AE }
.pygments-gallery .highlight-github-light-colorblind .s2 { color: #0550AE }
.pygments-gallery .highlight-github-light-colorblind .se { color: #0550AE }
.pygments-gallery .highlight-github-light-colorblind .sh { color: #0550AE }
.pygments-gallery .highlight-github-light-colorblind .si { color: #0550AE }
.pygments-gallery .highlight-github-light-colorblind .sx { color: #0550AE }
.pygments-gallery .highlight-github-light-colorblind .sr { color: #0550AE }
.pygments-gallery .highlight-github-light-colorblind .s1 { color: #0550AE }
.pygments-gallery .highlight-github-light-colorblind .ss { color: #0550AE }
.pygments-gallery .highlight-github-light-colorblind .bp { color: #8A4600 }
.pygments-gallery .highlight-github-light-colorblind .fm { color: #0550AE }
.pygments-gallery .highlight-github-light-colorblind .vc { color: #8A4600 }
.pygments-gallery .highlight-github-light-colorblind .vg { color: #8A4600 }
.pygments-gallery .highlight-github-light-colorblind .vi { color: #8A4600 }
.pygments-gallery .highlight-github-light-colorblind .vm { color: #8A4600 }
.pygments-gallery .highlight-github-light-colorblind .il { color: #8A4600 }
.pygments-gallery .highlight-github-light-high-contrast .hll { background-color: #0969da4a }
.pygments-gallery .highlight-github-light-high-contrast { background: #ffffff; color: #24292F }
.pygments-gallery .highlight-github-light-high-contrast .c { color: #66707B }
.pygments-gallery .highlight-github-light-high-contrast .err { color: #A0111F }
.pygments-gallery .highlight-github-light-high-contrast .k { color: #A0111F }
.pygments-gallery .highlight-github-light-high-contrast .l { color: #702C00 }
.pygments-gallery .highlight-github-light-high-contrast .n { color: #622CBC }
.pygments-gallery .highlight-github-light-high-contrast .o { color: #024C1A }
.pygments-gallery .highlight-github-light-high-contrast .p { color: #24292F }
.pygments-gallery .highlight-github-light-high-contrast .ch { color: #66707B }
.pygments-gallery .highlight-github-light-high-contrast .cm { color: #66707B }
.pygments-gallery .highlight-github-light-high-contrast .cp { color: #66707B }
.pygments-gallery .highlight-github-light-high-contrast .cpf { color: #66707B }
.pygments-gallery .highlight-github-light-high-contrast .c1 { color: #66707B }
.pygments-gallery .highlight-github-light-high-contrast .cs { color: #66707B }
.pygments-gallery .highlight-github-light-high-contrast .gd { color: #023B95 }
.pygments-gallery .highlight-github-light-high-contrast .ge { font-style: italic }
.pygments-gallery .highlight-github-light-high-contrast .gr { color: #A0111F }
.pygments-gallery .highlight-github-light-high-contrast .gh { color: #023B95 }
.pygments-gallery .highlight-github-light-high-contrast .gs { font-weight: bold }
.pygments-gallery .highlight-github-light-high-contrast .gu { color: #023B95 }
.pygments-gallery .highlight-github-light-high-contrast .kc { color: #023B95 }
.pygments-gallery .highlight-github-light-high-contrast .kd { color: #A0111F }
.pygments-gallery .highlight-github-light-high-contrast .kn { color: #A0111F }
.pygments-gallery .highlight-github-light-high-contrast .kp { color: #A0111F }
.pygments-gallery .highlight-github-light-high-contrast .kr { color: #A0111F }
.pygments-gallery .highlight-github-light-high-contrast .kt { color: #A0111F }
.pygments-gallery .highlight-github-light-high-contrast .ld { color: #702C00 }
.pygments-gallery .highlight-github-light-high-contrast .m { color: #702C00 }
.pygments-gallery .highlight-github-light-high-contrast .s { color: #023B95 }
.pygments-gallery .highlight-github-light-high-contrast .na { color: #702C00 }
.pygments-gallery .highlight-github-light-high-contrast .nb { color: #702C00 }
.pygments-gallery .highlight-github-light-high-contrast .nc { color: #023B95 }
.pygments-gallery .highlight-github-light-high-contrast .no { color: #023B95 }
.pygments-gallery .highlight-github-light-high-contrast .nd { color: #702C00 }
.pygments-gallery .highlight-github-light-high-contrast .ni { color: #024C1A }
.pygments-gallery .highlight-github-light-high-contrast .ne { color: #622CBC }
.pygments-gallery .highlight-github-light-high-contrast .nf { color: #023B95 }
.pygments-gallery .highlight-github-light-high-contrast .nl { color: #702C00 }
.pygments-gallery .highlight-github-light-high-contrast .nn { color: #24292F }
.pygments-gallery .highlight-github-light-high-contrast .nx { color: #622CBC }
.pygments-gallery .highlight-github-light-high-contrast .py { color: #023B95 }
.pygments-gallery .highlight-github-light-high-contrast .nt { color: #024C1A }
.pygments-gallery .highlight-github-light-high-contrast .nv { color: #702C00 }
.pygments-gallery .highlight-github-light-high-contrast .ow { color: #622CBC }
.pygments-gallery .highlight-github-light-high-contrast .pm { color: #24292F }
.pygments-gallery .highlight-github-light-high-contrast .w { color: #24292F }
.pygments-gallery .highlight-github-light-high-contrast .mb { color: #702C00 }
.pygments-gallery .highlight-github-light-high-contrast .mf { color: #702C00 }
.pygments-gallery .highlight-github-light-high-contrast .mh { color: #702C00 }
.pygments-gallery .highlight-github-light-high-contrast .mi { color: #702C00 }
.pygments-gallery .highlight-github-light-high-contrast .mo { color: #702C00 }
.pygments-gallery .highlight-github-light-high-contrast .sa { color: #023B95 }
.pygments-gallery .highlight-github-light-high-contrast .sb { color: #023B95 }
.pygments-gallery .highlight-github-light-high-contrast .sc { color: #023B95 }
.pygments-gallery .highlight-github-light-high-contrast .dl { color: #023B95 }
.pygments-gallery .highlight-github-light-high-contrast .sd { color: #023B95 }
.pygments-gallery .highlight-github-light-high-contrast .s2 { color: #023B95 }
.pygments-gallery .highlight-github-light-high-contrast .se { color: #023B95 }
.pygments-gallery .highlight-github-light-high-contrast .sh { color: #023B95 }
.pygments-gallery .highlight-github-light-high-contrast .si { color: #023B95 }
.pygments-gallery .highlight-github-light-high-contrast .sx { color: #023B95 }
.pygments-gallery .highlight-github-light-high-contrast .sr { color: #023B95 }
.pygments-gallery .highlight-github-light-high-contrast .s1 { color: #023B95 }
.pygments-gallery .highlight-github-light-high-contrast .ss { color: #023B95 }
.pygments-gallery .highlight-github-light-high-contrast .bp { color: #702C00 }
.pygments-gallery .highlight-github-light-high-contrast .fm { color: #023B95 }
.pygments-gallery .highlight-github-light-high-contrast .vc { color: #702C00 }
.pygments-gallery .highlight-github-light-high-contrast .vg { color: #702C00 }
.pygments-gallery .highlight-github-light-high-contrast .vi { color: #702C00 }
.pygments-gallery .highlight-github-light-high-contrast .vm { color: #702C00 }
.pygments-gallery .highlight-github-light-high-contrast .il { color: #702C00 }
.pygments-gallery .highlight-gotthard-dark .hll { background-color: #4c4b4be8 }
.pygments-gallery .highlight-gotthard-dark { background: #000000; color: #F5F5F5 }
.pygments-gallery .highlight-gotthard-dark .c { color: #B19DB4 }
.pygments-gallery .highlight-gotthard-dark .err { color: #AB6369 }
.pygments-gallery .highlight-gotthard-dark .k { color: #B19DB4 }
.pygments-gallery .highlight-gotthard-dark .l { color: #B19DB4 }
.pygments-gallery .highlight-gotthard-dark .n { color: #F5F5F5 }
.pygments-gallery .highlight-gotthard-dark .o { color: #6F98B3 }
.pygments-gallery .highlight-gotthard-dark .p { color: #F5F5F5 }
.pygments-gallery .highlight-gotthard-dark .ch { color: #B19DB4 }
.pygments-gallery .highlight-gotthard-dark .cm { color: #B19DB4 }
.pygments-gallery .highlight-gotthard-dark .cp { color: #B19DB4 }
.pygments-gallery .highlight-gotthard-dark .cpf { color: #B19DB4 }
.pygments-gallery .highlight-gotthard-dark .c1 { color: #B19DB4 }
.pygments-gallery .highlight-gotthard-dark .cs { color: #B19DB4 }
.pygments-gallery .highlight-gotthard-dark .gd { color: #AB6369 }
.pygments-gallery .highlight-gotthard-dark .gh { color: #81B19B }
.pygments-gallery .highlight-gotthard-dark .gs { font-weight: bold }
.pygments-gallery .highlight-gotthard-dark .gu { color: #81B19B }
.pygments-gallery .highlight-gotthard-dark .kc { color: #AB6369 }
.pygments-gallery .highlight-gotthard-dark .kd { color: #B19DB4 }
.pygments-gallery .highlight-gotthard-dark .kn { color: #B19DB4 }
.pygments-gallery .highlight-gotthard-dark .kp { color: #B19DB4 }
.pygments-gallery .highlight-gotthard-dark .kr { color: #B19DB4 }
.pygments-gallery .highlight-gotthard-dark .kt { color: #81B19B }
.pygments-gallery .highlight-gotthard-dark .ld { color: #B19DB4 }
.pygments-gallery .highlight-gotthard-dark .m { color: #AB6369 }
.pygments-gallery .highlight-gotthard-dark .s { color: #81B19B }
.pygments-gallery .highlight-gotthard-dark .na { color: #B19DB4 }
.pygments-gallery .highlight-gotthard-dark .nb { color: #81B19B }
.pygments-gallery .highlight-gotthard-dark .nc { color: #CAAB6D }
.pygments-gallery .highlight-gotthard-dark .no { color: #AB6369 }
.pygments-gallery .highlight-gotthard-dark .nd { color: #81B19B }
.pygments-gallery .highlight-gotthard-dark .ni { color: #81B19B }
.pygments-gallery .highlight-gotthard-dark .ne { color: #AB6369 }
.pygments-gallery .highlight-gotthard-dark .nf { color: #B19DB4 }
.pygments-gallery .highlight-gotthard-dark .nl { color: #81B19B }
.pygments-gallery .highlight-gotthard-dark .nn { color: #CAAB6D }
.pygments-gallery .highlight-gotthard-dark .nx { color: #F5F5F5 }
.pygments-gallery .highlight-gotthard-dark .py { color: #B19DB4 }
.pygments-gallery .highlight-gotthard-dark .nt { color: #AB6369 }
.pygments-gallery .highlight-gotthard-dark .nv { color: #F5F5F5 }
.pygments-gallery .highlight-gotthard-dark .ow { color: #B19DB4 }
.pygments-gallery .highlight-gotthard-dark .pm { color: #F5F5F5 }
.pygments-gallery .highlight-gotthard-dark .w { color: #F5F5F5 }
.pygments-gallery .highlight-gotthard-dark .mb { color: #AB6369 }
.pygments-gallery .highlight-gotthard-dark .mf { color: #AB6369 }
.pygments-gallery .highlight-gotthard-dark .mh { color: #AB6369 }
.pygments-gallery .highlight-gotthard-dark .mi { color: #AB6369 }
.pygments-gallery .highlight-gotthard-dark .mo { color: #AB6369 }
.pygments-gallery .highlight-gotthard-dark .sa { color: #81B19B }
.pygments-gallery .highlight-gotthard-dark .sb { color: #CAAB6D }
.pygments-gallery .highlight-gotthard-dark .sc { color: #81B19B }
.pygments-gallery .highlight-gotthard-dark .dl { color: #81B19B }
.pygments-gallery .highlight-gotthard-dark .sd { color: #81B19B }
.pygments-gallery .highlight-gotthard-dark .s2 { color: #81B19B }
.pygments-gallery .highlight-gotthard-dark .se { color: #6F98B3 }
.pygments-gallery .highlight-gotthard-dark .sh { color: #81B19B }
.pygments-gallery .highlight-gotthard-dark .si { color: #81B19B }
.pygments-gallery .highlight-gotthard-dark .sx { color: #81B19B }
.pygments-gallery .highlight-gotthard-dark .sr { color: #6F98B3 }
.pygments-gallery .highlight-gotthard-dark .s1 { color: #81B19B }
.pygments-gallery .highlight-gotthard-dark .ss { color: #81B19B }
.pygments-gallery .highlight-gotthard-dark .bp { color: #81B19B }
.pygments-gallery .highlight-gotthard-dark .fm { color: #B19DB4 }
.pygments-gallery .highlight-gotthard-dark .vc { color: #F5F5F5 }
.pygments-gallery .highlight-gotthard-dark .vg { color: #F5F5F5 }
.pygments-gallery .highlight-gotthard-dark .vi { color: #F5F5F5 }
.pygments-gallery .highlight-gotthard-dark .vm { color: #F5F5F5 }
.pygments-gallery .highlight-gotthard-dark .il { color: #AB6369 }
.pygments-gallery .highlight-gotthard-light .hll { background-color: #E1E1E1 }
.pygments-gallery .highlight-gotthard-light { background: #F5F5F5; color: #141414 }
.pygments-gallery .highlight-gotthard-light .c { color: #974EB7 }
.pygments-gallery .highlight-gotthard-light .err { color: #9F4E55 }
.pygments-gallery .highlight-gotthard-light .k { color: #974EB7 }
.pygments-gallery .highlight-gotthard-light .l { color: #974EB7 }
.pygments-gallery .highlight-gotthard-light .n { color: #141414 }
.pygments-gallery .highlight-gotthard-light .o { color: #3D73A9 }
.pygments-gallery .highlight-gotthard-light .p { color: #141414 }
.pygments-gallery .highlight-gotthard-light .ch { color: #974EB7 }
.pygments-gallery .highlight-gotthard-light .cm { color: #974EB7 }
.pygments-gallery .highlight-gotthard-light .cp { color: #974EB7 }
.pygments-gallery .highlight-gotthard-light .cpf { color: #974EB7 }
.pygments-gallery .highlight-gotthard-light .c1 { color: #974EB7 }
.pygments-gallery .highlight-gotthard-light .cs { color: #974EB7 }
.pygments-gallery .highlight-gotthard-light .gd { color: #9F4E55 }
.pygments-gallery .highlight-gotthard-light .gh { color: #437A6B }
.pygments-gallery .highlight-gotthard-light .gs { font-weight: bold }
.pygments-gallery .highlight-gotthard-light .gu { color: #437A6B }
.pygments-gallery .highlight-gotthard-light .kc { color: #9F4E55 }
.pygments-gallery .highlight-gotthard-light .kd { color: #974EB7 }
.pygments-gallery .highlight-gotthard-light .kn { color: #974EB7 }
.pygments-gallery .highlight-gotthard-light .kp { color: #974EB7 }
.pygments-gallery .highlight-gotthard-light .kr { color: #974EB7 }
.pygments-gallery .highlight-gotthard-light .kt { color: #437A6B }
.pygments-gallery .highlight-gotthard-light .ld { color: #974EB7 }
.pygments-gallery .highlight-gotthard-light .m { color: #9F4E55 }
.pygments-gallery .highlight-gotthard-light .s { color: #437A6B }
.pygments-gallery .highlight-gotthard-light .na { color: #974EB7 }
.pygments-gallery .highlight-gotthard-light .nb { color: #437A6B }
.pygments-gallery .highlight-gotthard-light .nc { color: #98661B }
.pygments-gallery .highlight-gotthard-light .no { color: #9F4E55 }
.pygments-gallery .highlight-gotthard-light .nd { color: #437A6B }
.pygments-gallery .highlight-gotthard-light .ni { color: #437A6B }
.pygments-gallery .highlight-gotthard-light .ne { color: #9F4E55 }
.pygments-gallery .highlight-gotthard-light .nf { color: #974EB7 }
.pygments-gallery .highlight-gotthard-light .nl { color: #437A6B }
.pygments-gallery .highlight-gotthard-light .nn { color: #98661B }
.pygments-gallery .highlight-gotthard-light .nx { color: #141414 }
.pygments-gallery .highlight-gotthard-light .py { color: #974EB7 }
.pygments-gallery .highlight-gotthard-light .nt { color: #9F4E55 }
.pygments-gallery .highlight-gotthard-light .nv { color: #141414 }
.pygments-gallery .highlight-gotthard-light .ow { color: #974EB7 }
.pygments-gallery .highlight-gotthard-light .pm { color: #141414 }
.pygments-gallery .highlight-gotthard-light .w { color: #141414 }
.pygments-gallery .highlight-gotthard-light .mb { color: #9F4E55 }
.pygments-gallery .highlight-gotthard-light .mf { color: #9F4E55 }
.pygments-gallery .highlight-gotthard-light .mh { color: #9F4E55 }
.pygments-gallery .highlight-gotthard-light .mi { color: #9F4E55 }
.pygments-gallery .highlight-gotthard-light .mo { color: #9F4E55 }
.pygments-gallery .highlight-gotthard-light .sa { color: #437A6B }
.pygments-gallery .highlight-gotthard-light .sb { color: #98661B }
.pygments-gallery .highlight-gotthard-light .sc { color: #437A6B }
.pygments-gallery .highlight-gotthard-light .dl { color: #437A6B }
.pygments-gallery .highlight-gotthard-light .sd { color: #437A6B }
.pygments-gallery .highlight-gotthard-light .s2 { color: #437A6B }
.pygments-gallery .highlight-gotthard-light .se { color: #3D73A9 }
.pygments-gallery .highlight-gotthard-light .sh { color: #437A6B }
.pygments-gallery .highlight-gotthard-light .si { color: #437A6B }
.pygments-gallery .highlight-gotthard-light .sx { color: #437A6B }
.pygments-gallery .highlight-gotthard-light .sr { color: #3D73A9 }
.pygments-gallery .highlight-gotthard-light .s1 { color: #437A6B }
.pygments-gallery .highlight-gotthard-light .ss { color: #437A6B }
.pygments-gallery .highlight-gotthard-light .bp { color: #437A6B }
.pygments-gallery .highlight-gotthard-light .fm { color: #974EB7 }
.pygments-gallery .highlight-gotthard-light .vc { color: #141414 }
.pygments-gallery .highlight-gotthard-light .vg { color: #141414 }
.pygments-gallery .highlight-gotthard-light .vi { color: #141414 }
.pygments-gallery .highlight-gotthard-light .vm { color: #141414 }
.pygments-gallery .highlight-gotthard-light .il { color: #9F4E55 }
.pygments-gallery .highlight-greative .hll { background-color: #473d18 }
.pygments-gallery .highlight-greative { background: #010726; color: #A2BFFC }
.pygments-gallery .highlight-greative .c { color: #797979 }
.pygments-gallery .highlight-greative .err { color: #A2BFFC }
.pygments-gallery .highlight-greative .k { color: #9E86C8 }
.pygments-gallery .highlight-greative .l { color: #A2BFFC }
.pygments-gallery .highlight-greative .n { color: #A2BFFC }
.pygments-gallery .highlight-greative .o { color: #F78C6C }
.pygments-gallery .highlight-greative .p { color: #A2BFFC }
.pygments-gallery .highlight-greative .ch { color: #797979 }
.pygments-gallery .highlight-greative .cm { color: #797979 }
.pygments-gallery .highlight-greative .cp { color: #797979 }
.pygments-gallery .highlight-greative .cpf { color: #797979 }
.pygments-gallery .highlight-greative .c1 { color: #797979 }
.pygments-gallery .highlight-greative .cs { color: #797979 }
.pygments-gallery .highlight-greative .gd { color: #A2BFFC }
.pygments-gallery .highlight-greative .ge { font-style: italic }
.pygments-gallery .highlight-greative .gh { color: #A2BFFC }
.pygments-gallery .highlight-greative .gs { font-weight: bold }
.pygments-gallery .highlight-greative .gu { color: #A2BFFC }
.pygments-gallery .highlight-greative .kc { color: #9E86C8 }
.pygments-gallery .highlight-greative .kd { color: #9E86C8 }
.pygments-gallery .highlight-greative .kn { color: #9E86C8 }
.pygments-gallery .highlight-greative .kp { color: #9E86C8 }
.pygments-gallery .highlight-greative .kr { color: #9E86C8 }
.pygments-gallery .highlight-greative .kt { color: #C5E478 }
.pygments-gallery .highlight-greative .ld { color: #A2BFFC }
.pygments-gallery .highlight-greative .m { color: #9E86C8 }
.pygments-gallery .highlight-greative .s { color: #9E8741 }
.pygments-gallery .highlight-greative .na { color: #9E86C8 }
.pygments-gallery .highlight-greative .nb { color: #C5E478 }
.pygments-gallery .highlight-greative .nc { color: #F78C6C }
.pygments-gallery .highlight-greative .no { color: #A2BFFC }
.pygments-gallery .highlight-greative .nd { color: #9E8741 }
.pygments-gallery .highlight-greative .ni { color: #9E8741 }
.pygments-gallery .highlight-greative .ne { color: #A2BFFC }
.pygments-gallery .highlight-greative .nf { color: #9E86C8 }
.pygments-gallery .highlight-greative .nl { color: #F78C6C }
.pygments-gallery .highlight-greative .nn { color: #C5E478 }
.pygments-gallery .highlight-greative .nx { color: #A2BFFC }
.pygments-gallery .highlight-greative .py { color: #A2BFFC }
.pygments-gallery .highlight-greative .nt { color: #5CA7E4 }
.pygments-gallery .highlight-greative .nv { color: #C5E478 }
.pygments-gallery .highlight-greative .ow { color: #9E86C8 }
.pygments-gallery .highlight-greative .pm { color: #A2BFFC }
.pygments-gallery .highlight-greative .w { color: #A2BFFC }
.pygments-gallery .highlight-greative .mb { color: #9E86C8 }
.pygments-gallery .highlight-greative .mf { color: #9E86C8 }
.pygments-gallery .highlight-greative .mh { color: #9E86C8 }
.pygments-gallery .highlight-greative .mi { color: #9E86C8 }
.pygments-gallery .highlight-greative .mo { color: #9E86C8 }
.pygments-gallery .highlight-greative .sa { color: #9E8741 }
.pygments-gallery .highlight-greative .sb { color: #9E8741 }
.pygments-gallery .highlight-greative .sc { color: #9E8741 }
.pygments-gallery .highlight-greative .dl { color: #9E8741 }
.pygments-gallery .highlight-greative .sd { color: #9E8741 }
.pygments-gallery .highlight-greative .s2 { color: #9E8741 }
.pygments-gallery .highlight-greative .se { color: #F78C6C }
.pygments-gallery .highlight-greative .sh { color: #9E8741 }
.pygments-gallery .highlight-greative .si { color: #9E8741 }
.pygments-gallery .highlight-greative .sx { color: #9E8741 }
.pygments-gallery .highlight-greative .sr { color: #5CA7E4 }
.pygments-gallery .highlight-greative .s1 { color: #9E8741 }
.pygments-gallery .highlight-greative .ss { color: #F78C6C }
.pygments-gallery .highlight-greative .bp { color: #C5E478 }
.pygments-gallery .highlight-greative .fm { color: #9E86C8 }
.pygments-gallery .highlight-greative .vc { color: #C5E478 }
.pygments-gallery .highlight-greative .vg { color: #C5E478 }
.pygments-gallery .highlight-greative .vi { color: #C5E478 }
.pygments-gallery .highlight-greative .vm { color: #F78C6C }
.pygments-gallery .highlight-greative .il { color: #9E86C8 }
.pygments-gallery .highlight-gruvbox-dark .hll { background-color: #ebdbb2 }
.pygments-gallery .highlight-gruvbox-dark { background: #282828; color: #DDD }
.pygments-gallery .highlight-gruvbox-dark .c { color: #928374; font-style: italic }
.pygments-gallery .highlight-gruvbox-dark .err { color: #282828; background-color: #FB4934 }
.pygments-gallery .highlight-gruvbox-dark .esc { color: #DDD }
.pygments-gallery .highlight-gruvbox-dark .g { color: #DDD }
.pygments-gallery .highlight-gruvbox-dark .k { color: #FB4934 }
.pygments-gallery .highlight-gruvbox-dark .l { color: #DDD }
.pygments-gallery .highlight-gruvbox-dark .n { color: #DDD }
.pygments-gallery .highlight-gruvbox-dark .o { color: #DDD }
.pygments-gallery .highlight-gruvbox-dark .x { color: #DDD }
.pygments-gallery .highlight-gruvbox-dark .p { color: #DDD }
.pygments-gallery .highlight-gruvbox-dark .ch { color: #928374; font-style: italic }
.pygments-gallery .highlight-gruvbox-dark .cm { color: #928374; font-style: italic }
.pygments-gallery .highlight-gruvbox-dark .c-PreProc { color: #8EC07C; font-style: italic }
.pygments-gallery .highlight-gruvbox-dark .cp { color: #928374; font-style: italic }
.pygments-gallery .highlight-gruvbox-dark .cpf { color: #928374; font-style: italic }
.pygments-gallery .highlight-gruvbox-dark .c1 { color: #928374; font-style: italic }
.pygments-gallery .highlight-gruvbox-dark .cs { color: #EBDBB2; font-weight: bold; font-style: italic }
.pygments-gallery .highlight-gruvbox-dark .gd { color: #282828; background-color: #FB4934 }
.pygments-gallery .highlight-gruvbox-dark .ge { color: #DDD; font-style: italic }
.pygments-gallery .highlight-gruvbox-dark .ges { color: #DDD; font-weight: bold; font-style: italic }
.pygments-gallery .highlight-gruvbox-dark .gr { color: #FB4934 }
.pygments-gallery .highlight-gruvbox-dark .gh { color: #EBDBB2; font-weight: bold }
.pygments-gallery .highlight-gruvbox-dark .gi { color: #282828; background-color: #B8BB26 }
.pygments-gallery .highlight-gruvbox-dark .go { color: #F2E5BC }
.pygments-gallery .highlight-gruvbox-dark .gp { color: #A89984 }
.pygments-gallery .highlight-gruvbox-dark .gs { color: #DDD; font-weight: bold }
.pygments-gallery .highlight-gruvbox-dark .gu { color: #EBDBB2; text-decoration: underline }
.pygments-gallery .highlight-gruvbox-dark .gt { color: #FB4934 }
.pygments-gallery .highlight-gruvbox-dark .kc { color: #FB4934 }
.pygments-gallery .highlight-gruvbox-dark .kd { color: #FB4934 }
.pygments-gallery .highlight-gruvbox-dark .kn { color: #FB4934 }
.pygments-gallery .highlight-gruvbox-dark .kp { color: #FB4934 }
.pygments-gallery .highlight-gruvbox-dark .kr { color: #FB4934 }
.pygments-gallery .highlight-gruvbox-dark .kt { color: #FB4934 }
.pygments-gallery .highlight-gruvbox-dark .ld { color: #DDD }
.pygments-gallery .highlight-gruvbox-dark .m { color: #D3869B }
.pygments-gallery .highlight-gruvbox-dark .s { color: #B8BB26 }
.pygments-gallery .highlight-gruvbox-dark .na { color: #FABD2F }
.pygments-gallery .highlight-gruvbox-dark .nb { color: #FE8019 }
.pygments-gallery .highlight-gruvbox-dark .nc { color: #8EC07C }
.pygments-gallery .highlight-gruvbox-dark .no { color: #D3869B }
.pygments-gallery .highlight-gruvbox-dark .nd { color: #FB4934 }
.pygments-gallery .highlight-gruvbox-dark .ni { color: #DDD }
.pygments-gallery .highlight-gruvbox-dark .ne { color: #FB4934 }
.pygments-gallery .highlight-gruvbox-dark .nf { color: #8EC07C }
.pygments-gallery .highlight-gruvbox-dark .nl { color: #DDD }
.pygments-gallery .highlight-gruvbox-dark .nn { color: #8EC07C }
.pygments-gallery .highlight-gruvbox-dark .nx { color: #DDD }
.pygments-gallery .highlight-gruvbox-dark .py { color: #DDD }
.pygments-gallery .highlight-gruvbox-dark .nt { color: #8EC07C }
.pygments-gallery .highlight-gruvbox-dark .nv { color: #83A598 }
.pygments-gallery .highlight-gruvbox-dark .ow { color: #FB4934 }
.pygments-gallery .highlight-gruvbox-dark .pm { color: #DDD }
.pygments-gallery .highlight-gruvbox-dark .w { color: #DDD }
.pygments-gallery .highlight-gruvbox-dark .mb { color: #D3869B }
.pygments-gallery .highlight-gruvbox-dark .mf { color: #D3869B }
.pygments-gallery .highlight-gruvbox-dark .mh { color: #D3869B }
.pygments-gallery .highlight-gruvbox-dark .mi { color: #D3869B }
.pygments-gallery .highlight-gruvbox-dark .mo { color: #D3869B }
.pygments-gallery .highlight-gruvbox-dark .sa { color: #B8BB26 }
.pygments-gallery .highlight-gruvbox-dark .sb { color: #B8BB26 }
.pygments-gallery .highlight-gruvbox-dark .sc { color: #B8BB26 }
.pygments-gallery .highlight-gruvbox-dark .dl { color: #B8BB26 }
.pygments-gallery .highlight-gruvbox-dark .sd { color: #B8BB26 }
.pygments-gallery .highlight-gruvbox-dark .s2 { color: #B8BB26 }
.pygments-gallery .highlight-gruvbox-dark .se { color: #FE8019 }
.pygments-gallery .highlight-gruvbox-dark .sh { color: #B8BB26 }
.pygments-gallery .highlight-gruvbox-dark .si { color: #B8BB26 }
.pygments-gallery .highlight-gruvbox-dark .sx { color: #B8BB26 }
.pygments-gallery .highlight-gruvbox-dark .sr { color: #B8BB26 }
.pygments-gallery .highlight-gruvbox-dark .s1 { color: #B8BB26 }
.pygments-gallery .highlight-gruvbox-dark .ss { color: #B8BB26 }
.pygments-gallery .highlight-gruvbox-dark .bp { color: #FE8019 }
.pygments-gallery .highlight-gruvbox-dark .fm { color: #8EC07C }
.pygments-gallery .highlight-gruvbox-dark .vc { color: #83A598 }
.pygments-gallery .highlight-gruvbox-dark .vg { color: #83A598 }
.pygments-gallery .highlight-gruvbox-dark .vi { color: #83A598 }
.pygments-gallery .highlight-gruvbox-dark .vm { color: #83A598 }
.pygments-gallery .highlight-gruvbox-dark .il { color: #D3869B }
.pygments-gallery .highlight-gruvbox-light .hll { background-color: #3c3836 }
.pygments-gallery .highlight-gruvbox-light { background: #fbf1c7; }
.pygments-gallery .highlight-gruvbox-light .c { color: #928374; font-style: italic }
.pygments-gallery .highlight-gruvbox-light .err { color: #FBF1C7; background-color: #9D0006 }
.pygments-gallery .highlight-gruvbox-light .k { color: #9D0006 }
.pygments-gallery .highlight-gruvbox-light .ch { color: #928374; font-style: italic }
.pygments-gallery .highlight-gruvbox-light .cm { color: #928374; font-style: italic }
.pygments-gallery .highlight-gruvbox-light .c-PreProc { color: #427B58; font-style: italic }
.pygments-gallery .highlight-gruvbox-light .cp { color: #928374; font-style: italic }
.pygments-gallery .highlight-gruvbox-light .cpf { color: #928374; font-style: italic }
.pygments-gallery .highlight-gruvbox-light .c1 { color: #928374; font-style: italic }
.pygments-gallery .highlight-gruvbox-light .cs { color: #3C3836; font-weight: bold; font-style: italic }
.pygments-gallery .highlight-gruvbox-light .gd { color: #FBF1C7; background-color: #9D0006 }
.pygments-gallery .highlight-gruvbox-light .ge { font-style: italic }
.pygments-gallery .highlight-gruvbox-light .gr { color: #9D0006 }
.pygments-gallery .highlight-gruvbox-light .gh { color: #3C3836; font-weight: bold }
.pygments-gallery .highlight-gruvbox-light .gi { color: #FBF1C7; background-color: #79740E }
.pygments-gallery .highlight-gruvbox-light .go { color: #32302F }
.pygments-gallery .highlight-gruvbox-light .gp { color: #7C6F64 }
.pygments-gallery .highlight-gruvbox-light .gs { font-weight: bold }
.pygments-gallery .highlight-gruvbox-light .gu { color: #3C3836; text-decoration: underline }
.pygments-gallery .highlight-gruvbox-light .gt { color: #9D0006 }
.pygments-gallery .highlight-gruvbox-light .kc { color: #9D0006 }
.pygments-gallery .highlight-gruvbox-light .kd { color: #9D0006 }
.pygments-gallery .highlight-gruvbox-light .kn { color: #9D0006 }
.pygments-gallery .highlight-gruvbox-light .kp { color: #9D0006 }
.pygments-gallery .highlight-gruvbox-light .kr { color: #9D0006 }
.pygments-gallery .highlight-gruvbox-light .kt { color: #9D0006 }
.pygments-gallery .highlight-gruvbox-light .m { color: #8F3F71 }
.pygments-gallery .highlight-gruvbox-light .s { color: #79740E }
.pygments-gallery .highlight-gruvbox-light .na { color: #B57614 }
.pygments-gallery .highlight-gruvbox-light .nb { color: #AF3A03 }
.pygments-gallery .highlight-gruvbox-light .nc { color: #427B58 }
.pygments-gallery .highlight-gruvbox-light .no { color: #8F3F71 }
.pygments-gallery .highlight-gruvbox-light .nd { color: #9D0006 }
.pygments-gallery .highlight-gruvbox-light .ne { color: #9D0006 }
.pygments-gallery .highlight-gruvbox-light .nf { color: #427B58 }
.pygments-gallery .highlight-gruvbox-light .nn { color: #427B58 }
.pygments-gallery .highlight-gruvbox-light .nt { color: #427B58 }
.pygments-gallery .highlight-gruvbox-light .nv { color: #076678 }
.pygments-gallery .highlight-gruvbox-light .ow { color: #9D0006 }
.pygments-gallery .highlight-gruvbox-light .mb { color: #8F3F71 }
.pygments-gallery .highlight-gruvbox-light .mf { color: #8F3F71 }
.pygments-gallery .highlight-gruvbox-light .mh { color: #8F3F71 }
.pygments-gallery .highlight-gruvbox-light .mi { color: #8F3F71 }
.pygments-gallery .highlight-gruvbox-light .mo { color: #8F3F71 }
.pygments-gallery .highlight-gruvbox-light .sa { color: #79740E }
.pygments-gallery .highlight-gruvbox-light .sb { color: #79740E }
.pygments-gallery .highlight-gruvbox-light .sc { color: #79740E }
.pygments-gallery .highlight-gruvbox-light .dl { color: #79740E }
.pygments-gallery .highlight-gruvbox-light .sd { color: #79740E }
.pygments-gallery .highlight-gruvbox-light .s2 { color: #79740E }
.pygments-gallery .highlight-gruvbox-light .se { color: #AF3A03 }
.pygments-gallery .highlight-gruvbox-light .sh { color: #79740E }
.pygments-gallery .highlight-gruvbox-light .si { color: #79740E }
.pygments-gallery .highlight-gruvbox-light .sx { color: #79740E }
.pygments-gallery .highlight-gruvbox-light .sr { color: #79740E }
.pygments-gallery .highlight-gruvbox-light .s1 { color: #79740E }
.pygments-gallery .highlight-gruvbox-light .ss { color: #79740E }
.pygments-gallery .highlight-gruvbox-light .bp { color: #AF3A03 }
.pygments-gallery .highlight-gruvbox-light .fm { color: #427B58 }
.pygments-gallery .highlight-gruvbox-light .vc { color: #076678 }
.pygments-gallery .highlight-gruvbox-light .vg { color: #076678 }
.pygments-gallery .highlight-gruvbox-light .vi { color: #076678 }
.pygments-gallery .highlight-gruvbox-light .vm { color: #076678 }
.pygments-gallery .highlight-gruvbox-light .il { color: #8F3F71 }
.pygments-gallery .highlight-igor .hll { background-color: #ffffcc }
.pygments-gallery .highlight-igor { background: #ffffff; }
.pygments-gallery .highlight-igor .c { color: #F00; font-style: italic }
.pygments-gallery .highlight-igor .k { color: #00F }
.pygments-gallery .highlight-igor .ch { color: #F00; font-style: italic }
.pygments-gallery .highlight-igor .cm { color: #F00; font-style: italic }
.pygments-gallery .highlight-igor .cp { color: #F00; font-style: italic }
.pygments-gallery .highlight-igor .cpf { color: #F00; font-style: italic }
.pygments-gallery .highlight-igor .c1 { color: #F00; font-style: italic }
.pygments-gallery .highlight-igor .cs { color: #F00; font-style: italic }
.pygments-gallery .highlight-igor .kc { color: #00F }
.pygments-gallery .highlight-igor .kd { color: #00F }
.pygments-gallery .highlight-igor .kn { color: #00F }
.pygments-gallery .highlight-igor .kp { color: #00F }
.pygments-gallery .highlight-igor .kr { color: #00F }
.pygments-gallery .highlight-igor .kt { color: #00F }
.pygments-gallery .highlight-igor .s { color: #009C00 }
.pygments-gallery .highlight-igor .nc { color: #007575 }
.pygments-gallery .highlight-igor .nd { color: #CC00A3 }
.pygments-gallery .highlight-igor .nf { color: #C34E00 }
.pygments-gallery .highlight-igor .sa { color: #009C00 }
.pygments-gallery .highlight-igor .sb { color: #009C00 }
.pygments-gallery .highlight-igor .sc { color: #009C00 }
.pygments-gallery .highlight-igor .dl { color: #009C00 }
.pygments-gallery .highlight-igor .sd { color: #009C00 }
.pygments-gallery .highlight-igor .s2 { color: #009C00 }
.pygments-gallery .highlight-igor .se { color: #009C00 }
.pygments-gallery .highlight-igor .sh { color: #009C00 }
.pygments-gallery .highlight-igor .si { color: #009C00 }
.pygments-gallery .highlight-igor .sx { color: #009C00 }
.pygments-gallery .highlight-igor .sr { color: #009C00 }
.pygments-gallery .highlight-igor .s1 { color: #009C00 }
.pygments-gallery .highlight-igor .ss { color: #009C00 }
.pygments-gallery .highlight-igor .fm { color: #C34E00 }
.pygments-gallery .highlight-inkpot .hll { background-color: #ffffcc }
.pygments-gallery .highlight-inkpot { background: #1e1e27; color: #CFBFAD }
.pygments-gallery .highlight-inkpot .c { color: #CD8B00 }
.pygments-gallery .highlight-inkpot .err { color: #FFF; background-color: #6E2E2E }
.pygments-gallery .highlight-inkpot .k { color: #808BED }
.pygments-gallery .highlight-inkpot .n { color: #CFBFAD }
.pygments-gallery .highlight-inkpot .o { color: #666 }
.pygments-gallery .highlight-inkpot .x { color: #CFBFAD }
.pygments-gallery .highlight-inkpot .p { color: #CFBFAD }
.pygments-gallery .highlight-inkpot .ch { color: #CD8B00 }
.pygments-gallery .highlight-inkpot .cm { color: #CD8B00 }
.pygments-gallery .highlight-inkpot .cp { color: #409090 }
.pygments-gallery .highlight-inkpot .cpf { color: #FFCD8B; background-color: #404040 }
.pygments-gallery .highlight-inkpot .c1 { color: #CD8B00 }
.pygments-gallery .highlight-inkpot .cs { color: #808BED }
.pygments-gallery .highlight-inkpot .gd { color: #A00000 }
.pygments-gallery .highlight-inkpot .ge { font-style: italic }
.pygments-gallery .highlight-inkpot .ges { font-weight: bold; font-style: italic }
.pygments-gallery .highlight-inkpot .gr { color: #F00 }
.pygments-gallery .highlight-inkpot .gh { color: #000080; font-weight: bold }
.pygments-gallery .highlight-inkpot .gi { color: #00A000 }
.pygments-gallery .highlight-inkpot .go { color: #888 }
.pygments-gallery .highlight-inkpot .gp { color: #000080; font-weight: bold }
.pygments-gallery .highlight-inkpot .gs { font-weight: bold }
.pygments-gallery .highlight-inkpot .gu { color: #800080; font-weight: bold }
.pygments-gallery .highlight-inkpot .gt { color: #04D }
.pygments-gallery .highlight-inkpot .kc { color: #808BED }
.pygments-gallery .highlight-inkpot .kd { color: #808BED }
.pygments-gallery .highlight-inkpot .kn { color: #808BED }
.pygments-gallery .highlight-inkpot .kp { color: #808BED }
.pygments-gallery .highlight-inkpot .kr { color: #808BED }
.pygments-gallery .highlight-inkpot .kt { color: #FF8BFF }
.pygments-gallery .highlight-inkpot .m { color: #F0AD6D }
.pygments-gallery .highlight-inkpot .s { color: #FFCD8B; background-color: #404040 }
.pygments-gallery .highlight-inkpot .na { color: #CFBFAD }
.pygments-gallery .highlight-inkpot .nb { color: #808BED }
.pygments-gallery .highlight-inkpot .nc { color: #FF8BFF }
.pygments-gallery .highlight-inkpot .no { color: #409090 }
.pygments-gallery .highlight-inkpot .nd { color: #409090 }
.pygments-gallery .highlight-inkpot .ni { color: #CFBFAD }
.pygments-gallery .highlight-inkpot .ne { color: #F00 }
.pygments-gallery .highlight-inkpot .nf { color: #C080D0 }
.pygments-gallery .highlight-inkpot .nl { color: #808BED }
.pygments-gallery .highlight-inkpot .nn { color: #F00 }
.pygments-gallery .highlight-inkpot .nx { color: #CFBFAD }
.pygments-gallery .highlight-inkpot .py { color: #CFBFAD }
.pygments-gallery .highlight-inkpot .nt { color: #CFBFAD }
.pygments-gallery .highlight-inkpot .nv { color: #CFBFAD }
.pygments-gallery .highlight-inkpot .ow { color: #666 }
.pygments-gallery .highlight-inkpot .pm { color: #CFBFAD }
.pygments-gallery .highlight-inkpot .w { color: #434357 }
.pygments-gallery .highlight-inkpot .mb { color: #F0AD6D }
.pygments-gallery .highlight-inkpot .mf { color: #F0AD6D }
.pygments-gallery .highlight-inkpot .mh { color: #F0AD6D }
.pygments-gallery .highlight-inkpot .mi { color: #F0AD6D }
.pygments-gallery .highlight-inkpot .mo { color: #F0AD6D }
.pygments-gallery .highlight-inkpot .sa { color: #FFCD8B; background-color: #404040 }
.pygments-gallery .highlight-inkpot .sb { color: #FFCD8B; background-color: #404040 }
.pygments-gallery .highlight-inkpot .sc { color: #FFCD8B; background-color: #404040 }
.pygments-gallery .highlight-inkpot .dl { color: #FFCD8B; background-color: #404040 }
.pygments-gallery .highlight-inkpot .sd { color: #808BED; background-color: #404040 }
.pygments-gallery .highlight-inkpot .s2 { color: #FFCD8B; background-color: #404040 }
.pygments-gallery .highlight-inkpot .se { color: #FFCD8B; background-color: #404040 }
.pygments-gallery .highlight-inkpot .sh { color: #FFCD8B; background-color: #404040 }
.pygments-gallery .highlight-inkpot .si { color: #FFCD8B; background-color: #404040 }
.pygments-gallery .highlight-inkpot .sx { color: #FFCD8B; background-color: #404040 }
.pygments-gallery .highlight-inkpot .sr { color: #FFCD8B; background-color: #404040 }
.pygments-gallery .highlight-inkpot .s1 { color: #FFCD8B; background-color: #404040 }
.pygments-gallery .highlight-inkpot .ss { color: #FFCD8B; background-color: #404040 }
.pygments-gallery .highlight-inkpot .bp { color: #FF0 }
.pygments-gallery .highlight-inkpot .fm { color: #C080D0 }
.pygments-gallery .highlight-inkpot .vc { color: #CFBFAD }
.pygments-gallery .highlight-inkpot .vg { color: #CFBFAD }
.pygments-gallery .highlight-inkpot .vi { color: #CFBFAD }
.pygments-gallery .highlight-inkpot .vm { color: #CFBFAD }
.pygments-gallery .highlight-inkpot .il { color: #F0AD6D }
.pygments-gallery .highlight-lightbulb .hll { background-color: #6e7681 }
.pygments-gallery .highlight-lightbulb { background: #1d2331; color: #D4D2C8 }
.pygments-gallery .highlight-lightbulb .c { color: #7E8AA1 }
.pygments-gallery .highlight-lightbulb .err { color: #F88F7F }
.pygments-gallery .highlight-lightbulb .esc { color: #D4D2C8 }
.pygments-gallery .highlight-lightbulb .g { color: #D4D2C8 }
.pygments-gallery .highlight-lightbulb .k { color: #FFAD66 }
.pygments-gallery .highlight-lightbulb .l { color: #D5FF80 }
.pygments-gallery .highlight-lightbulb .n { color: #D4D2C8 }
.pygments-gallery .highlight-lightbulb .o { color: #FFAD66 }
.pygments-gallery .highlight-lightbulb .x { color: #D4D2C8 }
.pygments-gallery .highlight-lightbulb .p { color: #D4D2C8 }
.pygments-gallery .highlight-lightbulb .ch { color: #F88F7F; font-style: italic }
.pygments-gallery .highlight-lightbulb .cm { color: #7E8AA1 }
.pygments-gallery .highlight-lightbulb .cp { color: #FFAD66; font-weight: bold }
.pygments-gallery .highlight-lightbulb .cpf { color: #7E8AA1 }
.pygments-gallery .highlight-lightbulb .c1 { color: #7E8AA1 }
.pygments-gallery .highlight-lightbulb .cs { color: #7E8AA1; font-style: italic }
.pygments-gallery .highlight-lightbulb .gd { color: #F88F7F; background-color: #3D1E20 }
.pygments-gallery .highlight-lightbulb .ge { color: #D4D2C8; font-style: italic }
.pygments-gallery .highlight-lightbulb .ges { color: #D4D2C8 }
.pygments-gallery .highlight-lightbulb .gr { color: #F88F7F }
.pygments-gallery .highlight-lightbulb .gh { color: #D4D2C8 }
.pygments-gallery .highlight-lightbulb .gi { color: #6AD4AF; background-color: #19362C }
.pygments-gallery .highlight-lightbulb .go { color: #7E8AA1 }
.pygments-gallery .highlight-lightbulb .gp { color: #D4D2C8 }
.pygments-gallery .highlight-lightbulb .gs { color: #D4D2C8; font-weight: bold }
.pygments-gallery .highlight-lightbulb .gu { color: #D4D2C8 }
.pygments-gallery .highlight-lightbulb .gt { color: #F88F7F }
.pygments-gallery .highlight-lightbulb .kc { color: #FFAD66 }
.pygments-gallery .highlight-lightbulb .kd { color: #FFAD66 }
.pygments-gallery .highlight-lightbulb .kn { color: #FFAD66 }
.pygments-gallery .highlight-lightbulb .kp { color: #FFAD66 }
.pygments-gallery .highlight-lightbulb .kr { color: #FFAD66 }
.pygments-gallery .highlight-lightbulb .kt { color: #73D0FF }
.pygments-gallery .highlight-lightbulb .ld { color: #D5FF80 }
.pygments-gallery .highlight-lightbulb .m { color: #DFBFFF }
.pygments-gallery .highlight-lightbulb .s { color: #D5FF80 }
.pygments-gallery .highlight-lightbulb .na { color: #FFD173 }
.pygments-gallery .highlight-lightbulb .nb { color: #FFD173 }
.pygments-gallery .highlight-lightbulb .nc { color: #73D0FF }
.pygments-gallery .highlight-lightbulb .no { color: #FFD173 }
.pygments-gallery .highlight-lightbulb .nd { color: #7E8AA1; font-weight: bold; font-style: italic }
.pygments-gallery .highlight-lightbulb .ni { color: #95E6CB }
.pygments-gallery .highlight-lightbulb .ne { color: #73D0FF }
.pygments-gallery .highlight-lightbulb .nf { color: #FFD173 }
.pygments-gallery .highlight-lightbulb .nl { color: #D4D2C8 }
.pygments-gallery .highlight-lightbulb .nn { color: #D4D2C8 }
.pygments-gallery .highlight-lightbulb .nx { color: #D4D2C8 }
.pygments-gallery .highlight-lightbulb .py { color: #FFD173 }
.pygments-gallery .highlight-lightbulb .nt { color: #5CCFE6 }
.pygments-gallery .highlight-lightbulb .nv { color: #D4D2C8 }
.pygments-gallery .highlight-lightbulb .ow { color: #FFAD66 }
.pygments-gallery .highlight-lightbulb .pm { color: #D4D2C8 }
.pygments-gallery .highlight-lightbulb .w { color: #D4D2C8 }
.pygments-gallery .highlight-lightbulb .mb { color: #DFBFFF }
.pygments-gallery .highlight-lightbulb .mf { color: #DFBFFF }
.pygments-gallery .highlight-lightbulb .mh { color: #DFBFFF }
.pygments-gallery .highlight-lightbulb .mi { color: #DFBFFF }
.pygments-gallery .highlight-lightbulb .mo { color: #DFBFFF }
.pygments-gallery .highlight-lightbulb .sa { color: #F29E74 }
.pygments-gallery .highlight-lightbulb .sb { color: #D5FF80 }
.pygments-gallery .highlight-lightbulb .sc { color: #D5FF80 }
.pygments-gallery .highlight-lightbulb .dl { color: #D5FF80 }
.pygments-gallery .highlight-lightbulb .sd { color: #7E8AA1 }
.pygments-gallery .highlight-lightbulb .s2 { color: #D5FF80 }
.pygments-gallery .highlight-lightbulb .se { color: #95E6CB }
.pygments-gallery .highlight-lightbulb .sh { color: #D5FF80 }
.pygments-gallery .highlight-lightbulb .si { color: #95E6CB }
.pygments-gallery .highlight-lightbulb .sx { color: #95E6CB }
.pygments-gallery .highlight-lightbulb .sr { color: #95E6CB }
.pygments-gallery .highlight-lightbulb .s1 { color: #D5FF80 }
.pygments-gallery .highlight-lightbulb .ss { color: #DFBFFF }
.pygments-gallery .highlight-lightbulb .bp { color: #5CCFE6 }
.pygments-gallery .highlight-lightbulb .fm { color: #FFD173 }
.pygments-gallery .highlight-lightbulb .vc { color: #D4D2C8 }
.pygments-gallery .highlight-lightbulb .vg { color: #D4D2C8 }
.pygments-gallery .highlight-lightbulb .vi { color: #D4D2C8 }
.pygments-gallery .highlight-lightbulb .vm { color: #D4D2C8 }
.pygments-gallery .highlight-lightbulb .il { color: #DFBFFF }
.pygments-gallery .highlight-lilypond .hll { background-color: #ffffcc }
.pygments-gallery .highlight-lilypond { background: #ffffff; }
.pygments-gallery .highlight-lilypond .-ChordModifier { color: #976806 }
.pygments-gallery .highlight-lilypond .c { color: #A3AAB2; font-style: italic }
.pygments-gallery .highlight-lilypond .k { font-weight: bold }
.pygments-gallery .highlight-lilypond .ch { color: #A3AAB2; font-style: italic }
.pygments-gallery .highlight-lilypond .cm { color: #A3AAB2; font-style: italic }
.pygments-gallery .highlight-lilypond .cp { color: #A3AAB2; font-style: italic }
.pygments-gallery .highlight-lilypond .cpf { color: #A3AAB2; font-style: italic }
.pygments-gallery .highlight-lilypond .c1 { color: #A3AAB2; font-style: italic }
.pygments-gallery .highlight-lilypond .cs { color: #A3AAB2; font-style: italic }
.pygments-gallery .highlight-lilypond .kc { font-weight: bold }
.pygments-gallery .highlight-lilypond .kd { font-weight: bold }
.pygments-gallery .highlight-lilypond .kn { font-weight: bold }
.pygments-gallery .highlight-lilypond .kp { font-weight: bold }
.pygments-gallery .highlight-lilypond .kr { font-weight: bold }
.pygments-gallery .highlight-lilypond .kt { font-weight: bold }
.pygments-gallery .highlight-lilypond .m { color: #976806 }
.pygments-gallery .highlight-lilypond .s { color: #AB0909 }
.pygments-gallery .highlight-lilypond .n-BackslashReference { color: #08547A }
.pygments-gallery .highlight-lilypond .n-Lvalue { color: #08547A }
.pygments-gallery .highlight-lilypond .mb { color: #976806 }
.pygments-gallery .highlight-lilypond .mf { color: #976806 }
.pygments-gallery .highlight-lilypond .mh { color: #976806 }
.pygments-gallery .highlight-lilypond .mi { color: #976806 }
.pygments-gallery .highlight-lilypond .mo { color: #976806 }
.pygments-gallery .highlight-lilypond .sa { color: #AB0909 }
.pygments-gallery .highlight-lilypond .sb { color: #AB0909 }
.pygments-gallery .highlight-lilypond .sc { color: #AB0909 }
.pygments-gallery .highlight-lilypond .dl { color: #AB0909 }
.pygments-gallery .highlight-lilypond .sd { color: #AB0909 }
.pygments-gallery .highlight-lilypond .s2 { color: #AB0909 }
.pygments-gallery .highlight-lilypond .se { color: #C46C6C }
.pygments-gallery .highlight-lilypond .sh { color: #AB0909 }
.pygments-gallery .highlight-lilypond .si { color: #AB0909 }
.pygments-gallery .highlight-lilypond .sx { color: #AB0909 }
.pygments-gallery .highlight-lilypond .sr { color: #AB0909 }
.pygments-gallery .highlight-lilypond .s1 { color: #AB0909 }
.pygments-gallery .highlight-lilypond .nb-Articulation { color: #68175A }
.pygments-gallery .highlight-lilypond .nb-Clef { color: #08547A; font-weight: bold }
.pygments-gallery .highlight-lilypond .nb-Context { color: #038B8B; font-weight: bold }
.pygments-gallery .highlight-lilypond .nb-ContextProperty { color: #038B8B }
.pygments-gallery .highlight-lilypond .nb-Dynamic { color: #68175A }
.pygments-gallery .highlight-lilypond .nb-Grob { color: #0C7441; font-weight: bold }
.pygments-gallery .highlight-lilypond .nb-GrobProperty { color: #0C7441 }
.pygments-gallery .highlight-lilypond .nb-HeaderVariable { color: #6C5A05; font-weight: bold }
.pygments-gallery .highlight-lilypond .nb-MarkupCommand { color: #831E71; font-weight: bold }
.pygments-gallery .highlight-lilypond .nb-MusicCommand { color: #08547A; font-weight: bold }
.pygments-gallery .highlight-lilypond .nb-MusicFunction { color: #08547A; font-weight: bold }
.pygments-gallery .highlight-lilypond .nb-PaperVariable { color: #6C5A05; font-weight: bold }
.pygments-gallery .highlight-lilypond .nb-RepeatType { color: #08547A }
.pygments-gallery .highlight-lilypond .nb-Scale { color: #08547A; font-weight: bold }
.pygments-gallery .highlight-lilypond .nb-SchemeBuiltin { font-weight: bold }
.pygments-gallery .highlight-lilypond .nb-SchemeFunction { color: #A83401; font-weight: bold }
.pygments-gallery .highlight-lilypond .nb-Translator { color: #6200A4; font-weight: bold }
.pygments-gallery .highlight-lilypond .il { color: #976806 }
.pygments-gallery .highlight-lovelace .hll { background-color: #ffffcc }
.pygments-gallery .highlight-lovelace { background: #ffffff; }
.pygments-gallery .highlight-lovelace .c { color: #888; font-style: italic }
.pygments-gallery .highlight-lovelace .err { background-color: #A848A8 }
.pygments-gallery .highlight-lovelace .k { color: #2838B0 }
.pygments-gallery .highlight-lovelace .o { color: #666 }
.pygments-gallery .highlight-lovelace .p { color: #888 }
.pygments-gallery .highlight-lovelace .ch { color: #287088; font-style: italic }
.pygments-gallery .highlight-lovelace .cm { color: #888; font-style: italic }
.pygments-gallery .highlight-lovelace .cp { color: #289870 }
.pygments-gallery .highlight-lovelace .cpf { color: #888; font-style: italic }
.pygments-gallery .highlight-lovelace .c1 { color: #888; font-style: italic }
.pygments-gallery .highlight-lovelace .cs { color: #888; font-style: italic }
.pygments-gallery .highlight-lovelace .gd { color: #C02828 }
.pygments-gallery .highlight-lovelace .ge { font-style: italic }
.pygments-gallery .highlight-lovelace .ges { font-weight: bold; font-style: italic }
.pygments-gallery .highlight-lovelace .gr { color: #C02828 }
.pygments-gallery .highlight-lovelace .gh { color: #666 }
.pygments-gallery .highlight-lovelace .gi { color: #388038 }
.pygments-gallery .highlight-lovelace .go { color: #666 }
.pygments-gallery .highlight-lovelace .gp { color: #444 }
.pygments-gallery .highlight-lovelace .gs { font-weight: bold }
.pygments-gallery .highlight-lovelace .gu { color: #444 }
.pygments-gallery .highlight-lovelace .gt { color: #2838B0 }
.pygments-gallery .highlight-lovelace .kc { color: #444; font-style: italic }
.pygments-gallery .highlight-lovelace .kd { color: #2838B0; font-style: italic }
.pygments-gallery .highlight-lovelace .kn { color: #2838B0 }
.pygments-gallery .highlight-lovelace .kp { color: #2838B0 }
.pygments-gallery .highlight-lovelace .kr { color: #2838B0 }
.pygments-gallery .highlight-lovelace .kt { color: #2838B0; font-style: italic }
.pygments-gallery .highlight-lovelace .m { color: #444 }
.pygments-gallery .highlight-lovelace .s { color: #B83838 }
.pygments-gallery .highlight-lovelace .na { color: #388038 }
.pygments-gallery .highlight-lovelace .nb { color: #388038 }
.pygments-gallery .highlight-lovelace .nc { color: #287088 }
.pygments-gallery .highlight-lovelace .no { color: #B85820 }
.pygments-gallery .highlight-lovelace .nd { color: #287088 }
.pygments-gallery .highlight-lovelace .ni { color: #709030 }
.pygments-gallery .highlight-lovelace .ne { color: #908828 }
.pygments-gallery .highlight-lovelace .nf { color: #785840 }
.pygments-gallery .highlight-lovelace .nl { color: #289870 }
.pygments-gallery .highlight-lovelace .nn { color: #289870 }
.pygments-gallery .highlight-lovelace .nt { color: #2838B0 }
.pygments-gallery .highlight-lovelace .nv { color: #B04040 }
.pygments-gallery .highlight-lovelace .ow { color: #A848A8 }
.pygments-gallery .highlight-lovelace .pm { color: #888 }
.pygments-gallery .highlight-lovelace .w { color: #A89028 }
.pygments-gallery .highlight-lovelace .mb { color: #444 }
.pygments-gallery .highlight-lovelace .mf { color: #444 }
.pygments-gallery .highlight-lovelace .mh { color: #444 }
.pygments-gallery .highlight-lovelace .mi { color: #444 }
.pygments-gallery .highlight-lovelace .mo { color: #444 }
.pygments-gallery .highlight-lovelace .sa { color: #444 }
.pygments-gallery .highlight-lovelace .sb { color: #B83838 }
.pygments-gallery .highlight-lovelace .sc { color: #A848A8 }
.pygments-gallery .highlight-lovelace .dl { color: #B85820 }
.pygments-gallery .highlight-lovelace .sd { color: #B85820; font-style: italic }
.pygments-gallery .highlight-lovelace .s2 { color: #B83838 }
.pygments-gallery .highlight-lovelace .se { color: #709030 }
.pygments-gallery .highlight-lovelace .sh { color: #B83838 }
.pygments-gallery .highlight-lovelace .si { color: #B83838; text-decoration: underline }
.pygments-gallery .highlight-lovelace .sx { color: #A848A8 }
.pygments-gallery .highlight-lovelace .sr { color: #A848A8 }
.pygments-gallery .highlight-lovelace .s1 { color: #B83838 }
.pygments-gallery .highlight-lovelace .ss { color: #B83838 }
.pygments-gallery .highlight-lovelace .bp { color: #388038; font-style: italic }
.pygments-gallery .highlight-lovelace .fm { color: #B85820 }
.pygments-gallery .highlight-lovelace .vc { color: #B04040 }
.pygments-gallery .highlight-lovelace .vg { color: #908828 }
.pygments-gallery .highlight-lovelace .vi { color: #B04040 }
.pygments-gallery .highlight-lovelace .vm { color: #B85820 }
.pygments-gallery .highlight-lovelace .il { color: #444 }
.pygments-gallery .highlight-manni .hll { background-color: #ffffcc }
.pygments-gallery .highlight-manni { background: #f0f3f3; }
.pygments-gallery .highlight-manni .c { color: #09F; font-style: italic }
.pygments-gallery .highlight-manni .err { color: #A00; background-color: #FAA }
.pygments-gallery .highlight-manni .k { color: #069; font-weight: bold }
.pygments-gallery .highlight-manni .o { color: #555 }
.pygments-gallery .highlight-manni .ch { color: #09F; font-style: italic }
.pygments-gallery .highlight-manni .cm { color: #09F; font-style: italic }
.pygments-gallery .highlight-manni .cp { color: #099 }
.pygments-gallery .highlight-manni .cpf { color: #09F; font-style: italic }
.pygments-gallery .highlight-manni .c1 { color: #09F; font-style: italic }
.pygments-gallery .highlight-manni .cs { color: #09F; font-weight: bold; font-style: italic }
.pygments-gallery .highlight-manni .gd { background-color: #FCC; border: 1px solid #C00 }
.pygments-gallery .highlight-manni .ge { font-style: italic }
.pygments-gallery .highlight-manni .ges { font-weight: bold; font-style: italic }
.pygments-gallery .highlight-manni .gr { color: #F00 }
.pygments-gallery .highlight-manni .gh { color: #030; font-weight: bold }
.pygments-gallery .highlight-manni .gi { background-color: #CFC; border: 1px solid #0C0 }
.pygments-gallery .highlight-manni .go { color: #AAA }
.pygments-gallery .highlight-manni .gp { color: #009; font-weight: bold }
.pygments-gallery .highlight-manni .gs { font-weight: bold }
.pygments-gallery .highlight-manni .gu { color: #030; font-weight: bold }
.pygments-gallery .highlight-manni .gt { color: #9C6 }
.pygments-gallery .highlight-manni .kc { color: #069; font-weight: bold }
.pygments-gallery .highlight-manni .kd { color: #069; font-weight: bold }
.pygments-gallery .highlight-manni .kn { color: #069; font-weight: bold }
.pygments-gallery .highlight-manni .kp { color: #069 }
.pygments-gallery .highlight-manni .kr { color: #069; font-weight: bold }
.pygments-gallery .highlight-manni .kt { color: #078; font-weight: bold }
.pygments-gallery .highlight-manni .m { color: #F60 }
.pygments-gallery .highlight-manni .s { color: #C30 }
.pygments-gallery .highlight-manni .na { color: #309 }
.pygments-gallery .highlight-manni .nb { color: #366 }
.pygments-gallery .highlight-manni .nc { color: #0A8; font-weight: bold }
.pygments-gallery .highlight-manni .no { color: #360 }
.pygments-gallery .highlight-manni .nd { color: #99F }
.pygments-gallery .highlight-manni .ni { color: #999; font-weight: bold }
.pygments-gallery .highlight-manni .ne { color: #C00; font-weight: bold }
.pygments-gallery .highlight-manni .nf { color: #C0F }
.pygments-gallery .highlight-manni .nl { color: #99F }
.pygments-gallery .highlight-manni .nn { color: #0CF; font-weight: bold }
.pygments-gallery .highlight-manni .nt { color: #309; font-weight: bold }
.pygments-gallery .highlight-manni .nv { color: #033 }
.pygments-gallery .highlight-manni .ow { color: #000; font-weight: bold }
.pygments-gallery .highlight-manni .w { color: #BBB }
.pygments-gallery .highlight-manni .mb { color: #F60 }
.pygments-gallery .highlight-manni .mf { color: #F60 }
.pygments-gallery .highlight-manni .mh { color: #F60 }
.pygments-gallery .highlight-manni .mi { color: #F60 }
.pygments-gallery .highlight-manni .mo { color: #F60 }
.pygments-gallery .highlight-manni .sa { color: #C30 }
.pygments-gallery .highlight-manni .sb { color: #C30 }
.pygments-gallery .highlight-manni .sc { color: #C30 }
.pygments-gallery .highlight-manni .dl { color: #C30 }
.pygments-gallery .highlight-manni .sd { color: #C30; font-style: italic }
.pygments-gallery .highlight-manni .s2 { color: #C30 }
.pygments-gallery .highlight-manni .se { color: #C30; font-weight: bold }
.pygments-gallery .highlight-manni .sh { color: #C30 }
.pygments-gallery .highlight-manni .si { color: #A00 }
.pygments-gallery .highlight-manni .sx { color: #C30 }
.pygments-gallery .highlight-manni .sr { color: #3AA }
.pygments-gallery .highlight-manni .s1 { color: #C30 }
.pygments-gallery .highlight-manni .ss { color: #FC3 }
.pygments-gallery .highlight-manni .bp { color: #366 }
.pygments-gallery .highlight-manni .fm { color: #C0F }
.pygments-gallery .highlight-manni .vc { color: #033 }
.pygments-gallery .highlight-manni .vg { color: #033 }
.pygments-gallery .highlight-manni .vi { color: #033 }
.pygments-gallery .highlight-manni .vm { color: #033 }
.pygments-gallery .highlight-manni .il { color: #F60 }
.pygments-gallery .highlight-material .hll { background-color: #2C3B41 }
.pygments-gallery .highlight-material { background: #263238; color: #EFF }
.pygments-gallery .highlight-material .c { color: #546E7A; font-style: italic }
.pygments-gallery .highlight-material .err { color: #FF5370 }
.pygments-gallery .highlight-material .esc { color: #89DDFF }
.pygments-gallery .highlight-material .g { color: #EFF }
.pygments-gallery .highlight-material .k { color: #BB80B3 }
.pygments-gallery .highlight-material .l { color: #C3E88D }
.pygments-gallery .highlight-material .n { color: #EFF }
.pygments-gallery .highlight-material .o { color: #89DDFF }
.pygments-gallery .highlight-material .p { color: #89DDFF }
.pygments-gallery .highlight-material .ch { color: #546E7A; font-style: italic }
.pygments-gallery .highlight-material .cm { color: #546E7A; font-style: italic }
.pygments-gallery .highlight-material .cp { color: #546E7A; font-style: italic }
.pygments-gallery .highlight-material .cpf { color: #546E7A; font-style: italic }
.pygments-gallery .highlight-material .c1 { color: #546E7A; font-style: italic }
.pygments-gallery .highlight-material .cs { color: #546E7A; font-style: italic }
.pygments-gallery .highlight-material .gd { color: #FF5370 }
.pygments-gallery .highlight-material .ge { color: #89DDFF }
.pygments-gallery .highlight-material .ges { color: #FFCB6B }
.pygments-gallery .highlight-material .gr { color: #FF5370 }
.pygments-gallery .highlight-material .gh { color: #C3E88D }
.pygments-gallery .highlight-material .gi { color: #C3E88D }
.pygments-gallery .highlight-material .go { color: #546E7A }
.pygments-gallery .highlight-material .gp { color: #FFCB6B }
.pygments-gallery .highlight-material .gs { color: #FF5370 }
.pygments-gallery .highlight-material .gu { color: #89DDFF }
.pygments-gallery .highlight-material .gt { color: #FF5370 }
.pygments-gallery .highlight-material .kc { color: #89DDFF }
.pygments-gallery .highlight-material .kd { color: #BB80B3 }
.pygments-gallery .highlight-material .kn { color: #89DDFF; font-style: italic }
.pygments-gallery .highlight-material .kp { color: #89DDFF }
.pygments-gallery .highlight-material .kr { color: #BB80B3 }
.pygments-gallery .highlight-material .kt { color: #BB80B3 }
.pygments-gallery .highlight-material .ld { color: #C3E88D }
.pygments-gallery .highlight-material .m { color: #F78C6C }
.pygments-gallery .highlight-material .s { color: #C3E88D }
.pygments-gallery .highlight-material .na { color: #BB80B3 }
.pygments-gallery .highlight-material .nb { color: #82AAFF }
.pygments-gallery .highlight-material .nc { color: #FFCB6B }
.pygments-gallery .highlight-material .no { color: #EFF }
.pygments-gallery .highlight-material .nd { color: #82AAFF }
.pygments-gallery .highlight-material .ni { color: #89DDFF }
.pygments-gallery .highlight-material .ne { color: #FFCB6B }
.pygments-gallery .highlight-material .nf { color: #82AAFF }
.pygments-gallery .highlight-material .nl { color: #82AAFF }
.pygments-gallery .highlight-material .nn { color: #FFCB6B }
.pygments-gallery .highlight-material .nx { color: #EFF }
.pygments-gallery .highlight-material .py { color: #FFCB6B }
.pygments-gallery .highlight-material .nt { color: #FF5370 }
.pygments-gallery .highlight-material .nv { color: #89DDFF }
.pygments-gallery .highlight-material .ow { color: #89DDFF; font-style: italic }
.pygments-gallery .highlight-material .pm { color: #89DDFF }
.pygments-gallery .highlight-material .w { color: #EFF }
.pygments-gallery .highlight-material .mb { color: #F78C6C }
.pygments-gallery .highlight-material .mf { color: #F78C6C }
.pygments-gallery .highlight-material .mh { color: #F78C6C }
.pygments-gallery .highlight-material .mi { color: #F78C6C }
.pygments-gallery .highlight-material .mo { color: #F78C6C }
.pygments-gallery .highlight-material .sa { color: #BB80B3 }
.pygments-gallery .highlight-material .sb { color: #C3E88D }
.pygments-gallery .highlight-material .sc { color: #C3E88D }
.pygments-gallery .highlight-material .dl { color: #EFF }
.pygments-gallery .highlight-material .sd { color: #546E7A; font-style: italic }
.pygments-gallery .highlight-material .s2 { color: #C3E88D }
.pygments-gallery .highlight-material .se { color: #EFF }
.pygments-gallery .highlight-material .sh { color: #C3E88D }
.pygments-gallery .highlight-material .si { color: #89DDFF }
.pygments-gallery .highlight-material .sx { color: #C3E88D }
.pygments-gallery .highlight-material .sr { color: #89DDFF }
.pygments-gallery .highlight-material .s1 { color: #C3E88D }
.pygments-gallery .highlight-material .ss { color: #89DDFF }
.pygments-gallery .highlight-material .bp { color: #89DDFF }
.pygments-gallery .highlight-material .fm { color: #82AAFF }
.pygments-gallery .highlight-material .vc { color: #89DDFF }
.pygments-gallery .highlight-material .vg { color: #89DDFF }
.pygments-gallery .highlight-material .vi { color: #89DDFF }
.pygments-gallery .highlight-material .vm { color: #82AAFF }
.pygments-gallery .highlight-material .il { color: #F78C6C }
.pygments-gallery .highlight-monokai .hll { background-color: #49483e }
.pygments-gallery .highlight-monokai { background: #272822; color: #F8F8F2 }
.pygments-gallery .highlight-monokai .c { color: #959077 }
.pygments-gallery .highlight-monokai .err { color: #ED007E; background-color: #1E0010 }
.pygments-gallery .highlight-monokai .esc { color: #F8F8F2 }
.pygments-gallery .highlight-monokai .g { color: #F8F8F2 }
.pygments-gallery .highlight-monokai .k { color: #66D9EF }
.pygments-gallery .highlight-monokai .l { color: #AE81FF }
.pygments-gallery .highlight-monokai .n { color: #F8F8F2 }
.pygments-gallery .highlight-monokai .o { color: #FF4689 }
.pygments-gallery .highlight-monokai .x { color: #F8F8F2 }
.pygments-gallery .highlight-monokai .p { color: #F8F8F2 }
.pygments-gallery .highlight-monokai .ch { color: #959077 }
.pygments-gallery .highlight-monokai .cm { color: #959077 }
.pygments-gallery .highlight-monokai .cp { color: #959077 }
.pygments-gallery .highlight-monokai .cpf { color: #959077 }
.pygments-gallery .highlight-monokai .c1 { color: #959077 }
.pygments-gallery .highlight-monokai .cs { color: #959077 }
.pygments-gallery .highlight-monokai .gd { color: #FF4689 }
.pygments-gallery .highlight-monokai .ge { color: #F8F8F2; font-style: italic }
.pygments-gallery .highlight-monokai .ges { color: #F8F8F2; font-weight: bold; font-style: italic }
.pygments-gallery .highlight-monokai .gr { color: #FF4689 }
.pygments-gallery .highlight-monokai .gh { color: #F8F8F2 }
.pygments-gallery .highlight-monokai .gi { color: #A6E22E }
.pygments-gallery .highlight-monokai .go { color: #66D9EF }
.pygments-gallery .highlight-monokai .gp { color: #FF4689; font-weight: bold }
.pygments-gallery .highlight-monokai .gs { color: #F8F8F2; font-weight: bold }
.pygments-gallery .highlight-monokai .gu { color: #959077 }
.pygments-gallery .highlight-monokai .gt { color: #66D9EF }
.pygments-gallery .highlight-monokai .kc { color: #66D9EF }
.pygments-gallery .highlight-monokai .kd { color: #66D9EF }
.pygments-gallery .highlight-monokai .kn { color: #FF4689 }
.pygments-gallery .highlight-monokai .kp { color: #66D9EF }
.pygments-gallery .highlight-monokai .kr { color: #66D9EF }
.pygments-gallery .highlight-monokai .kt { color: #66D9EF }
.pygments-gallery .highlight-monokai .ld { color: #E6DB74 }
.pygments-gallery .highlight-monokai .m { color: #AE81FF }
.pygments-gallery .highlight-monokai .s { color: #E6DB74 }
.pygments-gallery .highlight-monokai .na { color: #A6E22E }
.pygments-gallery .highlight-monokai .nb { color: #A6E22E }
.pygments-gallery .highlight-monokai .nc { color: #A6E22E }
.pygments-gallery .highlight-monokai .no { color: #66D9EF }
.pygments-gallery .highlight-monokai .nd { color: #A6E22E }
.pygments-gallery .highlight-monokai .ni { color: #F8F8F2 }
.pygments-gallery .highlight-monokai .ne { color: #A6E22E }
.pygments-gallery .highlight-monokai .nf { color: #A6E22E }
.pygments-gallery .highlight-monokai .nl { color: #F8F8F2 }
.pygments-gallery .highlight-monokai .nn { color: #F8F8F2 }
.pygments-gallery .highlight-monokai .nx { color: #A6E22E }
.pygments-gallery .highlight-monokai .py { color: #F8F8F2 }
.pygments-gallery .highlight-monokai .nt { color: #FF4689 }
.pygments-gallery .highlight-monokai .nv { color: #F8F8F2 }
.pygments-gallery .highlight-monokai .ow { color: #FF4689 }
.pygments-gallery .highlight-monokai .pm { color: #F8F8F2 }
.pygments-gallery .highlight-monokai .w { color: #F8F8F2 }
.pygments-gallery .highlight-monokai .mb { color: #AE81FF }
.pygments-gallery .highlight-monokai .mf { color: #AE81FF }
.pygments-gallery .highlight-monokai .mh { color: #AE81FF }
.pygments-gallery .highlight-monokai .mi { color: #AE81FF }
.pygments-gallery .highlight-monokai .mo { color: #AE81FF }
.pygments-gallery .highlight-monokai .sa { color: #E6DB74 }
.pygments-gallery .highlight-monokai .sb { color: #E6DB74 }
.pygments-gallery .highlight-monokai .sc { color: #E6DB74 }
.pygments-gallery .highlight-monokai .dl { color: #E6DB74 }
.pygments-gallery .highlight-monokai .sd { color: #E6DB74 }
.pygments-gallery .highlight-monokai .s2 { color: #E6DB74 }
.pygments-gallery .highlight-monokai .se { color: #AE81FF }
.pygments-gallery .highlight-monokai .sh { color: #E6DB74 }
.pygments-gallery .highlight-monokai .si { color: #E6DB74 }
.pygments-gallery .highlight-monokai .sx { color: #E6DB74 }
.pygments-gallery .highlight-monokai .sr { color: #E6DB74 }
.pygments-gallery .highlight-monokai .s1 { color: #E6DB74 }
.pygments-gallery .highlight-monokai .ss { color: #E6DB74 }
.pygments-gallery .highlight-monokai .bp { color: #A6E22E }
.pygments-gallery .highlight-monokai .fm { color: #A6E22E }
.pygments-gallery .highlight-monokai .vc { color: #F8F8F2 }
.pygments-gallery .highlight-monokai .vg { color: #F8F8F2 }
.pygments-gallery .highlight-monokai .vi { color: #F8F8F2 }
.pygments-gallery .highlight-monokai .vm { color: #F8F8F2 }
.pygments-gallery .highlight-monokai .il { color: #AE81FF }
.pygments-gallery .highlight-murphy .hll { background-color: #ffffcc }
.pygments-gallery .highlight-murphy { background: #ffffff; }
.pygments-gallery .highlight-murphy .c { color: #666; font-style: italic }
.pygments-gallery .highlight-murphy .err { color: #F00; background-color: #FAA }
.pygments-gallery .highlight-murphy .k { color: #289; font-weight: bold }
.pygments-gallery .highlight-murphy .o { color: #333 }
.pygments-gallery .highlight-murphy .ch { color: #666; font-style: italic }
.pygments-gallery .highlight-murphy .cm { color: #666; font-style: italic }
.pygments-gallery .highlight-murphy .cp { color: #579 }
.pygments-gallery .highlight-murphy .cpf { color: #666; font-style: italic }
.pygments-gallery .highlight-murphy .c1 { color: #666; font-style: italic }
.pygments-gallery .highlight-murphy .cs { color: #C00; font-weight: bold; font-style: italic }
.pygments-gallery .highlight-murphy .gd { color: #A00000 }
.pygments-gallery .highlight-murphy .ge { font-style: italic }
.pygments-gallery .highlight-murphy .ges { font-weight: bold; font-style: italic }
.pygments-gallery .highlight-murphy .gr { color: #F00 }
.pygments-gallery .highlight-murphy .gh { color: #000080; font-weight: bold }
.pygments-gallery .highlight-murphy .gi { color: #00A000 }
.pygments-gallery .highlight-murphy .go { color: #888 }
.pygments-gallery .highlight-murphy .gp { color: #C65D09; font-weight: bold }
.pygments-gallery .highlight-murphy .gs { font-weight: bold }
.pygments-gallery .highlight-murphy .gu { color: #800080; font-weight: bold }
.pygments-gallery .highlight-murphy .gt { color: #04D }
.pygments-gallery .highlight-murphy .kc { color: #289; font-weight: bold }
.pygments-gallery .highlight-murphy .kd { color: #289; font-weight: bold }
.pygments-gallery .highlight-murphy .kn { color: #289; font-weight: bold }
.pygments-gallery .highlight-murphy .kp { color: #08F; font-weight: bold }
.pygments-gallery .highlight-murphy .kr { color: #289; font-weight: bold }
.pygments-gallery .highlight-murphy .kt { color: #66F; font-weight: bold }
.pygments-gallery .highlight-murphy .m { color: #60E; font-weight: bold }
.pygments-gallery .highlight-murphy .s { background-color: #E0E0FF }
.pygments-gallery .highlight-murphy .na { color: #007 }
.pygments-gallery .highlight-murphy .nb { color: #072 }
.pygments-gallery .highlight-murphy .nc { color: #E9E; font-weight: bold }
.pygments-gallery .highlight-murphy .no { color: #5ED; font-weight: bold }
.pygments-gallery .highlight-murphy .nd { color: #555; font-weight: bold }
.pygments-gallery .highlight-murphy .ni { color: #800 }
.pygments-gallery .highlight-murphy .ne { color: #F00; font-weight: bold }
.pygments-gallery .highlight-murphy .nf { color: #5ED; font-weight: bold }
.pygments-gallery .highlight-murphy .nl { color: #970; font-weight: bold }
.pygments-gallery .highlight-murphy .nn { color: #0E84B5; font-weight: bold }
.pygments-gallery .highlight-murphy .nt { color: #070 }
.pygments-gallery .highlight-murphy .nv { color: #036 }
.pygments-gallery .highlight-murphy .ow { color: #000; font-weight: bold }
.pygments-gallery .highlight-murphy .w { color: #BBB }
.pygments-gallery .highlight-murphy .mb { color: #60E; font-weight: bold }
.pygments-gallery .highlight-murphy .mf { color: #60E; font-weight: bold }
.pygments-gallery .highlight-murphy .mh { color: #058; font-weight: bold }
.pygments-gallery .highlight-murphy .mi { color: #66F; font-weight: bold }
.pygments-gallery .highlight-murphy .mo { color: #40E; font-weight: bold }
.pygments-gallery .highlight-murphy .sa { background-color: #E0E0FF }
.pygments-gallery .highlight-murphy .sb { background-color: #E0E0FF }
.pygments-gallery .highlight-murphy .sc { color: #88F }
.pygments-gallery .highlight-murphy .dl { background-color: #E0E0FF }
.pygments-gallery .highlight-murphy .sd { color: #D42 }
.pygments-gallery .highlight-murphy .s2 { background-color: #E0E0FF }
.pygments-gallery .highlight-murphy .se { color: #666; font-weight: bold; background-color: #E0E0FF }
.pygments-gallery .highlight-murphy .sh { background-color: #E0E0FF }
.pygments-gallery .highlight-murphy .si { background-color: #EEE }
.pygments-gallery .highlight-murphy .sx { color: #F88; background-color: #E0E0FF }
.pygments-gallery .highlight-murphy .sr { color: #000; background-color: #E0E0FF }
.pygments-gallery .highlight-murphy .s1 { background-color: #E0E0FF }
.pygments-gallery .highlight-murphy .ss { color: #FC8 }
.pygments-gallery .highlight-murphy .bp { color: #072 }
.pygments-gallery .highlight-murphy .fm { color: #5ED; font-weight: bold }
.pygments-gallery .highlight-murphy .vc { color: #CCF }
.pygments-gallery .highlight-murphy .vg { color: #F84 }
.pygments-gallery .highlight-murphy .vi { color: #AAF }
.pygments-gallery .highlight-murphy .vm { color: #036 }
.pygments-gallery .highlight-murphy .il { color: #66F; font-weight: bold }
.pygments-gallery .highlight-native .hll { background-color: #404040 }
.pygments-gallery .highlight-native { background: #202020; color: #D0D0D0 }
.pygments-gallery .highlight-native .c { color: #ABABAB; font-style: italic }
.pygments-gallery .highlight-native .err { color: #A61717; background-color: #E3D2D2 }
.pygments-gallery .highlight-native .esc { color: #D0D0D0 }
.pygments-gallery .highlight-native .g { color: #D0D0D0 }
.pygments-gallery .highlight-native .k { color: #6EBF26; font-weight: bold }
.pygments-gallery .highlight-native .l { color: #D0D0D0 }
.pygments-gallery .highlight-native .n { color: #D0D0D0 }
.pygments-gallery .highlight-native .o { color: #D0D0D0 }
.pygments-gallery .highlight-native .x { color: #D0D0D0 }
.pygments-gallery .highlight-native .p { color: #D0D0D0 }
.pygments-gallery .highlight-native .ch { color: #ABABAB; font-style: italic }
.pygments-gallery .highlight-native .cm { color: #ABABAB; font-style: italic }
.pygments-gallery .highlight-native .cp { color: #FF3A3A; font-weight: bold }
.pygments-gallery .highlight-native .cpf { color: #ABABAB; font-style: italic }
.pygments-gallery .highlight-native .c1 { color: #ABABAB; font-style: italic }
.pygments-gallery .highlight-native .cs { color: #E50808; font-weight: bold; background-color: #520000 }
.pygments-gallery .highlight-native .gd { color: #FF3A3A }
.pygments-gallery .highlight-native .ge { color: #D0D0D0; font-style: italic }
.pygments-gallery .highlight-native .ges { color: #D0D0D0; font-weight: bold; font-style: italic }
.pygments-gallery .highlight-native .gr { color: #FF3A3A }
.pygments-gallery .highlight-native .gh { color: #FFF; font-weight: bold }
.pygments-gallery .highlight-native .gi { color: #589819 }
.pygments-gallery .highlight-native .go { color: #CCC }
.pygments-gallery .highlight-native .gp { color: #AAA }
.pygments-gallery .highlight-native .gs { color: #D0D0D0; font-weight: bold }
.pygments-gallery .highlight-native .gu { color: #FFF; text-decoration: underline }
.pygments-gallery .highlight-native .gt { color: #FF3A3A }
.pygments-gallery .highlight-native .kc { color: #6EBF26; font-weight: bold }
.pygments-gallery .highlight-native .kd { color: #6EBF26; font-weight: bold }
.pygments-gallery .highlight-native .kn { color: #6EBF26; font-weight: bold }
.pygments-gallery .highlight-native .kp { color: #6EBF26 }
.pygments-gallery .highlight-native .kr { color: #6EBF26; font-weight: bold }
.pygments-gallery .highlight-native .kt { color: #6EBF26; font-weight: bold }
.pygments-gallery .highlight-native .ld { color: #D0D0D0 }
.pygments-gallery .highlight-native .m { color: #51B2FD }
.pygments-gallery .highlight-native .s { color: #ED9D13 }
.pygments-gallery .highlight-native .na { color: #BBB }
.pygments-gallery .highlight-native .nb { color: #2FBCCD }
.pygments-gallery .highlight-native .nc { color: #71ADFF; text-decoration: underline }
.pygments-gallery .highlight-native .no { color: #40FFFF }
.pygments-gallery .highlight-native .nd { color: #FFA500 }
.pygments-gallery .highlight-native .ni { color: #D0D0D0 }
.pygments-gallery .highlight-native .ne { color: #BBB }
.pygments-gallery .highlight-native .nf { color: #71ADFF }
.pygments-gallery .highlight-native .nl { color: #D0D0D0 }
.pygments-gallery .highlight-native .nn { color: #71ADFF; text-decoration: underline }
.pygments-gallery .highlight-native .nx { color: #D0D0D0 }
.pygments-gallery .highlight-native .py { color: #D0D0D0 }
.pygments-gallery .highlight-native .nt { color: #6EBF26; font-weight: bold }
.pygments-gallery .highlight-native .nv { color: #40FFFF }
.pygments-gallery .highlight-native .ow { color: #6EBF26; font-weight: bold }
.pygments-gallery .highlight-native .pm { color: #D0D0D0 }
.pygments-gallery .highlight-native .w { color: #666 }
.pygments-gallery .highlight-native .mb { color: #51B2FD }
.pygments-gallery .highlight-native .mf { color: #51B2FD }
.pygments-gallery .highlight-native .mh { color: #51B2FD }
.pygments-gallery .highlight-native .mi { color: #51B2FD }
.pygments-gallery .highlight-native .mo { color: #51B2FD }
.pygments-gallery .highlight-native .sa { color: #ED9D13 }
.pygments-gallery .highlight-native .sb { color: #ED9D13 }
.pygments-gallery .highlight-native .sc { color: #ED9D13 }
.pygments-gallery .highlight-native .dl { color: #ED9D13 }
.pygments-gallery .highlight-native .sd { color: #ED9D13 }
.pygments-gallery .highlight-native .s2 { color: #ED9D13 }
.pygments-gallery .highlight-native .se { color: #ED9D13 }
.pygments-gallery .highlight-native .sh { color: #ED9D13 }
.pygments-gallery .highlight-native .si { color: #ED9D13 }
.pygments-gallery .highlight-native .sx { color: #FFA500 }
.pygments-gallery .highlight-native .sr { color: #ED9D13 }
.pygments-gallery .highlight-native .s1 { color: #ED9D13 }
.pygments-gallery .highlight-native .ss { color: #ED9D13 }
.pygments-gallery .highlight-native .bp { color: #2FBCCD }
.pygments-gallery .highlight-native .fm { color: #71ADFF }
.pygments-gallery .highlight-native .vc { color: #40FFFF }
.pygments-gallery .highlight-native .vg { color: #40FFFF }
.pygments-gallery .highlight-native .vi { color: #40FFFF }
.pygments-gallery .highlight-native .vm { color: #40FFFF }
.pygments-gallery .highlight-native .il { color: #51B2FD }
.pygments-gallery .highlight-night-owl .hll { background-color: #1d3b53 }
.pygments-gallery .highlight-night-owl { background: #011627; color: #D6DEEB }
.pygments-gallery .highlight-night-owl .c { color: #637777; font-style: italic }
.pygments-gallery .highlight-night-owl .err { color: #EF5350 }
.pygments-gallery .highlight-night-owl .esc { color: #D6DEEB }
.pygments-gallery .highlight-night-owl .g { color: #D6DEEB }
.pygments-gallery .highlight-night-owl .k { color: #C792EA; font-style: italic }
.pygments-gallery .highlight-night-owl .l { color: #D6DEEB }
.pygments-gallery .highlight-night-owl .n { color: #D6DEEB }
.pygments-gallery .highlight-night-owl .o { color: #7FDBCA }
.pygments-gallery .highlight-night-owl .x { color: #D6DEEB }
.pygments-gallery .highlight-night-owl .p { color: #D6DEEB }
.pygments-gallery .highlight-night-owl .ch { color: #637777; font-style: italic }
.pygments-gallery .highlight-night-owl .cm { color: #637777; font-style: italic }
.pygments-gallery .highlight-night-owl .cp { color: #7FDBCA; font-style: italic }
.pygments-gallery .highlight-night-owl .cpf { color: #637777; font-style: italic }
.pygments-gallery .highlight-night-owl .c1 { color: #637777; font-style: italic }
.pygments-gallery .highlight-night-owl .cs { color: #637777; font-style: italic }
.pygments-gallery .highlight-night-owl .gd { color: #EF5350 }
.pygments-gallery .highlight-night-owl .ge { color: #D6DEEB; font-style: italic }
.pygments-gallery .highlight-night-owl .ges { color: #D6DEEB; font-weight: bold; font-style: italic }
.pygments-gallery .highlight-night-owl .gr { color: #EF5350 }
.pygments-gallery .highlight-night-owl .gh { color: #82AAFF; font-weight: bold }
.pygments-gallery .highlight-night-owl .gi { color: #ADDB67 }
.pygments-gallery .highlight-night-owl .go { color: #637777 }
.pygments-gallery .highlight-night-owl .gp { color: #7FDBCA; font-weight: bold }
.pygments-gallery .highlight-night-owl .gs { color: #D6DEEB; font-weight: bold }
.pygments-gallery .highlight-night-owl .gu { color: #7FDBCA; font-weight: bold }
.pygments-gallery .highlight-night-owl .gt { color: #EF5350 }
.pygments-gallery .highlight-night-owl .kc { color: #C792EA; font-style: italic }
.pygments-gallery .highlight-night-owl .kd { color: #C792EA; font-style: italic }
.pygments-gallery .highlight-night-owl .kn { color: #C792EA; font-style: italic }
.pygments-gallery .highlight-night-owl .kp { color: #C792EA; font-style: italic }
.pygments-gallery .highlight-night-owl .kr { color: #C792EA; font-style: italic }
.pygments-gallery .highlight-night-owl .kt { color: #7FDBCA; font-style: italic }
.pygments-gallery .highlight-night-owl .ld { color: #D6DEEB }
.pygments-gallery .highlight-night-owl .m { color: #F78C6C }
.pygments-gallery .highlight-night-owl .s { color: #ADDB67 }
.pygments-gallery .highlight-night-owl .na { color: #ECC48D }
.pygments-gallery .highlight-night-owl .nb { color: #7FDBCA }
.pygments-gallery .highlight-night-owl .nc { color: #ECC48D }
.pygments-gallery .highlight-night-owl .no { color: #F78C6C }
.pygments-gallery .highlight-night-owl .nd { color: #82AAFF }
.pygments-gallery .highlight-night-owl .ni { color: #F78C6C }
.pygments-gallery .highlight-night-owl .ne { color: #EF5350 }
.pygments-gallery .highlight-night-owl .nf { color: #82AAFF }
.pygments-gallery .highlight-night-owl .nl { color: #D6DEEB }
.pygments-gallery .highlight-night-owl .nn { color: #D6DEEB }
.pygments-gallery .highlight-night-owl .nx { color: #D6DEEB }
.pygments-gallery .highlight-night-owl .py { color: #7FDBCA }
.pygments-gallery .highlight-night-owl .nt { color: #FF869A }
.pygments-gallery .highlight-night-owl .nv { color: #D6DEEB }
.pygments-gallery .highlight-night-owl .ow { color: #C792EA; font-style: italic }
.pygments-gallery .highlight-night-owl .pm { color: #D6DEEB }
.pygments-gallery .highlight-night-owl .w { color: #D6DEEB }
.pygments-gallery .highlight-night-owl .mb { color: #F78C6C }
.pygments-gallery .highlight-night-owl .mf { color: #F78C6C }
.pygments-gallery .highlight-night-owl .mh { color: #F78C6C }
.pygments-gallery .highlight-night-owl .mi { color: #F78C6C }
.pygments-gallery .highlight-night-owl .mo { color: #F78C6C }
.pygments-gallery .highlight-night-owl .sa { color: #7FDBCA }
.pygments-gallery .highlight-night-owl .sb { color: #ADDB67 }
.pygments-gallery .highlight-night-owl .sc { color: #ADDB67 }
.pygments-gallery .highlight-night-owl .dl { color: #ADDB67 }
.pygments-gallery .highlight-night-owl .sd { color: #637777; font-style: italic }
.pygments-gallery .highlight-night-owl .s2 { color: #ADDB67 }
.pygments-gallery .highlight-night-owl .se { color: #ECC48D }
.pygments-gallery .highlight-night-owl .sh { color: #ADDB67 }
.pygments-gallery .highlight-night-owl .si { color: #7FDBCA }
.pygments-gallery .highlight-night-owl .sx { color: #ADDB67 }
.pygments-gallery .highlight-night-owl .sr { color: #7FDBCA }
.pygments-gallery .highlight-night-owl .s1 { color: #ADDB67 }
.pygments-gallery .highlight-night-owl .ss { color: #7FDBCA }
.pygments-gallery .highlight-night-owl .bp { color: #82AAFF; font-style: italic }
.pygments-gallery .highlight-night-owl .fm { color: #7FDBCA }
.pygments-gallery .highlight-night-owl .vc { color: #ECC48D }
.pygments-gallery .highlight-night-owl .vg { color: #F78C6C }
.pygments-gallery .highlight-night-owl .vi { color: #ECC48D }
.pygments-gallery .highlight-night-owl .vm { color: #D6DEEB }
.pygments-gallery .highlight-night-owl .il { color: #F78C6C }
.pygments-gallery .highlight-nord .hll { background-color: #3B4252 }
.pygments-gallery .highlight-nord { background: #2E3440; color: #D8DEE9 }
.pygments-gallery .highlight-nord .c { color: #616E87; font-style: italic }
.pygments-gallery .highlight-nord .err { color: #BF616A }
.pygments-gallery .highlight-nord .esc { color: #D8DEE9 }
.pygments-gallery .highlight-nord .g { color: #D8DEE9 }
.pygments-gallery .highlight-nord .k { color: #81A1C1; font-weight: bold }
.pygments-gallery .highlight-nord .l { color: #D8DEE9 }
.pygments-gallery .highlight-nord .n { color: #D8DEE9 }
.pygments-gallery .highlight-nord .o { color: #81A1C1; font-weight: bold }
.pygments-gallery .highlight-nord .x { color: #D8DEE9 }
.pygments-gallery .highlight-nord .p { color: #ECEFF4 }
.pygments-gallery .highlight-nord .ch { color: #616E87; font-style: italic }
.pygments-gallery .highlight-nord .cm { color: #616E87; font-style: italic }
.pygments-gallery .highlight-nord .cp { color: #5E81AC; font-style: italic }
.pygments-gallery .highlight-nord .cpf { color: #616E87; font-style: italic }
.pygments-gallery .highlight-nord .c1 { color: #616E87; font-style: italic }
.pygments-gallery .highlight-nord .cs { color: #616E87; font-style: italic }
.pygments-gallery .highlight-nord .gd { color: #BF616A }
.pygments-gallery .highlight-nord .ge { color: #D8DEE9; font-style: italic }
.pygments-gallery .highlight-nord .ges { color: #D8DEE9; font-weight: bold; font-style: italic }
.pygments-gallery .highlight-nord .gr { color: #BF616A }
.pygments-gallery .highlight-nord .gh { color: #88C0D0; font-weight: bold }
.pygments-gallery .highlight-nord .gi { color: #A3BE8C }
.pygments-gallery .highlight-nord .go { color: #D8DEE9 }
.pygments-gallery .highlight-nord .gp { color: #616E88; font-weight: bold }
.pygments-gallery .highlight-nord .gs { color: #D8DEE9; font-weight: bold }
.pygments-gallery .highlight-nord .gu { color: #88C0D0; font-weight: bold }
.pygments-gallery .highlight-nord .gt { color: #BF616A }
.pygments-gallery .highlight-nord .kc { color: #81A1C1; font-weight: bold }
.pygments-gallery .highlight-nord .kd { color: #81A1C1; font-weight: bold }
.pygments-gallery .highlight-nord .kn { color: #81A1C1; font-weight: bold }
.pygments-gallery .highlight-nord .kp { color: #81A1C1 }
.pygments-gallery .highlight-nord .kr { color: #81A1C1; font-weight: bold }
.pygments-gallery .highlight-nord .kt { color: #81A1C1 }
.pygments-gallery .highlight-nord .ld { color: #D8DEE9 }
.pygments-gallery .highlight-nord .m { color: #B48EAD }
.pygments-gallery .highlight-nord .s { color: #A3BE8C }
.pygments-gallery .highlight-nord .na { color: #8FBCBB }
.pygments-gallery .highlight-nord .nb { color: #81A1C1 }
.pygments-gallery .highlight-nord .nc { color: #8FBCBB }
.pygments-gallery .highlight-nord .no { color: #8FBCBB }
.pygments-gallery .highlight-nord .nd { color: #D08770 }
.pygments-gallery .highlight-nord .ni { color: #D08770 }
.pygments-gallery .highlight-nord .ne { color: #BF616A }
.pygments-gallery .highlight-nord .nf { color: #88C0D0 }
.pygments-gallery .highlight-nord .nl { color: #D8DEE9 }
.pygments-gallery .highlight-nord .nn { color: #8FBCBB }
.pygments-gallery .highlight-nord .nx { color: #D8DEE9 }
.pygments-gallery .highlight-nord .py { color: #D8DEE9 }
.pygments-gallery .highlight-nord .nt { color: #81A1C1 }
.pygments-gallery .highlight-nord .nv { color: #D8DEE9 }
.pygments-gallery .highlight-nord .ow { color: #81A1C1; font-weight: bold }
.pygments-gallery .highlight-nord .pm { color: #ECEFF4 }
.pygments-gallery .highlight-nord .w { color: #D8DEE9 }
.pygments-gallery .highlight-nord .mb { color: #B48EAD }
.pygments-gallery .highlight-nord .mf { color: #B48EAD }
.pygments-gallery .highlight-nord .mh { color: #B48EAD }
.pygments-gallery .highlight-nord .mi { color: #B48EAD }
.pygments-gallery .highlight-nord .mo { color: #B48EAD }
.pygments-gallery .highlight-nord .sa { color: #A3BE8C }
.pygments-gallery .highlight-nord .sb { color: #A3BE8C }
.pygments-gallery .highlight-nord .sc { color: #A3BE8C }
.pygments-gallery .highlight-nord .dl { color: #A3BE8C }
.pygments-gallery .highlight-nord .sd { color: #616E87 }
.pygments-gallery .highlight-nord .s2 { color: #A3BE8C }
.pygments-gallery .highlight-nord .se { color: #EBCB8B }
.pygments-gallery .highlight-nord .sh { color: #A3BE8C }
.pygments-gallery .highlight-nord .si { color: #A3BE8C }
.pygments-gallery .highlight-nord .sx { color: #A3BE8C }
.pygments-gallery .highlight-nord .sr { color: #EBCB8B }
.pygments-gallery .highlight-nord .s1 { color: #A3BE8C }
.pygments-gallery .highlight-nord .ss { color: #A3BE8C }
.pygments-gallery .highlight-nord .bp { color: #81A1C1 }
.pygments-gallery .highlight-nord .fm { color: #88C0D0 }
.pygments-gallery .highlight-nord .vc { color: #D8DEE9 }
.pygments-gallery .highlight-nord .vg { color: #D8DEE9 }
.pygments-gallery .highlight-nord .vi { color: #D8DEE9 }
.pygments-gallery .highlight-nord .vm { color: #D8DEE9 }
.pygments-gallery .highlight-nord .il { color: #B48EAD }
.pygments-gallery .highlight-nord-darker .hll { background-color: #3B4252 }
.pygments-gallery .highlight-nord-darker { background: #242933; color: #D8DEE9 }
.pygments-gallery .highlight-nord-darker .c { color: #616E87; font-style: italic }
.pygments-gallery .highlight-nord-darker .err { color: #BF616A }
.pygments-gallery .highlight-nord-darker .esc { color: #D8DEE9 }
.pygments-gallery .highlight-nord-darker .g { color: #D8DEE9 }
.pygments-gallery .highlight-nord-darker .k { color: #81A1C1; font-weight: bold }
.pygments-gallery .highlight-nord-darker .l { color: #D8DEE9 }
.pygments-gallery .highlight-nord-darker .n { color: #D8DEE9 }
.pygments-gallery .highlight-nord-darker .o { color: #81A1C1; font-weight: bold }
.pygments-gallery .highlight-nord-darker .x { color: #D8DEE9 }
.pygments-gallery .highlight-nord-darker .p { color: #ECEFF4 }
.pygments-gallery .highlight-nord-darker .ch { color: #616E87; font-style: italic }
.pygments-gallery .highlight-nord-darker .cm { color: #616E87; font-style: italic }
.pygments-gallery .highlight-nord-darker .cp { color: #5E81AC; font-style: italic }
.pygments-gallery .highlight-nord-darker .cpf { color: #616E87; font-style: italic }
.pygments-gallery .highlight-nord-darker .c1 { color: #616E87; font-style: italic }
.pygments-gallery .highlight-nord-darker .cs { color: #616E87; font-style: italic }
.pygments-gallery .highlight-nord-darker .gd { color: #BF616A }
.pygments-gallery .highlight-nord-darker .ge { color: #D8DEE9; font-style: italic }
.pygments-gallery .highlight-nord-darker .ges { color: #D8DEE9 }
.pygments-gallery .highlight-nord-darker .gr { color: #BF616A }
.pygments-gallery .highlight-nord-darker .gh { color: #88C0D0; font-weight: bold }
.pygments-gallery .highlight-nord-darker .gi { color: #A3BE8C }
.pygments-gallery .highlight-nord-darker .go { color: #D8DEE9 }
.pygments-gallery .highlight-nord-darker .gp { color: #616E88; font-weight: bold }
.pygments-gallery .highlight-nord-darker .gs { color: #D8DEE9; font-weight: bold }
.pygments-gallery .highlight-nord-darker .gu { color: #88C0D0; font-weight: bold }
.pygments-gallery .highlight-nord-darker .gt { color: #BF616A }
.pygments-gallery .highlight-nord-darker .kc { color: #81A1C1; font-weight: bold }
.pygments-gallery .highlight-nord-darker .kd { color: #81A1C1; font-weight: bold }
.pygments-gallery .highlight-nord-darker .kn { color: #81A1C1; font-weight: bold }
.pygments-gallery .highlight-nord-darker .kp { color: #81A1C1 }
.pygments-gallery .highlight-nord-darker .kr { color: #81A1C1; font-weight: bold }
.pygments-gallery .highlight-nord-darker .kt { color: #81A1C1 }
.pygments-gallery .highlight-nord-darker .ld { color: #D8DEE9 }
.pygments-gallery .highlight-nord-darker .m { color: #B48EAD }
.pygments-gallery .highlight-nord-darker .s { color: #A3BE8C }
.pygments-gallery .highlight-nord-darker .na { color: #8FBCBB }
.pygments-gallery .highlight-nord-darker .nb { color: #81A1C1 }
.pygments-gallery .highlight-nord-darker .nc { color: #8FBCBB }
.pygments-gallery .highlight-nord-darker .no { color: #8FBCBB }
.pygments-gallery .highlight-nord-darker .nd { color: #D08770 }
.pygments-gallery .highlight-nord-darker .ni { color: #D08770 }
.pygments-gallery .highlight-nord-darker .ne { color: #BF616A }
.pygments-gallery .highlight-nord-darker .nf { color: #88C0D0 }
.pygments-gallery .highlight-nord-darker .nl { color: #D8DEE9 }
.pygments-gallery .highlight-nord-darker .nn { color: #8FBCBB }
.pygments-gallery .highlight-nord-darker .nx { color: #D8DEE9 }
.pygments-gallery .highlight-nord-darker .py { color: #D8DEE9 }
.pygments-gallery .highlight-nord-darker .nt { color: #81A1C1 }
.pygments-gallery .highlight-nord-darker .nv { color: #D8DEE9 }
.pygments-gallery .highlight-nord-darker .ow { color: #81A1C1; font-weight: bold }
.pygments-gallery .highlight-nord-darker .pm { color: #ECEFF4 }
.pygments-gallery .highlight-nord-darker .w { color: #D8DEE9 }
.pygments-gallery .highlight-nord-darker .mb { color: #B48EAD }
.pygments-gallery .highlight-nord-darker .mf { color: #B48EAD }
.pygments-gallery .highlight-nord-darker .mh { color: #B48EAD }
.pygments-gallery .highlight-nord-darker .mi { color: #B48EAD }
.pygments-gallery .highlight-nord-darker .mo { color: #B48EAD }
.pygments-gallery .highlight-nord-darker .sa { color: #A3BE8C }
.pygments-gallery .highlight-nord-darker .sb { color: #A3BE8C }
.pygments-gallery .highlight-nord-darker .sc { color: #A3BE8C }
.pygments-gallery .highlight-nord-darker .dl { color: #A3BE8C }
.pygments-gallery .highlight-nord-darker .sd { color: #616E87 }
.pygments-gallery .highlight-nord-darker .s2 { color: #A3BE8C }
.pygments-gallery .highlight-nord-darker .se { color: #EBCB8B }
.pygments-gallery .highlight-nord-darker .sh { color: #A3BE8C }
.pygments-gallery .highlight-nord-darker .si { color: #A3BE8C }
.pygments-gallery .highlight-nord-darker .sx { color: #A3BE8C }
.pygments-gallery .highlight-nord-darker .sr { color: #EBCB8B }
.pygments-gallery .highlight-nord-darker .s1 { color: #A3BE8C }
.pygments-gallery .highlight-nord-darker .ss { color: #A3BE8C }
.pygments-gallery .highlight-nord-darker .bp { color: #81A1C1 }
.pygments-gallery .highlight-nord-darker .fm { color: #88C0D0 }
.pygments-gallery .highlight-nord-darker .vc { color: #D8DEE9 }
.pygments-gallery .highlight-nord-darker .vg { color: #D8DEE9 }
.pygments-gallery .highlight-nord-darker .vi { color: #D8DEE9 }
.pygments-gallery .highlight-nord-darker .vm { color: #D8DEE9 }
.pygments-gallery .highlight-nord-darker .il { color: #B48EAD }
.pygments-gallery .highlight-one-dark .hll { background-color: #ffffcc }
.pygments-gallery .highlight-one-dark { background: #282C34; color: #ABB2BF }
.pygments-gallery .highlight-one-dark .c { color: #7F848E }
.pygments-gallery .highlight-one-dark .err { color: #ABB2BF }
.pygments-gallery .highlight-one-dark .esc { color: #ABB2BF }
.pygments-gallery .highlight-one-dark .g { color: #ABB2BF }
.pygments-gallery .highlight-one-dark .k { color: #C678DD }
.pygments-gallery .highlight-one-dark .l { color: #ABB2BF }
.pygments-gallery .highlight-one-dark .n { color: #E06C75 }
.pygments-gallery .highlight-one-dark .o { color: #56B6C2 }
.pygments-gallery .highlight-one-dark .x { color: #ABB2BF }
.pygments-gallery .highlight-one-dark .p { color: #ABB2BF }
.pygments-gallery .highlight-one-dark .ch { color: #7F848E }
.pygments-gallery .highlight-one-dark .cm { color: #7F848E }
.pygments-gallery .highlight-one-dark .cp { color: #7F848E }
.pygments-gallery .highlight-one-dark .cpf { color: #7F848E }
.pygments-gallery .highlight-one-dark .c1 { color: #7F848E }
.pygments-gallery .highlight-one-dark .cs { color: #7F848E }
.pygments-gallery .highlight-one-dark .gd { color: #E06C75 }
.pygments-gallery .highlight-one-dark .ge { color: #ABB2BF; font-style: italic }
.pygments-gallery .highlight-one-dark .ges { color: #ABB2BF }
.pygments-gallery .highlight-one-dark .gr { color: #E06C75 }
.pygments-gallery .highlight-one-dark .gh { color: #ABB2BF; font-weight: bold }
.pygments-gallery .highlight-one-dark .gi { color: #98C379 }
.pygments-gallery .highlight-one-dark .go { color: #E06C75 }
.pygments-gallery .highlight-one-dark .gp { color: #ABB2BF }
.pygments-gallery .highlight-one-dark .gs { color: #ABB2BF; font-weight: bold }
.pygments-gallery .highlight-one-dark .gu { color: #ABB2BF; font-weight: bold }
.pygments-gallery .highlight-one-dark .gt { color: #E06C75 }
.pygments-gallery .highlight-one-dark .kc { color: #E5C07B }
.pygments-gallery .highlight-one-dark .kd { color: #C678DD }
.pygments-gallery .highlight-one-dark .kn { color: #C678DD }
.pygments-gallery .highlight-one-dark .kp { color: #C678DD }
.pygments-gallery .highlight-one-dark .kr { color: #C678DD }
.pygments-gallery .highlight-one-dark .kt { color: #E5C07B }
.pygments-gallery .highlight-one-dark .ld { color: #ABB2BF }
.pygments-gallery .highlight-one-dark .m { color: #D19A66 }
.pygments-gallery .highlight-one-dark .s { color: #98C379 }
.pygments-gallery .highlight-one-dark .na { color: #E06C75 }
.pygments-gallery .highlight-one-dark .nb { color: #E5C07B }
.pygments-gallery .highlight-one-dark .nc { color: #E5C07B }
.pygments-gallery .highlight-one-dark .no { color: #E06C75 }
.pygments-gallery .highlight-one-dark .nd { color: #61AFEF }
.pygments-gallery .highlight-one-dark .ni { color: #E06C75 }
.pygments-gallery .highlight-one-dark .ne { color: #E06C75 }
.pygments-gallery .highlight-one-dark .nf { color: #61AFEF; font-weight: bold }
.pygments-gallery .highlight-one-dark .nl { color: #E06C75 }
.pygments-gallery .highlight-one-dark .nn { color: #E06C75 }
.pygments-gallery .highlight-one-dark .nx { color: #E06C75 }
.pygments-gallery .highlight-one-dark .py { color: #E06C75 }
.pygments-gallery .highlight-one-dark .nt { color: #E06C75 }
.pygments-gallery .highlight-one-dark .nv { color: #E06C75 }
.pygments-gallery .highlight-one-dark .ow { color: #56B6C2 }
.pygments-gallery .highlight-one-dark .pm { color: #ABB2BF }
.pygments-gallery .highlight-one-dark .w { color: #ABB2BF }
.pygments-gallery .highlight-one-dark .mb { color: #D19A66 }
.pygments-gallery .highlight-one-dark .mf { color: #D19A66 }
.pygments-gallery .highlight-one-dark .mh { color: #D19A66 }
.pygments-gallery .highlight-one-dark .mi { color: #D19A66 }
.pygments-gallery .highlight-one-dark .mo { color: #D19A66 }
.pygments-gallery .highlight-one-dark .sa { color: #98C379 }
.pygments-gallery .highlight-one-dark .sb { color: #98C379 }
.pygments-gallery .highlight-one-dark .sc { color: #98C379 }
.pygments-gallery .highlight-one-dark .dl { color: #98C379 }
.pygments-gallery .highlight-one-dark .sd { color: #98C379 }
.pygments-gallery .highlight-one-dark .s2 { color: #98C379 }
.pygments-gallery .highlight-one-dark .se { color: #98C379 }
.pygments-gallery .highlight-one-dark .sh { color: #98C379 }
.pygments-gallery .highlight-one-dark .si { color: #98C379 }
.pygments-gallery .highlight-one-dark .sx { color: #98C379 }
.pygments-gallery .highlight-one-dark .sr { color: #98C379 }
.pygments-gallery .highlight-one-dark .s1 { color: #98C379 }
.pygments-gallery .highlight-one-dark .ss { color: #98C379 }
.pygments-gallery .highlight-one-dark .bp { color: #E5C07B }
.pygments-gallery .highlight-one-dark .fm { color: #56B6C2; font-weight: bold }
.pygments-gallery .highlight-one-dark .vc { color: #E06C75 }
.pygments-gallery .highlight-one-dark .vg { color: #E06C75 }
.pygments-gallery .highlight-one-dark .vi { color: #E06C75 }
.pygments-gallery .highlight-one-dark .vm { color: #E06C75 }
.pygments-gallery .highlight-one-dark .il { color: #D19A66 }
.pygments-gallery .highlight-paraiso-dark .hll { background-color: #4f424c }
.pygments-gallery .highlight-paraiso-dark { background: #2f1e2e; color: #E7E9DB }
.pygments-gallery .highlight-paraiso-dark .c { color: #776E71 }
.pygments-gallery .highlight-paraiso-dark .err { color: #EF6155 }
.pygments-gallery .highlight-paraiso-dark .k { color: #815BA4 }
.pygments-gallery .highlight-paraiso-dark .l { color: #F99B15 }
.pygments-gallery .highlight-paraiso-dark .n { color: #E7E9DB }
.pygments-gallery .highlight-paraiso-dark .o { color: #5BC4BF }
.pygments-gallery .highlight-paraiso-dark .p { color: #E7E9DB }
.pygments-gallery .highlight-paraiso-dark .ch { color: #776E71 }
.pygments-gallery .highlight-paraiso-dark .cm { color: #776E71 }
.pygments-gallery .highlight-paraiso-dark .cp { color: #776E71 }
.pygments-gallery .highlight-paraiso-dark .cpf { color: #776E71 }
.pygments-gallery .highlight-paraiso-dark .c1 { color: #776E71 }
.pygments-gallery .highlight-paraiso-dark .cs { color: #776E71 }
.pygments-gallery .highlight-paraiso-dark .gd { color: #EF6155 }
.pygments-gallery .highlight-paraiso-dark .ge { font-style: italic }
.pygments-gallery .highlight-paraiso-dark .ges { font-weight: bold; font-style: italic }
.pygments-gallery .highlight-paraiso-dark .gh { color: #E7E9DB; font-weight: bold }
.pygments-gallery .highlight-paraiso-dark .gi { color: #48B685 }
.pygments-gallery .highlight-paraiso-dark .gp { color: #776E71; font-weight: bold }
.pygments-gallery .highlight-paraiso-dark .gs { font-weight: bold }
.pygments-gallery .highlight-paraiso-dark .gu { color: #5BC4BF; font-weight: bold }
.pygments-gallery .highlight-paraiso-dark .kc { color: #815BA4 }
.pygments-gallery .highlight-paraiso-dark .kd { color: #815BA4 }
.pygments-gallery .highlight-paraiso-dark .kn { color: #5BC4BF }
.pygments-gallery .highlight-paraiso-dark .kp { color: #815BA4 }
.pygments-gallery .highlight-paraiso-dark .kr { color: #815BA4 }
.pygments-gallery .highlight-paraiso-dark .kt { color: #FEC418 }
.pygments-gallery .highlight-paraiso-dark .ld { color: #48B685 }
.pygments-gallery .highlight-paraiso-dark .m { color: #F99B15 }
.pygments-gallery .highlight-paraiso-dark .s { color: #48B685 }
.pygments-gallery .highlight-paraiso-dark .na { color: #06B6EF }
.pygments-gallery .highlight-paraiso-dark .nb { color: #E7E9DB }
.pygments-gallery .highlight-paraiso-dark .nc { color: #FEC418 }
.pygments-gallery .highlight-paraiso-dark .no { color: #EF6155 }
.pygments-gallery .highlight-paraiso-dark .nd { color: #5BC4BF }
.pygments-gallery .highlight-paraiso-dark .ni { color: #E7E9DB }
.pygments-gallery .highlight-paraiso-dark .ne { color: #EF6155 }
.pygments-gallery .highlight-paraiso-dark .nf { color: #06B6EF }
.pygments-gallery .highlight-paraiso-dark .nl { color: #E7E9DB }
.pygments-gallery .highlight-paraiso-dark .nn { color: #FEC418 }
.pygments-gallery .highlight-paraiso-dark .nx { color: #06B6EF }
.pygments-gallery .highlight-paraiso-dark .py { color: #E7E9DB }
.pygments-gallery .highlight-paraiso-dark .nt { color: #5BC4BF }
.pygments-gallery .highlight-paraiso-dark .nv { color: #EF6155 }
.pygments-gallery .highlight-paraiso-dark .ow { color: #5BC4BF }
.pygments-gallery .highlight-paraiso-dark .pm { color: #E7E9DB }
.pygments-gallery .highlight-paraiso-dark .w { color: #E7E9DB }
.pygments-gallery .highlight-paraiso-dark .mb { color: #F99B15 }
.pygments-gallery .highlight-paraiso-dark .mf { color: #F99B15 }
.pygments-gallery .highlight-paraiso-dark .mh { color: #F99B15 }
.pygments-gallery .highlight-paraiso-dark .mi { color: #F99B15 }
.pygments-gallery .highlight-paraiso-dark .mo { color: #F99B15 }
.pygments-gallery .highlight-paraiso-dark .sa { color: #48B685 }
.pygments-gallery .highlight-paraiso-dark .sb { color: #48B685 }
.pygments-gallery .highlight-paraiso-dark .sc { color: #E7E9DB }
.pygments-gallery .highlight-paraiso-dark .dl { color: #48B685 }
.pygments-gallery .highlight-paraiso-dark .sd { color: #776E71 }
.pygments-gallery .highlight-paraiso-dark .s2 { color: #48B685 }
.pygments-gallery .highlight-paraiso-dark .se { color: #F99B15 }
.pygments-gallery .highlight-paraiso-dark .sh { color: #48B685 }
.pygments-gallery .highlight-paraiso-dark .si { color: #F99B15 }
.pygments-gallery .highlight-paraiso-dark .sx { color: #48B685 }
.pygments-gallery .highlight-paraiso-dark .sr { color: #48B685 }
.pygments-gallery .highlight-paraiso-dark .s1 { color: #48B685 }
.pygments-gallery .highlight-paraiso-dark .ss { color: #48B685 }
.pygments-gallery .highlight-paraiso-dark .bp { color: #E7E9DB }
.pygments-gallery .highlight-paraiso-dark .fm { color: #06B6EF }
.pygments-gallery .highlight-paraiso-dark .vc { color: #EF6155 }
.pygments-gallery .highlight-paraiso-dark .vg { color: #EF6155 }
.pygments-gallery .highlight-paraiso-dark .vi { color: #EF6155 }
.pygments-gallery .highlight-paraiso-dark .vm { color: #EF6155 }
.pygments-gallery .highlight-paraiso-dark .il { color: #F99B15 }
.pygments-gallery .highlight-paraiso-light .hll { background-color: #a39e9b }
.pygments-gallery .highlight-paraiso-light { background: #e7e9db; color: #2F1E2E }
.pygments-gallery .highlight-paraiso-light .c { color: #8D8687 }
.pygments-gallery .highlight-paraiso-light .err { color: #EF6155 }
.pygments-gallery .highlight-paraiso-light .k { color: #815BA4 }
.pygments-gallery .highlight-paraiso-light .l { color: #F99B15 }
.pygments-gallery .highlight-paraiso-light .n { color: #2F1E2E }
.pygments-gallery .highlight-paraiso-light .o { color: #5BC4BF }
.pygments-gallery .highlight-paraiso-light .p { color: #2F1E2E }
.pygments-gallery .highlight-paraiso-light .ch { color: #8D8687 }
.pygments-gallery .highlight-paraiso-light .cm { color: #8D8687 }
.pygments-gallery .highlight-paraiso-light .cp { color: #8D8687 }
.pygments-gallery .highlight-paraiso-light .cpf { color: #8D8687 }
.pygments-gallery .highlight-paraiso-light .c1 { color: #8D8687 }
.pygments-gallery .highlight-paraiso-light .cs { color: #8D8687 }
.pygments-gallery .highlight-paraiso-light .gd { color: #EF6155 }
.pygments-gallery .highlight-paraiso-light .ge { font-style: italic }
.pygments-gallery .highlight-paraiso-light .ges { font-weight: bold; font-style: italic }
.pygments-gallery .highlight-paraiso-light .gh { color: #2F1E2E; font-weight: bold }
.pygments-gallery .highlight-paraiso-light .gi { color: #48B685 }
.pygments-gallery .highlight-paraiso-light .gp { color: #8D8687; font-weight: bold }
.pygments-gallery .highlight-paraiso-light .gs { font-weight: bold }
.pygments-gallery .highlight-paraiso-light .gu { color: #5BC4BF; font-weight: bold }
.pygments-gallery .highlight-paraiso-light .kc { color: #815BA4 }
.pygments-gallery .highlight-paraiso-light .kd { color: #815BA4 }
.pygments-gallery .highlight-paraiso-light .kn { color: #5BC4BF }
.pygments-gallery .highlight-paraiso-light .kp { color: #815BA4 }
.pygments-gallery .highlight-paraiso-light .kr { color: #815BA4 }
.pygments-gallery .highlight-paraiso-light .kt { color: #FEC418 }
.pygments-gallery .highlight-paraiso-light .ld { color: #48B685 }
.pygments-gallery .highlight-paraiso-light .m { color: #F99B15 }
.pygments-gallery .highlight-paraiso-light .s { color: #48B685 }
.pygments-gallery .highlight-paraiso-light .na { color: #06B6EF }
.pygments-gallery .highlight-paraiso-light .nb { color: #2F1E2E }
.pygments-gallery .highlight-paraiso-light .nc { color: #FEC418 }
.pygments-gallery .highlight-paraiso-light .no { color: #EF6155 }
.pygments-gallery .highlight-paraiso-light .nd { color: #5BC4BF }
.pygments-gallery .highlight-paraiso-light .ni { color: #2F1E2E }
.pygments-gallery .highlight-paraiso-light .ne { color: #EF6155 }
.pygments-gallery .highlight-paraiso-light .nf { color: #06B6EF }
.pygments-gallery .highlight-paraiso-light .nl { color: #2F1E2E }
.pygments-gallery .highlight-paraiso-light .nn { color: #FEC418 }
.pygments-gallery .highlight-paraiso-light .nx { color: #06B6EF }
.pygments-gallery .highlight-paraiso-light .py { color: #2F1E2E }
.pygments-gallery .highlight-paraiso-light .nt { color: #5BC4BF }
.pygments-gallery .highlight-paraiso-light .nv { color: #EF6155 }
.pygments-gallery .highlight-paraiso-light .ow { color: #5BC4BF }
.pygments-gallery .highlight-paraiso-light .pm { color: #2F1E2E }
.pygments-gallery .highlight-paraiso-light .w { color: #2F1E2E }
.pygments-gallery .highlight-paraiso-light .mb { color: #F99B15 }
.pygments-gallery .highlight-paraiso-light .mf { color: #F99B15 }
.pygments-gallery .highlight-paraiso-light .mh { color: #F99B15 }
.pygments-gallery .highlight-paraiso-light .mi { color: #F99B15 }
.pygments-gallery .highlight-paraiso-light .mo { color: #F99B15 }
.pygments-gallery .highlight-paraiso-light .sa { color: #48B685 }
.pygments-gallery .highlight-paraiso-light .sb { color: #48B685 }
.pygments-gallery .highlight-paraiso-light .sc { color: #2F1E2E }
.pygments-gallery .highlight-paraiso-light .dl { color: #48B685 }
.pygments-gallery .highlight-paraiso-light .sd { color: #8D8687 }
.pygments-gallery .highlight-paraiso-light .s2 { color: #48B685 }
.pygments-gallery .highlight-paraiso-light .se { color: #F99B15 }
.pygments-gallery .highlight-paraiso-light .sh { color: #48B685 }
.pygments-gallery .highlight-paraiso-light .si { color: #F99B15 }
.pygments-gallery .highlight-paraiso-light .sx { color: #48B685 }
.pygments-gallery .highlight-paraiso-light .sr { color: #48B685 }
.pygments-gallery .highlight-paraiso-light .s1 { color: #48B685 }
.pygments-gallery .highlight-paraiso-light .ss { color: #48B685 }
.pygments-gallery .highlight-paraiso-light .bp { color: #2F1E2E }
.pygments-gallery .highlight-paraiso-light .fm { color: #06B6EF }
.pygments-gallery .highlight-paraiso-light .vc { color: #EF6155 }
.pygments-gallery .highlight-paraiso-light .vg { color: #EF6155 }
.pygments-gallery .highlight-paraiso-light .vi { color: #EF6155 }
.pygments-gallery .highlight-paraiso-light .vm { color: #EF6155 }
.pygments-gallery .highlight-paraiso-light .il { color: #F99B15 }
.pygments-gallery .highlight-pastie .hll { background-color: #ffffcc }
.pygments-gallery .highlight-pastie { background: #ffffff; }
.pygments-gallery .highlight-pastie .c { color: #888 }
.pygments-gallery .highlight-pastie .err { color: #A61717; background-color: #E3D2D2 }
.pygments-gallery .highlight-pastie .k { color: #080; font-weight: bold }
.pygments-gallery .highlight-pastie .ch { color: #888 }
.pygments-gallery .highlight-pastie .cm { color: #888 }
.pygments-gallery .highlight-pastie .cp { color: #C00; font-weight: bold }
.pygments-gallery .highlight-pastie .cpf { color: #888 }
.pygments-gallery .highlight-pastie .c1 { color: #888 }
.pygments-gallery .highlight-pastie .cs { color: #C00; font-weight: bold; background-color: #FFF0F0 }
.pygments-gallery .highlight-pastie .gd { color: #000; background-color: #FDD }
.pygments-gallery .highlight-pastie .ge { font-style: italic }
.pygments-gallery .highlight-pastie .ges { font-weight: bold; font-style: italic }
.pygments-gallery .highlight-pastie .gr { color: #A00 }
.pygments-gallery .highlight-pastie .gh { color: #333 }
.pygments-gallery .highlight-pastie .gi { color: #000; background-color: #DFD }
.pygments-gallery .highlight-pastie .go { color: #888 }
.pygments-gallery .highlight-pastie .gp { color: #555 }
.pygments-gallery .highlight-pastie .gs { font-weight: bold }
.pygments-gallery .highlight-pastie .gu { color: #666 }
.pygments-gallery .highlight-pastie .gt { color: #A00 }
.pygments-gallery .highlight-pastie .kc { color: #080; font-weight: bold }
.pygments-gallery .highlight-pastie .kd { color: #080; font-weight: bold }
.pygments-gallery .highlight-pastie .kn { color: #080; font-weight: bold }
.pygments-gallery .highlight-pastie .kp { color: #080 }
.pygments-gallery .highlight-pastie .kr { color: #080; font-weight: bold }
.pygments-gallery .highlight-pastie .kt { color: #888; font-weight: bold }
.pygments-gallery .highlight-pastie .m { color: #00D; font-weight: bold }
.pygments-gallery .highlight-pastie .s { color: #D20; background-color: #FFF0F0 }
.pygments-gallery .highlight-pastie .na { color: #369 }
.pygments-gallery .highlight-pastie .nb { color: #038 }
.pygments-gallery .highlight-pastie .nc { color: #B06; font-weight: bold }
.pygments-gallery .highlight-pastie .no { color: #036; font-weight: bold }
.pygments-gallery .highlight-pastie .nd { color: #555 }
.pygments-gallery .highlight-pastie .ne { color: #B06; font-weight: bold }
.pygments-gallery .highlight-pastie .nf { color: #06B; font-weight: bold }
.pygments-gallery .highlight-pastie .nl { color: #369; font-style: italic }
.pygments-gallery .highlight-pastie .nn { color: #B06; font-weight: bold }
.pygments-gallery .highlight-pastie .py { color: #369; font-weight: bold }
.pygments-gallery .highlight-pastie .nt { color: #B06; font-weight: bold }
.pygments-gallery .highlight-pastie .nv { color: #369 }
.pygments-gallery .highlight-pastie .ow { color: #080 }
.pygments-gallery .highlight-pastie .w { color: #BBB }
.pygments-gallery .highlight-pastie .mb { color: #00D; font-weight: bold }
.pygments-gallery .highlight-pastie .mf { color: #00D; font-weight: bold }
.pygments-gallery .highlight-pastie .mh { color: #00D; font-weight: bold }
.pygments-gallery .highlight-pastie .mi { color: #00D; font-weight: bold }
.pygments-gallery .highlight-pastie .mo { color: #00D; font-weight: bold }
.pygments-gallery .highlight-pastie .sa { color: #D20; background-color: #FFF0F0 }
.pygments-gallery .highlight-pastie .sb { color: #D20; background-color: #FFF0F0 }
.pygments-gallery .highlight-pastie .sc { color: #D20; background-color: #FFF0F0 }
.pygments-gallery .highlight-pastie .dl { color: #D20; background-color: #FFF0F0 }
.pygments-gallery .highlight-pastie .sd { color: #D20; background-color: #FFF0F0 }
.pygments-gallery .highlight-pastie .s2 { color: #D20; background-color: #FFF0F0 }
.pygments-gallery .highlight-pastie .se { color: #04D; background-color: #FFF0F0 }
.pygments-gallery .highlight-pastie .sh { color: #D20; background-color: #FFF0F0 }
.pygments-gallery .highlight-pastie .si { color: #33B; background-color: #FFF0F0 }
.pygments-gallery .highlight-pastie .sx { color: #2B2; background-color: #F0FFF0 }
.pygments-gallery .highlight-pastie .sr { color: #080; background-color: #FFF0FF }
.pygments-gallery .highlight-pastie .s1 { color: #D20; background-color: #FFF0F0 }
.pygments-gallery .highlight-pastie .ss { color: #A60; background-color: #FFF0F0 }
.pygments-gallery .highlight-pastie .bp { color: #038 }
.pygments-gallery .highlight-pastie .fm { color: #06B; font-weight: bold }
.pygments-gallery .highlight-pastie .vc { color: #369 }
.pygments-gallery .highlight-pastie .vg { color: #D70 }
.pygments-gallery .highlight-pastie .vi { color: #33B }
.pygments-gallery .highlight-pastie .vm { color: #369 }
.pygments-gallery .highlight-pastie .il { color: #00D; font-weight: bold }
.pygments-gallery .highlight-perldoc .hll { background-color: #ffffcc }
.pygments-gallery .highlight-perldoc { background: #eeeedd; }
.pygments-gallery .highlight-perldoc .c { color: #228B22 }
.pygments-gallery .highlight-perldoc .err { color: #A61717; background-color: #E3D2D2 }
.pygments-gallery .highlight-perldoc .k { color: #8B008B; font-weight: bold }
.pygments-gallery .highlight-perldoc .ch { color: #228B22 }
.pygments-gallery .highlight-perldoc .cm { color: #228B22 }
.pygments-gallery .highlight-perldoc .cp { color: #1E889B }
.pygments-gallery .highlight-perldoc .cpf { color: #228B22 }
.pygments-gallery .highlight-perldoc .c1 { color: #228B22 }
.pygments-gallery .highlight-perldoc .cs { color: #8B008B; font-weight: bold }
.pygments-gallery .highlight-perldoc .gd { color: #A00 }
.pygments-gallery .highlight-perldoc .ge { font-style: italic }
.pygments-gallery .highlight-perldoc .ges { font-weight: bold; font-style: italic }
.pygments-gallery .highlight-perldoc .gr { color: #A00 }
.pygments-gallery .highlight-perldoc .gh { color: #000080; font-weight: bold }
.pygments-gallery .highlight-perldoc .gi { color: #0A0 }
.pygments-gallery .highlight-perldoc .go { color: #888 }
.pygments-gallery .highlight-perldoc .gp { color: #555 }
.pygments-gallery .highlight-perldoc .gs { font-weight: bold }
.pygments-gallery .highlight-perldoc .gu { color: #800080; font-weight: bold }
.pygments-gallery .highlight-perldoc .gt { color: #A00 }
.pygments-gallery .highlight-perldoc .kc { color: #8B008B; font-weight: bold }
.pygments-gallery .highlight-perldoc .kd { color: #8B008B; font-weight: bold }
.pygments-gallery .highlight-perldoc .kn { color: #8B008B; font-weight: bold }
.pygments-gallery .highlight-perldoc .kp { color: #8B008B; font-weight: bold }
.pygments-gallery .highlight-perldoc .kr { color: #8B008B; font-weight: bold }
.pygments-gallery .highlight-perldoc .kt { color: #00688B; font-weight: bold }
.pygments-gallery .highlight-perldoc .m { color: #B452CD }
.pygments-gallery .highlight-perldoc .s { color: #CD5555 }
.pygments-gallery .highlight-perldoc .na { color: #658B00 }
.pygments-gallery .highlight-perldoc .nb { color: #658B00 }
.pygments-gallery .highlight-perldoc .nc { color: #008B45; font-weight: bold }
.pygments-gallery .highlight-perldoc .no { color: #00688B }
.pygments-gallery .highlight-perldoc .nd { color: #707A7C }
.pygments-gallery .highlight-perldoc .ne { color: #008B45; font-weight: bold }
.pygments-gallery .highlight-perldoc .nf { color: #008B45 }
.pygments-gallery .highlight-perldoc .nn { color: #008B45; text-decoration: underline }
.pygments-gallery .highlight-perldoc .nt { color: #8B008B; font-weight: bold }
.pygments-gallery .highlight-perldoc .nv { color: #00688B }
.pygments-gallery .highlight-perldoc .ow { color: #8B008B }
.pygments-gallery .highlight-perldoc .w { color: #BBB }
.pygments-gallery .highlight-perldoc .mb { color: #B452CD }
.pygments-gallery .highlight-perldoc .mf { color: #B452CD }
.pygments-gallery .highlight-perldoc .mh { color: #B452CD }
.pygments-gallery .highlight-perldoc .mi { color: #B452CD }
.pygments-gallery .highlight-perldoc .mo { color: #B452CD }
.pygments-gallery .highlight-perldoc .sa { color: #CD5555 }
.pygments-gallery .highlight-perldoc .sb { color: #CD5555 }
.pygments-gallery .highlight-perldoc .sc { color: #CD5555 }
.pygments-gallery .highlight-perldoc .dl { color: #CD5555 }
.pygments-gallery .highlight-perldoc .sd { color: #CD5555 }
.pygments-gallery .highlight-perldoc .s2 { color: #CD5555 }
.pygments-gallery .highlight-perldoc .se { color: #CD5555 }
.pygments-gallery .highlight-perldoc .sh { color: #1C7E71; font-style: italic }
.pygments-gallery .highlight-perldoc .si { color: #CD5555 }
.pygments-gallery .highlight-perldoc .sx { color: #CB6C20 }
.pygments-gallery .highlight-perldoc .sr { color: #1C7E71 }
.pygments-gallery .highlight-perldoc .s1 { color: #CD5555 }
.pygments-gallery .highlight-perldoc .ss { color: #CD5555 }
.pygments-gallery .highlight-perldoc .bp { color: #658B00 }
.pygments-gallery .highlight-perldoc .fm { color: #008B45 }
.pygments-gallery .highlight-perldoc .vc { color: #00688B }
.pygments-gallery .highlight-perldoc .vg { color: #00688B }
.pygments-gallery .highlight-perldoc .vi { color: #00688B }
.pygments-gallery .highlight-perldoc .vm { color: #00688B }
.pygments-gallery .highlight-perldoc .il { color: #B452CD }
.pygments-gallery .highlight-pitaya-smoothie .hll { background-color: #2A1968 }
.pygments-gallery .highlight-pitaya-smoothie { background: #181036; color: #FEFEFF }
.pygments-gallery .highlight-pitaya-smoothie .c { color: #8786AC }
.pygments-gallery .highlight-pitaya-smoothie .err { color: #F26196 }
.pygments-gallery .highlight-pitaya-smoothie .k { color: #FAD000 }
.pygments-gallery .highlight-pitaya-smoothie .l { color: #F5A394 }
.pygments-gallery .highlight-pitaya-smoothie .n { color: #FEFEFF }
.pygments-gallery .highlight-pitaya-smoothie .o { color: #18C1C4 }
.pygments-gallery .highlight-pitaya-smoothie .p { color: #FEFEFF }
.pygments-gallery .highlight-pitaya-smoothie .ch { color: #8786AC }
.pygments-gallery .highlight-pitaya-smoothie .cm { color: #8786AC }
.pygments-gallery .highlight-pitaya-smoothie .cp { color: #8786AC }
.pygments-gallery .highlight-pitaya-smoothie .cpf { color: #8786AC }
.pygments-gallery .highlight-pitaya-smoothie .c1 { color: #8786AC }
.pygments-gallery .highlight-pitaya-smoothie .cs { color: #8786AC }
.pygments-gallery .highlight-pitaya-smoothie .gd { color: #7998F2 }
.pygments-gallery .highlight-pitaya-smoothie .ge { font-style: italic }
.pygments-gallery .highlight-pitaya-smoothie .gh { color: #7998F2 }
.pygments-gallery .highlight-pitaya-smoothie .gs { font-weight: bold }
.pygments-gallery .highlight-pitaya-smoothie .gu { color: #7998F2 }
.pygments-gallery .highlight-pitaya-smoothie .kc { color: #C4A2F5 }
.pygments-gallery .highlight-pitaya-smoothie .kd { color: #FAD000 }
.pygments-gallery .highlight-pitaya-smoothie .kn { color: #FAD000 }
.pygments-gallery .highlight-pitaya-smoothie .kp { color: #FAD000 }
.pygments-gallery .highlight-pitaya-smoothie .kr { color: #FAD000 }
.pygments-gallery .highlight-pitaya-smoothie .kt { color: #F5A394 }
.pygments-gallery .highlight-pitaya-smoothie .ld { color: #F5A394 }
.pygments-gallery .highlight-pitaya-smoothie .m { color: #F5A394 }
.pygments-gallery .highlight-pitaya-smoothie .s { color: #7998F2 }
.pygments-gallery .highlight-pitaya-smoothie .na { color: #FAD000 }
.pygments-gallery .highlight-pitaya-smoothie .nb { color: #C4A2F5 }
.pygments-gallery .highlight-pitaya-smoothie .nc { color: #7998F2 }
.pygments-gallery .highlight-pitaya-smoothie .no { color: #C4A2F5 }
.pygments-gallery .highlight-pitaya-smoothie .nd { color: #F5A394 }
.pygments-gallery .highlight-pitaya-smoothie .ni { color: #7998F2 }
.pygments-gallery .highlight-pitaya-smoothie .ne { color: #C4A2F5 }
.pygments-gallery .highlight-pitaya-smoothie .nf { color: #7998F2 }
.pygments-gallery .highlight-pitaya-smoothie .nl { color: #F5A394 }
.pygments-gallery .highlight-pitaya-smoothie .nn { color: #FEFEFF }
.pygments-gallery .highlight-pitaya-smoothie .nx { color: #FEFEFF }
.pygments-gallery .highlight-pitaya-smoothie .py { color: #7998F2 }
.pygments-gallery .highlight-pitaya-smoothie .nt { color: #7998F2 }
.pygments-gallery .highlight-pitaya-smoothie .nv { color: #F5A394 }
.pygments-gallery .highlight-pitaya-smoothie .ow { color: #C4A2F5 }
.pygments-gallery .highlight-pitaya-smoothie .pm { color: #FEFEFF }
.pygments-gallery .highlight-pitaya-smoothie .w { color: #FEFEFF }
.pygments-gallery .highlight-pitaya-smoothie .mb { color: #F5A394 }
.pygments-gallery .highlight-pitaya-smoothie .mf { color: #F5A394 }
.pygments-gallery .highlight-pitaya-smoothie .mh { color: #F5A394 }
.pygments-gallery .highlight-pitaya-smoothie .mi { color: #F5A394 }
.pygments-gallery .highlight-pitaya-smoothie .mo { color: #F5A394 }
.pygments-gallery .highlight-pitaya-smoothie .sa { color: #7998F2 }
.pygments-gallery .highlight-pitaya-smoothie .sb { color: #66E9EC }
.pygments-gallery .highlight-pitaya-smoothie .sc { color: #7998F2 }
.pygments-gallery .highlight-pitaya-smoothie .dl { color: #7998F2 }
.pygments-gallery .highlight-pitaya-smoothie .sd { color: #C4A2F5 }
.pygments-gallery .highlight-pitaya-smoothie .s2 { color: #7998F2 }
.pygments-gallery .highlight-pitaya-smoothie .se { color: #F5A394 }
.pygments-gallery .highlight-pitaya-smoothie .sh { color: #7998F2 }
.pygments-gallery .highlight-pitaya-smoothie .si { color: #7998F2 }
.pygments-gallery .highlight-pitaya-smoothie .sx { color: #7998F2 }
.pygments-gallery .highlight-pitaya-smoothie .sr { color: #7998F2 }
.pygments-gallery .highlight-pitaya-smoothie .s1 { color: #7998F2 }
.pygments-gallery .highlight-pitaya-smoothie .ss { color: #7998F2 }
.pygments-gallery .highlight-pitaya-smoothie .bp { color: #F5A394 }
.pygments-gallery .highlight-pitaya-smoothie .fm { color: #7998F2 }
.pygments-gallery .highlight-pitaya-smoothie .vc { color: #F5A394 }
.pygments-gallery .highlight-pitaya-smoothie .vg { color: #F5A394 }
.pygments-gallery .highlight-pitaya-smoothie .vi { color: #F5A394 }
.pygments-gallery .highlight-pitaya-smoothie .vm { color: #F5A394 }
.pygments-gallery .highlight-pitaya-smoothie .il { color: #F5A394 }
.pygments-gallery .highlight-rainbow_dash .hll { background-color: #ffffcc }
.pygments-gallery .highlight-rainbow_dash { background: #ffffff; color: #4D4D4D }
.pygments-gallery .highlight-rainbow_dash .c { color: #0080FF; font-style: italic }
.pygments-gallery .highlight-rainbow_dash .err { color: #FFF; background-color: #C00 }
.pygments-gallery .highlight-rainbow_dash .k { color: #2C5DCD; font-weight: bold }
.pygments-gallery .highlight-rainbow_dash .o { color: #2C5DCD }
.pygments-gallery .highlight-rainbow_dash .ch { color: #0080FF; font-style: italic }
.pygments-gallery .highlight-rainbow_dash .cm { color: #0080FF; font-style: italic }
.pygments-gallery .highlight-rainbow_dash .cp { color: #0080FF }
.pygments-gallery .highlight-rainbow_dash .cpf { color: #0080FF; font-style: italic }
.pygments-gallery .highlight-rainbow_dash .c1 { color: #0080FF; font-style: italic }
.pygments-gallery .highlight-rainbow_dash .cs { color: #0080FF; font-weight: bold; font-style: italic }
.pygments-gallery .highlight-rainbow_dash .gd { background-color: #FCC; border: 1px solid #C5060B }
.pygments-gallery .highlight-rainbow_dash .ge { font-style: italic }
.pygments-gallery .highlight-rainbow_dash .ges { font-weight: bold; font-style: italic }
.pygments-gallery .highlight-rainbow_dash .gr { color: #F00 }
.pygments-gallery .highlight-rainbow_dash .gh { color: #2C5DCD; font-weight: bold }
.pygments-gallery .highlight-rainbow_dash .gi { background-color: #CFC; border: 1px solid #0C0 }
.pygments-gallery .highlight-rainbow_dash .go { color: #AAA }
.pygments-gallery .highlight-rainbow_dash .gp { color: #2C5DCD; font-weight: bold }
.pygments-gallery .highlight-rainbow_dash .gs { font-weight: bold }
.pygments-gallery .highlight-rainbow_dash .gu { color: #2C5DCD; font-weight: bold }
.pygments-gallery .highlight-rainbow_dash .gt { color: #C5060B }
.pygments-gallery .highlight-rainbow_dash .kc { color: #2C5DCD; font-weight: bold }
.pygments-gallery .highlight-rainbow_dash .kd { color: #2C5DCD; font-weight: bold }
.pygments-gallery .highlight-rainbow_dash .kn { color: #2C5DCD; font-weight: bold }
.pygments-gallery .highlight-rainbow_dash .kp { color: #2C5DCD }
.pygments-gallery .highlight-rainbow_dash .kr { color: #2C5DCD; font-weight: bold }
.pygments-gallery .highlight-rainbow_dash .kt { color: #5918BB; font-weight: bold }
.pygments-gallery .highlight-rainbow_dash .m { color: #5918BB; font-weight: bold }
.pygments-gallery .highlight-rainbow_dash .s { color: #0C6 }
.pygments-gallery .highlight-rainbow_dash .na { color: #2C5DCD; font-style: italic }
.pygments-gallery .highlight-rainbow_dash .nb { color: #5918BB; font-weight: bold }
.pygments-gallery .highlight-rainbow_dash .nc { text-decoration: underline }
.pygments-gallery .highlight-rainbow_dash .no { color: #318495 }
.pygments-gallery .highlight-rainbow_dash .nd { color: #FF8000; font-weight: bold }
.pygments-gallery .highlight-rainbow_dash .ni { color: #5918BB; font-weight: bold }
.pygments-gallery .highlight-rainbow_dash .ne { color: #5918BB; font-weight: bold }
.pygments-gallery .highlight-rainbow_dash .nf { color: #FF8000; font-weight: bold }
.pygments-gallery .highlight-rainbow_dash .nt { color: #2C5DCD; font-weight: bold }
.pygments-gallery .highlight-rainbow_dash .ow { color: #2C5DCD; font-weight: bold }
.pygments-gallery .highlight-rainbow_dash .w { color: #CBCBCB }
.pygments-gallery .highlight-rainbow_dash .mb { color: #5918BB; font-weight: bold }
.pygments-gallery .highlight-rainbow_dash .mf { color: #5918BB; font-weight: bold }
.pygments-gallery .highlight-rainbow_dash .mh { color: #5918BB; font-weight: bold }
.pygments-gallery .highlight-rainbow_dash .mi { color: #5918BB; font-weight: bold }
.pygments-gallery .highlight-rainbow_dash .mo { color: #5918BB; font-weight: bold }
.pygments-gallery .highlight-rainbow_dash .sa { color: #0C6 }
.pygments-gallery .highlight-rainbow_dash .sb { color: #0C6 }
.pygments-gallery .highlight-rainbow_dash .sc { color: #0C6 }
.pygments-gallery .highlight-rainbow_dash .dl { color: #0C6 }
.pygments-gallery .highlight-rainbow_dash .sd { color: #0C6; font-style: italic }
.pygments-gallery .highlight-rainbow_dash .s2 { color: #0C6 }
.pygments-gallery .highlight-rainbow_dash .se { color: #C5060B; font-weight: bold }
.pygments-gallery .highlight-rainbow_dash .sh { color: #0C6 }
.pygments-gallery .highlight-rainbow_dash .si { color: #0C6 }
.pygments-gallery .highlight-rainbow_dash .sx { color: #318495 }
.pygments-gallery .highlight-rainbow_dash .sr { color: #0C6 }
.pygments-gallery .highlight-rainbow_dash .s1 { color: #0C6 }
.pygments-gallery .highlight-rainbow_dash .ss { color: #C5060B; font-weight: bold }
.pygments-gallery .highlight-rainbow_dash .bp { color: #5918BB; font-weight: bold }
.pygments-gallery .highlight-rainbow_dash .fm { color: #FF8000; font-weight: bold }
.pygments-gallery .highlight-rainbow_dash .il { color: #5918BB; font-weight: bold }
.pygments-gallery .highlight-rrt .hll { background-color: #0000ff }
.pygments-gallery .highlight-rrt { background: #000000; color: #DDD }
.pygments-gallery .highlight-rrt .c { color: #0F0 }
.pygments-gallery .highlight-rrt .err { color: #DDD }
.pygments-gallery .highlight-rrt .esc { color: #DDD }
.pygments-gallery .highlight-rrt .g { color: #DDD }
.pygments-gallery .highlight-rrt .k { color: #F00 }
.pygments-gallery .highlight-rrt .l { color: #DDD }
.pygments-gallery .highlight-rrt .n { color: #DDD }
.pygments-gallery .highlight-rrt .o { color: #DDD }
.pygments-gallery .highlight-rrt .x { color: #DDD }
.pygments-gallery .highlight-rrt .p { color: #DDD }
.pygments-gallery .highlight-rrt .ch { color: #0F0 }
.pygments-gallery .highlight-rrt .cm { color: #0F0 }
.pygments-gallery .highlight-rrt .cp { color: #E5E5E5 }
.pygments-gallery .highlight-rrt .cpf { color: #0F0 }
.pygments-gallery .highlight-rrt .c1 { color: #0F0 }
.pygments-gallery .highlight-rrt .cs { color: #0F0 }
.pygments-gallery .highlight-rrt .gd { color: #DDD }
.pygments-gallery .highlight-rrt .ge { color: #FFF }
.pygments-gallery .highlight-rrt .ges { color: #DDD }
.pygments-gallery .highlight-rrt .gr { color: #DDD }
.pygments-gallery .highlight-rrt .gh { color: #FF0 }
.pygments-gallery .highlight-rrt .gi { color: #DDD }
.pygments-gallery .highlight-rrt .go { color: #DDD }
.pygments-gallery .highlight-rrt .gp { color: #DDD }
.pygments-gallery .highlight-rrt .gs { color: #FFF }
.pygments-gallery .highlight-rrt .gu { color: #FF0 }
.pygments-gallery .highlight-rrt .gt { color: #DDD }
.pygments-gallery .highlight-rrt .kc { color: #F00 }
.pygments-gallery .highlight-rrt .kd { color: #F00 }
.pygments-gallery .highlight-rrt .kn { color: #F00 }
.pygments-gallery .highlight-rrt .kp { color: #F00 }
.pygments-gallery .highlight-rrt .kr { color: #F00 }
.pygments-gallery .highlight-rrt .kt { color: #EE82EE }
.pygments-gallery .highlight-rrt .ld { color: #DDD }
.pygments-gallery .highlight-rrt .m { color: #F0F }
.pygments-gallery .highlight-rrt .s { color: #87CEEB }
.pygments-gallery .highlight-rrt .na { color: #DDD }
.pygments-gallery .highlight-rrt .nb { color: #DDD }
.pygments-gallery .highlight-rrt .nc { color: #DDD }
.pygments-gallery .highlight-rrt .no { color: #7FFFD4 }
.pygments-gallery .highlight-rrt .nd { color: #DDD }
.pygments-gallery .highlight-rrt .ni { color: #EEDD82 }
.pygments-gallery .highlight-rrt .ne { color: #DDD }
.pygments-gallery .highlight-rrt .nf { color: #FF0 }
.pygments-gallery .highlight-rrt .nl { color: #DDD }
.pygments-gallery .highlight-rrt .nn { color: #DDD }
.pygments-gallery .highlight-rrt .nx { color: #DDD }
.pygments-gallery .highlight-rrt .py { color: #DDD }
.pygments-gallery .highlight-rrt .nt { color: #7FFFD4 }
.pygments-gallery .highlight-rrt .nv { color: #EEDD82 }
.pygments-gallery .highlight-rrt .ow { color: #F00 }
.pygments-gallery .highlight-rrt .pm { color: #DDD }
.pygments-gallery .highlight-rrt .w { color: #DDD }
.pygments-gallery .highlight-rrt .mb { color: #F0F }
.pygments-gallery .highlight-rrt .mf { color: #F0F }
.pygments-gallery .highlight-rrt .mh { color: #F0F }
.pygments-gallery .highlight-rrt .mi { color: #F0F }
.pygments-gallery .highlight-rrt .mo { color: #F0F }
.pygments-gallery .highlight-rrt .sa { color: #87CEEB }
.pygments-gallery .highlight-rrt .sb { color: #87CEEB }
.pygments-gallery .highlight-rrt .sc { color: #87CEEB }
.pygments-gallery .highlight-rrt .dl { color: #87CEEB }
.pygments-gallery .highlight-rrt .sd { color: #87CEEB }
.pygments-gallery .highlight-rrt .s2 { color: #87CEEB }
.pygments-gallery .highlight-rrt .se { color: #87CEEB }
.pygments-gallery .highlight-rrt .sh { color: #87CEEB }
.pygments-gallery .highlight-rrt .si { color: #87CEEB }
.pygments-gallery .highlight-rrt .sx { color: #87CEEB }
.pygments-gallery .highlight-rrt .sr { color: #87CEEB }
.pygments-gallery .highlight-rrt .s1 { color: #87CEEB }
.pygments-gallery .highlight-rrt .ss { color: #87CEEB }
.pygments-gallery .highlight-rrt .bp { color: #DDD }
.pygments-gallery .highlight-rrt .fm { color: #FF0 }
.pygments-gallery .highlight-rrt .vc { color: #EEDD82 }
.pygments-gallery .highlight-rrt .vg { color: #EEDD82 }
.pygments-gallery .highlight-rrt .vi { color: #EEDD82 }
.pygments-gallery .highlight-rrt .vm { color: #EEDD82 }
.pygments-gallery .highlight-rrt .il { color: #F0F }
.pygments-gallery .highlight-sas .hll { background-color: #ffffcc }
.pygments-gallery .highlight-sas { background: #ffffff; }
.pygments-gallery .highlight-sas .c { color: #080; font-style: italic }
.pygments-gallery .highlight-sas .err { color: #A61717; background-color: #E3D2D2 }
.pygments-gallery .highlight-sas .g { color: #2C2CFF }
.pygments-gallery .highlight-sas .k { color: #2C2CFF }
.pygments-gallery .highlight-sas .x { background-color: #FFFFE0 }
.pygments-gallery .highlight-sas .ch { color: #080; font-style: italic }
.pygments-gallery .highlight-sas .cm { color: #080; font-style: italic }
.pygments-gallery .highlight-sas .cp { color: #080; font-style: italic }
.pygments-gallery .highlight-sas .cpf { color: #080; font-style: italic }
.pygments-gallery .highlight-sas .c1 { color: #080; font-style: italic }
.pygments-gallery .highlight-sas .cs { color: #080; font-style: italic }
.pygments-gallery .highlight-sas .gd { color: #2C2CFF }
.pygments-gallery .highlight-sas .ge { color: #080 }
.pygments-gallery .highlight-sas .ges { color: #2C2CFF }
.pygments-gallery .highlight-sas .gr { color: #D30202 }
.pygments-gallery .highlight-sas .gh { color: #2C2CFF }
.pygments-gallery .highlight-sas .gi { color: #2C2CFF }
.pygments-gallery .highlight-sas .go { color: #2C2CFF }
.pygments-gallery .highlight-sas .gp { color: #2C2CFF }
.pygments-gallery .highlight-sas .gs { color: #2C2CFF }
.pygments-gallery .highlight-sas .gu { color: #2C2CFF }
.pygments-gallery .highlight-sas .gt { color: #2C2CFF }
.pygments-gallery .highlight-sas .kc { color: #2C2CFF; font-weight: bold }
.pygments-gallery .highlight-sas .kd { color: #2C2CFF }
.pygments-gallery .highlight-sas .kn { color: #2C2CFF }
.pygments-gallery .highlight-sas .kp { color: #2C2CFF }
.pygments-gallery .highlight-sas .kr { color: #353580; font-weight: bold }
.pygments-gallery .highlight-sas .kt { color: #2C2CFF }
.pygments-gallery .highlight-sas .m { color: #2C8553; font-weight: bold }
.pygments-gallery .highlight-sas .s { color: #800080 }
.pygments-gallery .highlight-sas .nb { color: #2C2CFF }
.pygments-gallery .highlight-sas .nf { font-weight: bold; font-style: italic }
.pygments-gallery .highlight-sas .nv { color: #2C2CFF; font-weight: bold }
.pygments-gallery .highlight-sas .w { color: #BBB }
.pygments-gallery .highlight-sas .mb { color: #2C8553; font-weight: bold }
.pygments-gallery .highlight-sas .mf { color: #2C8553; font-weight: bold }
.pygments-gallery .highlight-sas .mh { color: #2C8553; font-weight: bold }
.pygments-gallery .highlight-sas .mi { color: #2C8553; font-weight: bold }
.pygments-gallery .highlight-sas .mo { color: #2C8553; font-weight: bold }
.pygments-gallery .highlight-sas .sa { color: #800080 }
.pygments-gallery .highlight-sas .sb { color: #800080 }
.pygments-gallery .highlight-sas .sc { color: #800080 }
.pygments-gallery .highlight-sas .dl { color: #800080 }
.pygments-gallery .highlight-sas .sd { color: #800080 }
.pygments-gallery .highlight-sas .s2 { color: #800080 }
.pygments-gallery .highlight-sas .se { color: #800080 }
.pygments-gallery .highlight-sas .sh { color: #800080 }
.pygments-gallery .highlight-sas .si { color: #800080 }
.pygments-gallery .highlight-sas .sx { color: #800080 }
.pygments-gallery .highlight-sas .sr { color: #800080 }
.pygments-gallery .highlight-sas .s1 { color: #800080 }
.pygments-gallery .highlight-sas .ss { color: #800080 }
.pygments-gallery .highlight-sas .bp { color: #2C2CFF }
.pygments-gallery .highlight-sas .fm { font-weight: bold; font-style: italic }
.pygments-gallery .highlight-sas .vc { color: #2C2CFF; font-weight: bold }
.pygments-gallery .highlight-sas .vg { color: #2C2CFF; font-weight: bold }
.pygments-gallery .highlight-sas .vi { color: #2C2CFF; font-weight: bold }
.pygments-gallery .highlight-sas .vm { color: #2C2CFF; font-weight: bold }
.pygments-gallery .highlight-sas .il { color: #2C8553; font-weight: bold }
.pygments-gallery .highlight-solarized-dark .hll { background-color: #073642 }
.pygments-gallery .highlight-solarized-dark { background: #002b36; color: #839496 }
.pygments-gallery .highlight-solarized-dark .c { color: #586E75; font-style: italic }
.pygments-gallery .highlight-solarized-dark .err { color: #839496; background-color: #DC322F }
.pygments-gallery .highlight-solarized-dark .esc { color: #839496 }
.pygments-gallery .highlight-solarized-dark .g { color: #839496 }
.pygments-gallery .highlight-solarized-dark .k { color: #859900 }
.pygments-gallery .highlight-solarized-dark .l { color: #839496 }
.pygments-gallery .highlight-solarized-dark .n { color: #839496 }
.pygments-gallery .highlight-solarized-dark .o { color: #586E75 }
.pygments-gallery .highlight-solarized-dark .x { color: #839496 }
.pygments-gallery .highlight-solarized-dark .p { color: #839496 }
.pygments-gallery .highlight-solarized-dark .ch { color: #586E75; font-style: italic }
.pygments-gallery .highlight-solarized-dark .cm { color: #586E75; font-style: italic }
.pygments-gallery .highlight-solarized-dark .cp { color: #D33682 }
.pygments-gallery .highlight-solarized-dark .cpf { color: #586E75 }
.pygments-gallery .highlight-solarized-dark .c1 { color: #586E75; font-style: italic }
.pygments-gallery .highlight-solarized-dark .cs { color: #586E75; font-style: italic }
.pygments-gallery .highlight-solarized-dark .gd { color: #DC322F }
.pygments-gallery .highlight-solarized-dark .ge { color: #839496; font-style: italic }
.pygments-gallery .highlight-solarized-dark .ges { color: #839496; font-weight: bold; font-style: italic }
.pygments-gallery .highlight-solarized-dark .gr { color: #DC322F }
.pygments-gallery .highlight-solarized-dark .gh { color: #839496; font-weight: bold }
.pygments-gallery .highlight-solarized-dark .gi { color: #859900 }
.pygments-gallery .highlight-solarized-dark .go { color: #839496 }
.pygments-gallery .highlight-solarized-dark .gp { color: #268BD2; font-weight: bold }
.pygments-gallery .highlight-solarized-dark .gs { color: #839496; font-weight: bold }
.pygments-gallery .highlight-solarized-dark .gu { color: #839496; text-decoration: underline }
.pygments-gallery .highlight-solarized-dark .gt { color: #268BD2 }
.pygments-gallery .highlight-solarized-dark .kc { color: #2AA198 }
.pygments-gallery .highlight-solarized-dark .kd { color: #2AA198 }
.pygments-gallery .highlight-solarized-dark .kn { color: #CB4B16 }
.pygments-gallery .highlight-solarized-dark .kp { color: #859900 }
.pygments-gallery .highlight-solarized-dark .kr { color: #859900 }
.pygments-gallery .highlight-solarized-dark .kt { color: #B58900 }
.pygments-gallery .highlight-solarized-dark .ld { color: #839496 }
.pygments-gallery .highlight-solarized-dark .m { color: #2AA198 }
.pygments-gallery .highlight-solarized-dark .s { color: #2AA198 }
.pygments-gallery .highlight-solarized-dark .na { color: #839496 }
.pygments-gallery .highlight-solarized-dark .nb { color: #268BD2 }
.pygments-gallery .highlight-solarized-dark .nc { color: #268BD2 }
.pygments-gallery .highlight-solarized-dark .no { color: #268BD2 }
.pygments-gallery .highlight-solarized-dark .nd { color: #268BD2 }
.pygments-gallery .highlight-solarized-dark .ni { color: #268BD2 }
.pygments-gallery .highlight-solarized-dark .ne { color: #268BD2 }
.pygments-gallery .highlight-solarized-dark .nf { color: #268BD2 }
.pygments-gallery .highlight-solarized-dark .nl { color: #268BD2 }
.pygments-gallery .highlight-solarized-dark .nn { color: #268BD2 }
.pygments-gallery .highlight-solarized-dark .nx { color: #839496 }
.pygments-gallery .highlight-solarized-dark .py { color: #839496 }
.pygments-gallery .highlight-solarized-dark .nt { color: #268BD2 }
.pygments-gallery .highlight-solarized-dark .nv { color: #268BD2 }
.pygments-gallery .highlight-solarized-dark .ow { color: #859900 }
.pygments-gallery .highlight-solarized-dark .pm { color: #839496 }
.pygments-gallery .highlight-solarized-dark .w { color: #839496 }
.pygments-gallery .highlight-solarized-dark .mb { color: #2AA198 }
.pygments-gallery .highlight-solarized-dark .mf { color: #2AA198 }
.pygments-gallery .highlight-solarized-dark .mh { color: #2AA198 }
.pygments-gallery .highlight-solarized-dark .mi { color: #2AA198 }
.pygments-gallery .highlight-solarized-dark .mo { color: #2AA198 }
.pygments-gallery .highlight-solarized-dark .sa { color: #2AA198 }
.pygments-gallery .highlight-solarized-dark .sb { color: #2AA198 }
.pygments-gallery .highlight-solarized-dark .sc { color: #2AA198 }
.pygments-gallery .highlight-solarized-dark .dl { color: #2AA198 }
.pygments-gallery .highlight-solarized-dark .sd { color: #586E75 }
.pygments-gallery .highlight-solarized-dark .s2 { color: #2AA198 }
.pygments-gallery .highlight-solarized-dark .se { color: #2AA198 }
.pygments-gallery .highlight-solarized-dark .sh { color: #2AA198 }
.pygments-gallery .highlight-solarized-dark .si { color: #2AA198 }
.pygments-gallery .highlight-solarized-dark .sx { color: #2AA198 }
.pygments-gallery .highlight-solarized-dark .sr { color: #CB4B16 }
.pygments-gallery .highlight-solarized-dark .s1 { color: #2AA198 }
.pygments-gallery .highlight-solarized-dark .ss { color: #2AA198 }
.pygments-gallery .highlight-solarized-dark .bp { color: #268BD2 }
.pygments-gallery .highlight-solarized-dark .fm { color: #268BD2 }
.pygments-gallery .highlight-solarized-dark .vc { color: #268BD2 }
.pygments-gallery .highlight-solarized-dark .vg { color: #268BD2 }
.pygments-gallery .highlight-solarized-dark .vi { color: #268BD2 }
.pygments-gallery .highlight-solarized-dark .vm { color: #268BD2 }
.pygments-gallery .highlight-solarized-dark .il { color: #2AA198 }
.pygments-gallery .highlight-solarized-light .hll { background-color: #eee8d5 }
.pygments-gallery .highlight-solarized-light { background: #fdf6e3; color: #657B83 }
.pygments-gallery .highlight-solarized-light .c { color: #93A1A1; font-style: italic }
.pygments-gallery .highlight-solarized-light .err { color: #657B83; background-color: #DC322F }
.pygments-gallery .highlight-solarized-light .esc { color: #657B83 }
.pygments-gallery .highlight-solarized-light .g { color: #657B83 }
.pygments-gallery .highlight-solarized-light .k { color: #859900 }
.pygments-gallery .highlight-solarized-light .l { color: #657B83 }
.pygments-gallery .highlight-solarized-light .n { color: #657B83 }
.pygments-gallery .highlight-solarized-light .o { color: #93A1A1 }
.pygments-gallery .highlight-solarized-light .x { color: #657B83 }
.pygments-gallery .highlight-solarized-light .p { color: #657B83 }
.pygments-gallery .highlight-solarized-light .ch { color: #93A1A1; font-style: italic }
.pygments-gallery .highlight-solarized-light .cm { color: #93A1A1; font-style: italic }
.pygments-gallery .highlight-solarized-light .cp { color: #D33682 }
.pygments-gallery .highlight-solarized-light .cpf { color: #93A1A1 }
.pygments-gallery .highlight-solarized-light .c1 { color: #93A1A1; font-style: italic }
.pygments-gallery .highlight-solarized-light .cs { color: #93A1A1; font-style: italic }
.pygments-gallery .highlight-solarized-light .gd { color: #DC322F }
.pygments-gallery .highlight-solarized-light .ge { color: #657B83; font-style: italic }
.pygments-gallery .highlight-solarized-light .ges { color: #657B83; font-weight: bold; font-style: italic }
.pygments-gallery .highlight-solarized-light .gr { color: #DC322F }
.pygments-gallery .highlight-solarized-light .gh { color: #657B83; font-weight: bold }
.pygments-gallery .highlight-solarized-light .gi { color: #859900 }
.pygments-gallery .highlight-solarized-light .go { color: #657B83 }
.pygments-gallery .highlight-solarized-light .gp { color: #268BD2; font-weight: bold }
.pygments-gallery .highlight-solarized-light .gs { color: #657B83; font-weight: bold }
.pygments-gallery .highlight-solarized-light .gu { color: #657B83; text-decoration: underline }
.pygments-gallery .highlight-solarized-light .gt { color: #268BD2 }
.pygments-gallery .highlight-solarized-light .kc { color: #2AA198 }
.pygments-gallery .highlight-solarized-light .kd { color: #2AA198 }
.pygments-gallery .highlight-solarized-light .kn { color: #CB4B16 }
.pygments-gallery .highlight-solarized-light .kp { color: #859900 }
.pygments-gallery .highlight-solarized-light .kr { color: #859900 }
.pygments-gallery .highlight-solarized-light .kt { color: #B58900 }
.pygments-gallery .highlight-solarized-light .ld { color: #657B83 }
.pygments-gallery .highlight-solarized-light .m { color: #2AA198 }
.pygments-gallery .highlight-solarized-light .s { color: #2AA198 }
.pygments-gallery .highlight-solarized-light .na { color: #657B83 }
.pygments-gallery .highlight-solarized-light .nb { color: #268BD2 }
.pygments-gallery .highlight-solarized-light .nc { color: #268BD2 }
.pygments-gallery .highlight-solarized-light .no { color: #268BD2 }
.pygments-gallery .highlight-solarized-light .nd { color: #268BD2 }
.pygments-gallery .highlight-solarized-light .ni { color: #268BD2 }
.pygments-gallery .highlight-solarized-light .ne { color: #268BD2 }
.pygments-gallery .highlight-solarized-light .nf { color: #268BD2 }
.pygments-gallery .highlight-solarized-light .nl { color: #268BD2 }
.pygments-gallery .highlight-solarized-light .nn { color: #268BD2 }
.pygments-gallery .highlight-solarized-light .nx { color: #657B83 }
.pygments-gallery .highlight-solarized-light .py { color: #657B83 }
.pygments-gallery .highlight-solarized-light .nt { color: #268BD2 }
.pygments-gallery .highlight-solarized-light .nv { color: #268BD2 }
.pygments-gallery .highlight-solarized-light .ow { color: #859900 }
.pygments-gallery .highlight-solarized-light .pm { color: #657B83 }
.pygments-gallery .highlight-solarized-light .w { color: #657B83 }
.pygments-gallery .highlight-solarized-light .mb { color: #2AA198 }
.pygments-gallery .highlight-solarized-light .mf { color: #2AA198 }
.pygments-gallery .highlight-solarized-light .mh { color: #2AA198 }
.pygments-gallery .highlight-solarized-light .mi { color: #2AA198 }
.pygments-gallery .highlight-solarized-light .mo { color: #2AA198 }
.pygments-gallery .highlight-solarized-light .sa { color: #2AA198 }
.pygments-gallery .highlight-solarized-light .sb { color: #2AA198 }
.pygments-gallery .highlight-solarized-light .sc { color: #2AA198 }
.pygments-gallery .highlight-solarized-light .dl { color: #2AA198 }
.pygments-gallery .highlight-solarized-light .sd { color: #93A1A1 }
.pygments-gallery .highlight-solarized-light .s2 { color: #2AA198 }
.pygments-gallery .highlight-solarized-light .se { color: #2AA198 }
.pygments-gallery .highlight-solarized-light .sh { color: #2AA198 }
.pygments-gallery .highlight-solarized-light .si { color: #2AA198 }
.pygments-gallery .highlight-solarized-light .sx { color: #2AA198 }
.pygments-gallery .highlight-solarized-light .sr { color: #CB4B16 }
.pygments-gallery .highlight-solarized-light .s1 { color: #2AA198 }
.pygments-gallery .highlight-solarized-light .ss { color: #2AA198 }
.pygments-gallery .highlight-solarized-light .bp { color: #268BD2 }
.pygments-gallery .highlight-solarized-light .fm { color: #268BD2 }
.pygments-gallery .highlight-solarized-light .vc { color: #268BD2 }
.pygments-gallery .highlight-solarized-light .vg { color: #268BD2 }
.pygments-gallery .highlight-solarized-light .vi { color: #268BD2 }
.pygments-gallery .highlight-solarized-light .vm { color: #268BD2 }
.pygments-gallery .highlight-solarized-light .il { color: #2AA198 }
.pygments-gallery .highlight-staroffice .hll { background-color: #ffffcc }
.pygments-gallery .highlight-staroffice { background: #ffffff; color: #000080 }
.pygments-gallery .highlight-staroffice .c { color: #696969 }
.pygments-gallery .highlight-staroffice .err { color: #800000 }
.pygments-gallery .highlight-staroffice .esc { color: #000080 }
.pygments-gallery .highlight-staroffice .g { color: #000080 }
.pygments-gallery .highlight-staroffice .k { color: #000080 }
.pygments-gallery .highlight-staroffice .l { color: #E00 }
.pygments-gallery .highlight-staroffice .n { color: #008000 }
.pygments-gallery .highlight-staroffice .o { color: #000080 }
.pygments-gallery .highlight-staroffice .x { color: #000080 }
.pygments-gallery .highlight-staroffice .p { color: #000080 }
.pygments-gallery .highlight-staroffice .ch { color: #696969 }
.pygments-gallery .highlight-staroffice .cm { color: #696969 }
.pygments-gallery .highlight-staroffice .cp { color: #696969 }
.pygments-gallery .highlight-staroffice .cpf { color: #696969 }
.pygments-gallery .highlight-staroffice .c1 { color: #696969 }
.pygments-gallery .highlight-staroffice .cs { color: #696969 }
.pygments-gallery .highlight-staroffice .gd { color: #000080 }
.pygments-gallery .highlight-staroffice .ge { color: #000080 }
.pygments-gallery .highlight-staroffice .ges { color: #000080 }
.pygments-gallery .highlight-staroffice .gr { color: #000080 }
.pygments-gallery .highlight-staroffice .gh { color: #000080 }
.pygments-gallery .highlight-staroffice .gi { color: #000080 }
.pygments-gallery .highlight-staroffice .go { color: #000080 }
.pygments-gallery .highlight-staroffice .gp { color: #000080 }
.pygments-gallery .highlight-staroffice .gs { color: #000080 }
.pygments-gallery .highlight-staroffice .gu { color: #000080 }
.pygments-gallery .highlight-staroffice .gt { color: #000080 }
.pygments-gallery .highlight-staroffice .kc { color: #000080 }
.pygments-gallery .highlight-staroffice .kd { color: #000080 }
.pygments-gallery .highlight-staroffice .kn { color: #000080 }
.pygments-gallery .highlight-staroffice .kp { color: #000080 }
.pygments-gallery .highlight-staroffice .kr { color: #000080 }
.pygments-gallery .highlight-staroffice .kt { color: #000080 }
.pygments-gallery .highlight-staroffice .ld { color: #E00 }
.pygments-gallery .highlight-staroffice .m { color: #E00 }
.pygments-gallery .highlight-staroffice .s { color: #E00 }
.pygments-gallery .highlight-staroffice .na { color: #008000 }
.pygments-gallery .highlight-staroffice .nb { color: #008000 }
.pygments-gallery .highlight-staroffice .nc { color: #008000 }
.pygments-gallery .highlight-staroffice .no { color: #008000 }
.pygments-gallery .highlight-staroffice .nd { color: #008000 }
.pygments-gallery .highlight-staroffice .ni { color: #008000 }
.pygments-gallery .highlight-staroffice .ne { color: #008000 }
.pygments-gallery .highlight-staroffice .nf { color: #008000 }
.pygments-gallery .highlight-staroffice .nl { color: #008000 }
.pygments-gallery .highlight-staroffice .nn { color: #008000 }
.pygments-gallery .highlight-staroffice .nx { color: #008000 }
.pygments-gallery .highlight-staroffice .py { color: #008000 }
.pygments-gallery .highlight-staroffice .nt { color: #008000 }
.pygments-gallery .highlight-staroffice .nv { color: #008000 }
.pygments-gallery .highlight-staroffice .ow { color: #000080 }
.pygments-gallery .highlight-staroffice .pm { color: #000080 }
.pygments-gallery .highlight-staroffice .w { color: #000080 }
.pygments-gallery .highlight-staroffice .mb { color: #E00 }
.pygments-gallery .highlight-staroffice .mf { color: #E00 }
.pygments-gallery .highlight-staroffice .mh { color: #E00 }
.pygments-gallery .highlight-staroffice .mi { color: #E00 }
.pygments-gallery .highlight-staroffice .mo { color: #E00 }
.pygments-gallery .highlight-staroffice .sa { color: #E00 }
.pygments-gallery .highlight-staroffice .sb { color: #E00 }
.pygments-gallery .highlight-staroffice .sc { color: #E00 }
.pygments-gallery .highlight-staroffice .dl { color: #E00 }
.pygments-gallery .highlight-staroffice .sd { color: #E00 }
.pygments-gallery .highlight-staroffice .s2 { color: #E00 }
.pygments-gallery .highlight-staroffice .se { color: #E00 }
.pygments-gallery .highlight-staroffice .sh { color: #E00 }
.pygments-gallery .highlight-staroffice .si { color: #E00 }
.pygments-gallery .highlight-staroffice .sx { color: #E00 }
.pygments-gallery .highlight-staroffice .sr { color: #E00 }
.pygments-gallery .highlight-staroffice .s1 { color: #E00 }
.pygments-gallery .highlight-staroffice .ss { color: #E00 }
.pygments-gallery .highlight-staroffice .bp { color: #008000 }
.pygments-gallery .highlight-staroffice .fm { color: #008000 }
.pygments-gallery .highlight-staroffice .vc { color: #008000 }
.pygments-gallery .highlight-staroffice .vg { color: #008000 }
.pygments-gallery .highlight-staroffice .vi { color: #008000 }
.pygments-gallery .highlight-staroffice .vm { color: #008000 }
.pygments-gallery .highlight-staroffice .il { color: #E00 }
.pygments-gallery .highlight-stata-dark .hll { background-color: #49483e }
.pygments-gallery .highlight-stata-dark { background: #232629; color: #CCC }
.pygments-gallery .highlight-stata-dark .c { color: #777; font-style: italic }
.pygments-gallery .highlight-stata-dark .err { color: #A61717; background-color: #E3D2D2 }
.pygments-gallery .highlight-stata-dark .esc { color: #CCC }
.pygments-gallery .highlight-stata-dark .g { color: #CCC }
.pygments-gallery .highlight-stata-dark .k { color: #7686BB; font-weight: bold }
.pygments-gallery .highlight-stata-dark .l { color: #CCC }
.pygments-gallery .highlight-stata-dark .n { color: #CCC }
.pygments-gallery .highlight-stata-dark .o { color: #CCC }
.pygments-gallery .highlight-stata-dark .x { color: #CCC }
.pygments-gallery .highlight-stata-dark .p { color: #CCC }
.pygments-gallery .highlight-stata-dark .ch { color: #777; font-style: italic }
.pygments-gallery .highlight-stata-dark .cm { color: #777; font-style: italic }
.pygments-gallery .highlight-stata-dark .cp { color: #777; font-style: italic }
.pygments-gallery .highlight-stata-dark .cpf { color: #777; font-style: italic }
.pygments-gallery .highlight-stata-dark .c1 { color: #777; font-style: italic }
.pygments-gallery .highlight-stata-dark .cs { color: #777; font-style: italic }
.pygments-gallery .highlight-stata-dark .gd { color: #CCC }
.pygments-gallery .highlight-stata-dark .ge { color: #CCC }
.pygments-gallery .highlight-stata-dark .ges { color: #CCC }
.pygments-gallery .highlight-stata-dark .gr { color: #CCC }
.pygments-gallery .highlight-stata-dark .gh { color: #CCC }
.pygments-gallery .highlight-stata-dark .gi { color: #CCC }
.pygments-gallery .highlight-stata-dark .go { color: #CCC }
.pygments-gallery .highlight-stata-dark .gp { color: #FFF }
.pygments-gallery .highlight-stata-dark .gs { color: #CCC }
.pygments-gallery .highlight-stata-dark .gu { color: #CCC }
.pygments-gallery .highlight-stata-dark .gt { color: #CCC }
.pygments-gallery .highlight-stata-dark .kc { color: #7686BB; font-weight: bold }
.pygments-gallery .highlight-stata-dark .kd { color: #7686BB; font-weight: bold }
.pygments-gallery .highlight-stata-dark .kn { color: #7686BB; font-weight: bold }
.pygments-gallery .highlight-stata-dark .kp { color: #7686BB; font-weight: bold }
.pygments-gallery .highlight-stata-dark .kr { color: #7686BB; font-weight: bold }
.pygments-gallery .highlight-stata-dark .kt { color: #7686BB; font-weight: bold }
.pygments-gallery .highlight-stata-dark .ld { color: #CCC }
.pygments-gallery .highlight-stata-dark .m { color: #4FB8CC }
.pygments-gallery .highlight-stata-dark .s { color: #51CC99 }
.pygments-gallery .highlight-stata-dark .na { color: #CCC }
.pygments-gallery .highlight-stata-dark .nb { color: #CCC }
.pygments-gallery .highlight-stata-dark .nc { color: #CCC }
.pygments-gallery .highlight-stata-dark .no { color: #CCC }
.pygments-gallery .highlight-stata-dark .nd { color: #CCC }
.pygments-gallery .highlight-stata-dark .ni { color: #CCC }
.pygments-gallery .highlight-stata-dark .ne { color: #CCC }
.pygments-gallery .highlight-stata-dark .nf { color: #6A6AFF }
.pygments-gallery .highlight-stata-dark .nl { color: #CCC }
.pygments-gallery .highlight-stata-dark .nn { color: #CCC }
.pygments-gallery .highlight-stata-dark .nx { color: #E2828E }
.pygments-gallery .highlight-stata-dark .py { color: #CCC }
.pygments-gallery .highlight-stata-dark .nt { color: #CCC }
.pygments-gallery .highlight-stata-dark .nv { color: #7AB4DB; font-weight: bold }
.pygments-gallery .highlight-stata-dark .ow { color: #CCC }
.pygments-gallery .highlight-stata-dark .pm { color: #CCC }
.pygments-gallery .highlight-stata-dark .w { color: #BBB }
.pygments-gallery .highlight-stata-dark .mb { color: #4FB8CC }
.pygments-gallery .highlight-stata-dark .mf { color: #4FB8CC }
.pygments-gallery .highlight-stata-dark .mh { color: #4FB8CC }
.pygments-gallery .highlight-stata-dark .mi { color: #4FB8CC }
.pygments-gallery .highlight-stata-dark .mo { color: #4FB8CC }
.pygments-gallery .highlight-stata-dark .sa { color: #51CC99 }
.pygments-gallery .highlight-stata-dark .sb { color: #51CC99 }
.pygments-gallery .highlight-stata-dark .sc { color: #51CC99 }
.pygments-gallery .highlight-stata-dark .dl { color: #51CC99 }
.pygments-gallery .highlight-stata-dark .sd { color: #51CC99 }
.pygments-gallery .highlight-stata-dark .s2 { color: #51CC99 }
.pygments-gallery .highlight-stata-dark .se { color: #51CC99 }
.pygments-gallery .highlight-stata-dark .sh { color: #51CC99 }
.pygments-gallery .highlight-stata-dark .si { color: #51CC99 }
.pygments-gallery .highlight-stata-dark .sx { color: #51CC99 }
.pygments-gallery .highlight-stata-dark .sr { color: #51CC99 }
.pygments-gallery .highlight-stata-dark .s1 { color: #51CC99 }
.pygments-gallery .highlight-stata-dark .ss { color: #51CC99 }
.pygments-gallery .highlight-stata-dark .bp { color: #CCC }
.pygments-gallery .highlight-stata-dark .fm { color: #6A6AFF }
.pygments-gallery .highlight-stata-dark .vc { color: #7AB4DB; font-weight: bold }
.pygments-gallery .highlight-stata-dark .vg { color: #BE646C; font-weight: bold }
.pygments-gallery .highlight-stata-dark .vi { color: #7AB4DB; font-weight: bold }
.pygments-gallery .highlight-stata-dark .vm { color: #7AB4DB; font-weight: bold }
.pygments-gallery .highlight-stata-dark .il { color: #4FB8CC }
.pygments-gallery .highlight-stata-light .hll { background-color: #ffffcc }
.pygments-gallery .highlight-stata-light { background: #ffffff; color: #111 }
.pygments-gallery .highlight-stata-light .c { color: #080; font-style: italic }
.pygments-gallery .highlight-stata-light .err { color: #A61717; background-color: #E3D2D2 }
.pygments-gallery .highlight-stata-light .k { color: #353580; font-weight: bold }
.pygments-gallery .highlight-stata-light .ch { color: #080; font-style: italic }
.pygments-gallery .highlight-stata-light .cm { color: #080; font-style: italic }
.pygments-gallery .highlight-stata-light .cp { color: #080; font-style: italic }
.pygments-gallery .highlight-stata-light .cpf { color: #080; font-style: italic }
.pygments-gallery .highlight-stata-light .c1 { color: #080; font-style: italic }
.pygments-gallery .highlight-stata-light .cs { color: #080; font-style: italic }
.pygments-gallery .highlight-stata-light .kc { color: #353580; font-weight: bold }
.pygments-gallery .highlight-stata-light .kd { color: #353580; font-weight: bold }
.pygments-gallery .highlight-stata-light .kn { color: #353580; font-weight: bold }
.pygments-gallery .highlight-stata-light .kp { color: #353580; font-weight: bold }
.pygments-gallery .highlight-stata-light .kr { color: #353580; font-weight: bold }
.pygments-gallery .highlight-stata-light .kt { color: #353580; font-weight: bold }
.pygments-gallery .highlight-stata-light .m { color: #2C2CFF }
.pygments-gallery .highlight-stata-light .s { color: #7A2424 }
.pygments-gallery .highlight-stata-light .nf { color: #2C2CFF }
.pygments-gallery .highlight-stata-light .nx { color: #BE646C }
.pygments-gallery .highlight-stata-light .nv { color: #35BABA; font-weight: bold }
.pygments-gallery .highlight-stata-light .w { color: #BBB }
.pygments-gallery .highlight-stata-light .mb { color: #2C2CFF }
.pygments-gallery .highlight-stata-light .mf { color: #2C2CFF }
.pygments-gallery .highlight-stata-light .mh { color: #2C2CFF }
.pygments-gallery .highlight-stata-light .mi { color: #2C2CFF }
.pygments-gallery .highlight-stata-light .mo { color: #2C2CFF }
.pygments-gallery .highlight-stata-light .sa { color: #7A2424 }
.pygments-gallery .highlight-stata-light .sb { color: #7A2424 }
.pygments-gallery .highlight-stata-light .sc { color: #7A2424 }
.pygments-gallery .highlight-stata-light .dl { color: #7A2424 }
.pygments-gallery .highlight-stata-light .sd { color: #7A2424 }
.pygments-gallery .highlight-stata-light .s2 { color: #7A2424 }
.pygments-gallery .highlight-stata-light .se { color: #7A2424 }
.pygments-gallery .highlight-stata-light .sh { color: #7A2424 }
.pygments-gallery .highlight-stata-light .si { color: #7A2424 }
.pygments-gallery .highlight-stata-light .sx { color: #7A2424 }
.pygments-gallery .highlight-stata-light .sr { color: #7A2424 }
.pygments-gallery .highlight-stata-light .s1 { color: #7A2424 }
.pygments-gallery .highlight-stata-light .ss { color: #7A2424 }
.pygments-gallery .highlight-stata-light .fm { color: #2C2CFF }
.pygments-gallery .highlight-stata-light .vc { color: #35BABA; font-weight: bold }
.pygments-gallery .highlight-stata-light .vg { color: #B5565E; font-weight: bold }
.pygments-gallery .highlight-stata-light .vi { color: #35BABA; font-weight: bold }
.pygments-gallery .highlight-stata-light .vm { color: #35BABA; font-weight: bold }
.pygments-gallery .highlight-stata-light .il { color: #2C2CFF }
.pygments-gallery .highlight-tango .hll { background-color: #ffffcc }
.pygments-gallery .highlight-tango { background: #f8f8f8; }
.pygments-gallery .highlight-tango .c { color: #8F5902; font-style: italic }
.pygments-gallery .highlight-tango .err { color: #A40000; border: 1px solid #EF2929 }
.pygments-gallery .highlight-tango .g { color: #000 }
.pygments-gallery .highlight-tango .k { color: #204A87; font-weight: bold }
.pygments-gallery .highlight-tango .l { color: #000 }
.pygments-gallery .highlight-tango .n { color: #000 }
.pygments-gallery .highlight-tango .o { color: #CE5C00; font-weight: bold }
.pygments-gallery .highlight-tango .x { color: #000 }
.pygments-gallery .highlight-tango .p { color: #000; font-weight: bold }
.pygments-gallery .highlight-tango .ch { color: #8F5902; font-style: italic }
.pygments-gallery .highlight-tango .cm { color: #8F5902; font-style: italic }
.pygments-gallery .highlight-tango .cp { color: #8F5902; font-style: italic }
.pygments-gallery .highlight-tango .cpf { color: #8F5902; font-style: italic }
.pygments-gallery .highlight-tango .c1 { color: #8F5902; font-style: italic }
.pygments-gallery .highlight-tango .cs { color: #8F5902; font-style: italic }
.pygments-gallery .highlight-tango .gd { color: #A40000 }
.pygments-gallery .highlight-tango .ge { color: #000; font-style: italic }
.pygments-gallery .highlight-tango .ges { color: #000; font-weight: bold; font-style: italic }
.pygments-gallery .highlight-tango .gr { color: #EF2929 }
.pygments-gallery .highlight-tango .gh { color: #000080; font-weight: bold }
.pygments-gallery .highlight-tango .gi { color: #00A000 }
.pygments-gallery .highlight-tango .go { color: #000; font-style: italic }
.pygments-gallery .highlight-tango .gp { color: #8F5902 }
.pygments-gallery .highlight-tango .gs { color: #000; font-weight: bold }
.pygments-gallery .highlight-tango .gu { color: #800080; font-weight: bold }
.pygments-gallery .highlight-tango .gt { color: #A40000; font-weight: bold }
.pygments-gallery .highlight-tango .kc { color: #204A87; font-weight: bold }
.pygments-gallery .highlight-tango .kd { color: #204A87; font-weight: bold }
.pygments-gallery .highlight-tango .kn { color: #204A87; font-weight: bold }
.pygments-gallery .highlight-tango .kp { color: #204A87; font-weight: bold }
.pygments-gallery .highlight-tango .kr { color: #204A87; font-weight: bold }
.pygments-gallery .highlight-tango .kt { color: #204A87; font-weight: bold }
.pygments-gallery .highlight-tango .ld { color: #000 }
.pygments-gallery .highlight-tango .m { color: #0000CF; font-weight: bold }
.pygments-gallery .highlight-tango .s { color: #4E9A06 }
.pygments-gallery .highlight-tango .na { color: #C4A000 }
.pygments-gallery .highlight-tango .nb { color: #204A87 }
.pygments-gallery .highlight-tango .nc { color: #000 }
.pygments-gallery .highlight-tango .no { color: #000 }
.pygments-gallery .highlight-tango .nd { color: #5C35CC; font-weight: bold }
.pygments-gallery .highlight-tango .ni { color: #CE5C00 }
.pygments-gallery .highlight-tango .ne { color: #C00; font-weight: bold }
.pygments-gallery .highlight-tango .nf { color: #000 }
.pygments-gallery .highlight-tango .nl { color: #F57900 }
.pygments-gallery .highlight-tango .nn { color: #000 }
.pygments-gallery .highlight-tango .nx { color: #000 }
.pygments-gallery .highlight-tango .py { color: #000 }
.pygments-gallery .highlight-tango .nt { color: #204A87; font-weight: bold }
.pygments-gallery .highlight-tango .nv { color: #000 }
.pygments-gallery .highlight-tango .ow { color: #204A87; font-weight: bold }
.pygments-gallery .highlight-tango .pm { color: #000; font-weight: bold }
.pygments-gallery .highlight-tango .w { color: #F8F8F8 }
.pygments-gallery .highlight-tango .mb { color: #0000CF; font-weight: bold }
.pygments-gallery .highlight-tango .mf { color: #0000CF; font-weight: bold }
.pygments-gallery .highlight-tango .mh { color: #0000CF; font-weight: bold }
.pygments-gallery .highlight-tango .mi { color: #0000CF; font-weight: bold }
.pygments-gallery .highlight-tango .mo { color: #0000CF; font-weight: bold }
.pygments-gallery .highlight-tango .sa { color: #4E9A06 }
.pygments-gallery .highlight-tango .sb { color: #4E9A06 }
.pygments-gallery .highlight-tango .sc { color: #4E9A06 }
.pygments-gallery .highlight-tango .dl { color: #4E9A06 }
.pygments-gallery .highlight-tango .sd { color: #8F5902; font-style: italic }
.pygments-gallery .highlight-tango .s2 { color: #4E9A06 }
.pygments-gallery .highlight-tango .se { color: #4E9A06 }
.pygments-gallery .highlight-tango .sh { color: #4E9A06 }
.pygments-gallery .highlight-tango .si { color: #4E9A06 }
.pygments-gallery .highlight-tango .sx { color: #4E9A06 }
.pygments-gallery .highlight-tango .sr { color: #4E9A06 }
.pygments-gallery .highlight-tango .s1 { color: #4E9A06 }
.pygments-gallery .highlight-tango .ss { color: #4E9A06 }
.pygments-gallery .highlight-tango .bp { color: #3465A4 }
.pygments-gallery .highlight-tango .fm { color: #000 }
.pygments-gallery .highlight-tango .vc { color: #000 }
.pygments-gallery .highlight-tango .vg { color: #000 }
.pygments-gallery .highlight-tango .vi { color: #000 }
.pygments-gallery .highlight-tango .vm { color: #000 }
.pygments-gallery .highlight-tango .il { color: #0000CF; font-weight: bold }
.pygments-gallery .highlight-trac .hll { background-color: #ffffcc }
.pygments-gallery .highlight-trac { background: #ffffff; }
.pygments-gallery .highlight-trac .c { color: #998; font-style: italic }
.pygments-gallery .highlight-trac .err { color: #A61717; background-color: #E3D2D2 }
.pygments-gallery .highlight-trac .k { font-weight: bold }
.pygments-gallery .highlight-trac .o { font-weight: bold }
.pygments-gallery .highlight-trac .ch { color: #998; font-style: italic }
.pygments-gallery .highlight-trac .cm { color: #998; font-style: italic }
.pygments-gallery .highlight-trac .cp { color: #999; font-weight: bold }
.pygments-gallery .highlight-trac .cpf { color: #998; font-style: italic }
.pygments-gallery .highlight-trac .c1 { color: #998; font-style: italic }
.pygments-gallery .highlight-trac .cs { color: #999; font-weight: bold; font-style: italic }
.pygments-gallery .highlight-trac .gd { color: #000; background-color: #FDD }
.pygments-gallery .highlight-trac .ge { font-style: italic }
.pygments-gallery .highlight-trac .ges { font-weight: bold; font-style: italic }
.pygments-gallery .highlight-trac .gr { color: #A00 }
.pygments-gallery .highlight-trac .gh { color: #999 }
.pygments-gallery .highlight-trac .gi { color: #000; background-color: #DFD }
.pygments-gallery .highlight-trac .go { color: #888 }
.pygments-gallery .highlight-trac .gp { color: #555 }
.pygments-gallery .highlight-trac .gs { font-weight: bold }
.pygments-gallery .highlight-trac .gu { color: #AAA }
.pygments-gallery .highlight-trac .gt { color: #A00 }
.pygments-gallery .highlight-trac .kc { font-weight: bold }
.pygments-gallery .highlight-trac .kd { font-weight: bold }
.pygments-gallery .highlight-trac .kn { font-weight: bold }
.pygments-gallery .highlight-trac .kp { font-weight: bold }
.pygments-gallery .highlight-trac .kr { font-weight: bold }
.pygments-gallery .highlight-trac .kt { color: #458; font-weight: bold }
.pygments-gallery .highlight-trac .m { color: #099 }
.pygments-gallery .highlight-trac .s { color: #B84 }
.pygments-gallery .highlight-trac .na { color: #008080 }
.pygments-gallery .highlight-trac .nb { color: #999 }
.pygments-gallery .highlight-trac .nc { color: #458; font-weight: bold }
.pygments-gallery .highlight-trac .no { color: #008080 }
.pygments-gallery .highlight-trac .ni { color: #800080 }
.pygments-gallery .highlight-trac .ne { color: #900; font-weight: bold }
.pygments-gallery .highlight-trac .nf { color: #900; font-weight: bold }
.pygments-gallery .highlight-trac .nn { color: #555 }
.pygments-gallery .highlight-trac .nt { color: #000080 }
.pygments-gallery .highlight-trac .nv { color: #008080 }
.pygments-gallery .highlight-trac .ow { font-weight: bold }
.pygments-gallery .highlight-trac .w { color: #BBB }
.pygments-gallery .highlight-trac .mb { color: #099 }
.pygments-gallery .highlight-trac .mf { color: #099 }
.pygments-gallery .highlight-trac .mh { color: #099 }
.pygments-gallery .highlight-trac .mi { color: #099 }
.pygments-gallery .highlight-trac .mo { color: #099 }
.pygments-gallery .highlight-trac .sa { color: #B84 }
.pygments-gallery .highlight-trac .sb { color: #B84 }
.pygments-gallery .highlight-trac .sc { color: #B84 }
.pygments-gallery .highlight-trac .dl { color: #B84 }
.pygments-gallery .highlight-trac .sd { color: #B84 }
.pygments-gallery .highlight-trac .s2 { color: #B84 }
.pygments-gallery .highlight-trac .se { color: #B84 }
.pygments-gallery .highlight-trac .sh { color: #B84 }
.pygments-gallery .highlight-trac .si { color: #B84 }
.pygments-gallery .highlight-trac .sx { color: #B84 }
.pygments-gallery .highlight-trac .sr { color: #808000 }
.pygments-gallery .highlight-trac .s1 { color: #B84 }
.pygments-gallery .highlight-trac .ss { color: #B84 }
.pygments-gallery .highlight-trac .bp { color: #999 }
.pygments-gallery .highlight-trac .fm { color: #900; font-weight: bold }
.pygments-gallery .highlight-trac .vc { color: #008080 }
.pygments-gallery .highlight-trac .vg { color: #008080 }
.pygments-gallery .highlight-trac .vi { color: #008080 }
.pygments-gallery .highlight-trac .vm { color: #008080 }
.pygments-gallery .highlight-trac .il { color: #099 }
.pygments-gallery .highlight-vim .hll { background-color: #222222 }
.pygments-gallery .highlight-vim { background: #000000; color: #CCC }
.pygments-gallery .highlight-vim .c { color: #000080 }
.pygments-gallery .highlight-vim .err { color: #CCC; border: 1px solid #F00 }
.pygments-gallery .highlight-vim .esc { color: #CCC }
.pygments-gallery .highlight-vim .g { color: #CCC }
.pygments-gallery .highlight-vim .k { color: #CDCD00 }
.pygments-gallery .highlight-vim .l { color: #CCC }
.pygments-gallery .highlight-vim .n { color: #CCC }
.pygments-gallery .highlight-vim .o { color: #39C }
.pygments-gallery .highlight-vim .x { color: #CCC }
.pygments-gallery .highlight-vim .p { color: #CCC }
.pygments-gallery .highlight-vim .ch { color: #000080 }
.pygments-gallery .highlight-vim .cm { color: #000080 }
.pygments-gallery .highlight-vim .cp { color: #000080 }
.pygments-gallery .highlight-vim .cpf { color: #000080 }
.pygments-gallery .highlight-vim .c1 { color: #000080 }
.pygments-gallery .highlight-vim .cs { color: #CD0000; font-weight: bold }
.pygments-gallery .highlight-vim .gd { color: #CD0000 }
.pygments-gallery .highlight-vim .ge { color: #CCC; font-style: italic }
.pygments-gallery .highlight-vim .ges { color: #CCC; font-weight: bold; font-style: italic }
.pygments-gallery .highlight-vim .gr { color: #F00 }
.pygments-gallery .highlight-vim .gh { color: #000080; font-weight: bold }
.pygments-gallery .highlight-vim .gi { color: #00CD00 }
.pygments-gallery .highlight-vim .go { color: #888 }
.pygments-gallery .highlight-vim .gp { color: #000080; font-weight: bold }
.pygments-gallery .highlight-vim .gs { color: #CCC; font-weight: bold }
.pygments-gallery .highlight-vim .gu { color: #800080; font-weight: bold }
.pygments-gallery .highlight-vim .gt { color: #04D }
.pygments-gallery .highlight-vim .kc { color: #CDCD00 }
.pygments-gallery .highlight-vim .kd { color: #00CD00 }
.pygments-gallery .highlight-vim .kn { color: #CD00CD }
.pygments-gallery .highlight-vim .kp { color: #CDCD00 }
.pygments-gallery .highlight-vim .kr { color: #CDCD00 }
.pygments-gallery .highlight-vim .kt { color: #00CD00 }
.pygments-gallery .highlight-vim .ld { color: #CCC }
.pygments-gallery .highlight-vim .m { color: #CD00CD }
.pygments-gallery .highlight-vim .s { color: #CD0000 }
.pygments-gallery .highlight-vim .na { color: #CCC }
.pygments-gallery .highlight-vim .nb { color: #CD00CD }
.pygments-gallery .highlight-vim .nc { color: #00CDCD }
.pygments-gallery .highlight-vim .no { color: #CCC }
.pygments-gallery .highlight-vim .nd { color: #CCC }
.pygments-gallery .highlight-vim .ni { color: #CCC }
.pygments-gallery .highlight-vim .ne { color: #669; font-weight: bold }
.pygments-gallery .highlight-vim .nf { color: #CCC }
.pygments-gallery .highlight-vim .nl { color: #CCC }
.pygments-gallery .highlight-vim .nn { color: #CCC }
.pygments-gallery .highlight-vim .nx { color: #CCC }
.pygments-gallery .highlight-vim .py { color: #CCC }
.pygments-gallery .highlight-vim .nt { color: #CCC }
.pygments-gallery .highlight-vim .nv { color: #00CDCD }
.pygments-gallery .highlight-vim .ow { color: #CDCD00 }
.pygments-gallery .highlight-vim .pm { color: #CCC }
.pygments-gallery .highlight-vim .w { color: #CCC }
.pygments-gallery .highlight-vim .mb { color: #CD00CD }
.pygments-gallery .highlight-vim .mf { color: #CD00CD }
.pygments-gallery .highlight-vim .mh { color: #CD00CD }
.pygments-gallery .highlight-vim .mi { color: #CD00CD }
.pygments-gallery .highlight-vim .mo { color: #CD00CD }
.pygments-gallery .highlight-vim .sa { color: #CD0000 }
.pygments-gallery .highlight-vim .sb { color: #CD0000 }
.pygments-gallery .highlight-vim .sc { color: #CD0000 }
.pygments-gallery .highlight-vim .dl { color: #CD0000 }
.pygments-gallery .highlight-vim .sd { color: #CD0000 }
.pygments-gallery .highlight-vim .s2 { color: #CD0000 }
.pygments-gallery .highlight-vim .se { color: #CD0000 }
.pygments-gallery .highlight-vim .sh { color: #CD0000 }
.pygments-gallery .highlight-vim .si { color: #CD0000 }
.pygments-gallery .highlight-vim .sx { color: #CD0000 }
.pygments-gallery .highlight-vim .sr { color: #CD0000 }
.pygments-gallery .highlight-vim .s1 { color: #CD0000 }
.pygments-gallery .highlight-vim .ss { color: #CD0000 }
.pygments-gallery .highlight-vim .bp { color: #CD00CD }
.pygments-gallery .highlight-vim .fm { color: #CCC }
.pygments-gallery .highlight-vim .vc { color: #00CDCD }
.pygments-gallery .highlight-vim .vg { color: #00CDCD }
.pygments-gallery .highlight-vim .vi { color: #00CDCD }
.pygments-gallery .highlight-vim .vm { color: #00CDCD }
.pygments-gallery .highlight-vim .il { color: #CD00CD }
.pygments-gallery .highlight-vs .hll { background-color: #ffffcc }
.pygments-gallery .highlight-vs { background: #ffffff; }
.pygments-gallery .highlight-vs .c { color: #008000 }
.pygments-gallery .highlight-vs .err { border: 1px solid #F00 }
.pygments-gallery .highlight-vs .k { color: #00F }
.pygments-gallery .highlight-vs .ch { color: #008000 }
.pygments-gallery .highlight-vs .cm { color: #008000 }
.pygments-gallery .highlight-vs .cp { color: #00F }
.pygments-gallery .highlight-vs .cpf { color: #008000 }
.pygments-gallery .highlight-vs .c1 { color: #008000 }
.pygments-gallery .highlight-vs .cs { color: #008000 }
.pygments-gallery .highlight-vs .ge { font-style: italic }
.pygments-gallery .highlight-vs .ges { font-weight: bold; font-style: italic }
.pygments-gallery .highlight-vs .gh { font-weight: bold }
.pygments-gallery .highlight-vs .gp { font-weight: bold }
.pygments-gallery .highlight-vs .gs { font-weight: bold }
.pygments-gallery .highlight-vs .gu { font-weight: bold }
.pygments-gallery .highlight-vs .kc { color: #00F }
.pygments-gallery .highlight-vs .kd { color: #00F }
.pygments-gallery .highlight-vs .kn { color: #00F }
.pygments-gallery .highlight-vs .kp { color: #00F }
.pygments-gallery .highlight-vs .kr { color: #00F }
.pygments-gallery .highlight-vs .kt { color: #2B91AF }
.pygments-gallery .highlight-vs .s { color: #A31515 }
.pygments-gallery .highlight-vs .nc { color: #2B91AF }
.pygments-gallery .highlight-vs .ow { color: #00F }
.pygments-gallery .highlight-vs .sa { color: #A31515 }
.pygments-gallery .highlight-vs .sb { color: #A31515 }
.pygments-gallery .highlight-vs .sc { color: #A31515 }
.pygments-gallery .highlight-vs .dl { color: #A31515 }
.pygments-gallery .highlight-vs .sd { color: #A31515 }
.pygments-gallery .highlight-vs .s2 { color: #A31515 }
.pygments-gallery .highlight-vs .se { color: #A31515 }
.pygments-gallery .highlight-vs .sh { color: #A31515 }
.pygments-gallery .highlight-vs .si { color: #A31515 }
.pygments-gallery .highlight-vs .sx { color: #A31515 }
.pygments-gallery .highlight-vs .sr { color: #A31515 }
.pygments-gallery .highlight-vs .s1 { color: #A31515 }
.pygments-gallery .highlight-vs .ss { color: #A31515 }
.pygments-gallery .highlight-xcode .hll { background-color: #ffffcc }
.pygments-gallery .highlight-xcode { background: #ffffff; }
.pygments-gallery .highlight-xcode .c { color: #177500 }
.pygments-gallery .highlight-xcode .err { color: #000 }
.pygments-gallery .highlight-xcode .k { color: #A90D91 }
.pygments-gallery .highlight-xcode .l { color: #1C01CE }
.pygments-gallery .highlight-xcode .n { color: #000 }
.pygments-gallery .highlight-xcode .o { color: #000 }
.pygments-gallery .highlight-xcode .ch { color: #177500 }
.pygments-gallery .highlight-xcode .cm { color: #177500 }
.pygments-gallery .highlight-xcode .cp { color: #633820 }
.pygments-gallery .highlight-xcode .cpf { color: #177500 }
.pygments-gallery .highlight-xcode .c1 { color: #177500 }
.pygments-gallery .highlight-xcode .cs { color: #177500 }
.pygments-gallery .highlight-xcode .kc { color: #A90D91 }
.pygments-gallery .highlight-xcode .kd { color: #A90D91 }
.pygments-gallery .highlight-xcode .kn { color: #A90D91 }
.pygments-gallery .highlight-xcode .kp { color: #A90D91 }
.pygments-gallery .highlight-xcode .kr { color: #A90D91 }
.pygments-gallery .highlight-xcode .kt { color: #A90D91 }
.pygments-gallery .highlight-xcode .ld { color: #1C01CE }
.pygments-gallery .highlight-xcode .m { color: #1C01CE }
.pygments-gallery .highlight-xcode .s { color: #C41A16 }
.pygments-gallery .highlight-xcode .na { color: #836C28 }
.pygments-gallery .highlight-xcode .nb { color: #A90D91 }
.pygments-gallery .highlight-xcode .nc { color: #3F6E75 }
.pygments-gallery .highlight-xcode .no { color: #000 }
.pygments-gallery .highlight-xcode .nd { color: #000 }
.pygments-gallery .highlight-xcode .ni { color: #000 }
.pygments-gallery .highlight-xcode .ne { color: #000 }
.pygments-gallery .highlight-xcode .nf { color: #000 }
.pygments-gallery .highlight-xcode .nl { color: #000 }
.pygments-gallery .highlight-xcode .nn { color: #000 }
.pygments-gallery .highlight-xcode .nx { color: #000 }
.pygments-gallery .highlight-xcode .py { color: #000 }
.pygments-gallery .highlight-xcode .nt { color: #000 }
.pygments-gallery .highlight-xcode .nv { color: #000 }
.pygments-gallery .highlight-xcode .ow { color: #000 }
.pygments-gallery .highlight-xcode .mb { color: #1C01CE }
.pygments-gallery .highlight-xcode .mf { color: #1C01CE }
.pygments-gallery .highlight-xcode .mh { color: #1C01CE }
.pygments-gallery .highlight-xcode .mi { color: #1C01CE }
.pygments-gallery .highlight-xcode .mo { color: #1C01CE }
.pygments-gallery .highlight-xcode .sa { color: #C41A16 }
.pygments-gallery .highlight-xcode .sb { color: #C41A16 }
.pygments-gallery .highlight-xcode .sc { color: #2300CE }
.pygments-gallery .highlight-xcode .dl { color: #C41A16 }
.pygments-gallery .highlight-xcode .sd { color: #C41A16 }
.pygments-gallery .highlight-xcode .s2 { color: #C41A16 }
.pygments-gallery .highlight-xcode .se { color: #C41A16 }
.pygments-gallery .highlight-xcode .sh { color: #C41A16 }
.pygments-gallery .highlight-xcode .si { color: #C41A16 }
.pygments-gallery .highlight-xcode .sx { color: #C41A16 }
.pygments-gallery .highlight-xcode .sr { color: #C41A16 }
.pygments-gallery .highlight-xcode .s1 { color: #C41A16 }
.pygments-gallery .highlight-xcode .ss { color: #C41A16 }
.pygments-gallery .highlight-xcode .bp { color: #5B269A }
.pygments-gallery .highlight-xcode .fm { color: #000 }
.pygments-gallery .highlight-xcode .vc { color: #000 }
.pygments-gallery .highlight-xcode .vg { color: #000 }
.pygments-gallery .highlight-xcode .vi { color: #000 }
.pygments-gallery .highlight-xcode .vm { color: #000 }
.pygments-gallery .highlight-xcode .il { color: #1C01CE }
.pygments-gallery .highlight-zenburn .hll { background-color: #484848 }
.pygments-gallery .highlight-zenburn { background: #3f3f3f; color: #DCDCCC }
.pygments-gallery .highlight-zenburn .c { color: #7F9F7F; font-style: italic }
.pygments-gallery .highlight-zenburn .err { color: #E37170; font-weight: bold }
.pygments-gallery .highlight-zenburn .esc { color: #DCDCCC }
.pygments-gallery .highlight-zenburn .g { color: #ECBCBC; font-weight: bold }
.pygments-gallery .highlight-zenburn .k { color: #EFDCBC }
.pygments-gallery .highlight-zenburn .l { color: #9FAFAF }
.pygments-gallery .highlight-zenburn .n { color: #DCDCCC }
.pygments-gallery .highlight-zenburn .o { color: #F0EFD0 }
.pygments-gallery .highlight-zenburn .x { color: #DCDCCC }
.pygments-gallery .highlight-zenburn .p { color: #F0EFD0 }
.pygments-gallery .highlight-zenburn .ch { color: #7F9F7F; font-style: italic }
.pygments-gallery .highlight-zenburn .cm { color: #7F9F7F; font-style: italic }
.pygments-gallery .highlight-zenburn .cp { color: #DFAF8F; font-weight: bold; font-style: italic }
.pygments-gallery .highlight-zenburn .cpf { color: #CC9393; font-style: italic }
.pygments-gallery .highlight-zenburn .c1 { color: #7F9F7F; font-style: italic }
.pygments-gallery .highlight-zenburn .cs { color: #DFDFDF; font-weight: bold; font-style: italic }
.pygments-gallery .highlight-zenburn .gd { color: #C3BF9F; font-weight: bold; background-color: #313C36 }
.pygments-gallery .highlight-zenburn .ge { color: #FFF; font-weight: bold }
.pygments-gallery .highlight-zenburn .ges { color: #ECBCBC; font-weight: bold }
.pygments-gallery .highlight-zenburn .gr { color: #ECBCBC; font-weight: bold }
.pygments-gallery .highlight-zenburn .gh { color: #EFEFEF; font-weight: bold }
.pygments-gallery .highlight-zenburn .gi { color: #709080; font-weight: bold; background-color: #313C36 }
.pygments-gallery .highlight-zenburn .go { color: #5B605E; font-weight: bold }
.pygments-gallery .highlight-zenburn .gp { color: #ECBCBC; font-weight: bold }
.pygments-gallery .highlight-zenburn .gs { color: #ECBCBC; font-weight: bold }
.pygments-gallery .highlight-zenburn .gu { color: #EFEFEF; font-weight: bold }
.pygments-gallery .highlight-zenburn .gt { color: #80D4AA; font-weight: bold; background-color: #2F2F2F }
.pygments-gallery .highlight-zenburn .kc { color: #DCA3A3 }
.pygments-gallery .highlight-zenburn .kd { color: #F0DFAF }
.pygments-gallery .highlight-zenburn .kn { color: #F0DFAF }
.pygments-gallery .highlight-zenburn .kp { color: #EFDCBC }
.pygments-gallery .highlight-zenburn .kr { color: #EFDCBC }
.pygments-gallery .highlight-zenburn .kt { color: #DFDFBF; font-weight: bold }
.pygments-gallery .highlight-zenburn .ld { color: #9FAFAF }
.pygments-gallery .highlight-zenburn .m { color: #8CD0D3 }
.pygments-gallery .highlight-zenburn .s { color: #CC9393 }
.pygments-gallery .highlight-zenburn .na { color: #EFEF8F }
.pygments-gallery .highlight-zenburn .nb { color: #EFEF8F }
.pygments-gallery .highlight-zenburn .nc { color: #EFEF8F }
.pygments-gallery .highlight-zenburn .no { color: #DCA3A3 }
.pygments-gallery .highlight-zenburn .nd { color: #DCDCCC }
.pygments-gallery .highlight-zenburn .ni { color: #CFBFAF }
.pygments-gallery .highlight-zenburn .ne { color: #C3BF9F; font-weight: bold }
.pygments-gallery .highlight-zenburn .nf { color: #EFEF8F }
.pygments-gallery .highlight-zenburn .nl { color: #DCDCCC }
.pygments-gallery .highlight-zenburn .nn { color: #DCDCCC }
.pygments-gallery .highlight-zenburn .nx { color: #DCDCCC }
.pygments-gallery .highlight-zenburn .py { color: #DCDCCC }
.pygments-gallery .highlight-zenburn .nt { color: #E89393; font-weight: bold }
.pygments-gallery .highlight-zenburn .nv { color: #DCDCCC }
.pygments-gallery .highlight-zenburn .ow { color: #F0EFD0 }
.pygments-gallery .highlight-zenburn .pm { color: #F0EFD0 }
.pygments-gallery .highlight-zenburn .w { color: #DCDCCC }
.pygments-gallery .highlight-zenburn .mb { color: #8CD0D3 }
.pygments-gallery .highlight-zenburn .mf { color: #C0BED1 }
.pygments-gallery .highlight-zenburn .mh { color: #8CD0D3 }
.pygments-gallery .highlight-zenburn .mi { color: #8CD0D3 }
.pygments-gallery .highlight-zenburn .mo { color: #8CD0D3 }
.pygments-gallery .highlight-zenburn .sa { color: #CC9393 }
.pygments-gallery .highlight-zenburn .sb { color: #CC9393 }
.pygments-gallery .highlight-zenburn .sc { color: #CC9393 }
.pygments-gallery .highlight-zenburn .dl { color: #CC9393 }
.pygments-gallery .highlight-zenburn .sd { color: #7F9F7F }
.pygments-gallery .highlight-zenburn .s2 { color: #CC9393 }
.pygments-gallery .highlight-zenburn .se { color: #CC9393 }
.pygments-gallery .highlight-zenburn .sh { color: #CC9393 }
.pygments-gallery .highlight-zenburn .si { color: #DCA3A3; font-weight: bold }
.pygments-gallery .highlight-zenburn .sx { color: #CC9393 }
.pygments-gallery .highlight-zenburn .sr { color: #CC9393 }
.pygments-gallery .highlight-zenburn .s1 { color: #CC9393 }
.pygments-gallery .highlight-zenburn .ss { color: #CC9393 }
.pygments-gallery .highlight-zenburn .bp { color: #DCDCCC }
.pygments-gallery .highlight-zenburn .fm { color: #EFEF8F }
.pygments-gallery .highlight-zenburn .vc { color: #DCDCCC }
.pygments-gallery .highlight-zenburn .vg { color: #DCDCCC }
.pygments-gallery .highlight-zenburn .vi { color: #DCDCCC }
.pygments-gallery .highlight-zenburn .vm { color: #DCDCCC }
.pygments-gallery .highlight-zenburn .il { color: #8CD0D3 }

</style>

<!-- Jekyll include: content from pygments-styles.html, adapted for inline embedding -->
<div class="pygments-gallery">
<div class="page-header">
        <h1>Pygments Styles</h1>
        <p>All installed styles · Pygments 2.21.0</p>
    </div>


    <div class="example">
        <div class="example-header">a11y-dark</div>
        <div class="code">
            <div class="highlight-a11y-dark"><pre><span></span><span class="kn">from</span><span class="w"> </span><span class="nn">dataclasses</span><span class="w"> </span><span class="kn">import</span> <span class="n">dataclass</span>


<span class="nd">@dataclass</span>
<span class="k">class</span><span class="w"> </span><span class="nc">User</span><span class="p">:</span>
    <span class="n">name</span><span class="p">:</span> <span class="nb">str</span>
    <span class="n">active</span><span class="p">:</span> <span class="nb">bool</span> <span class="o">=</span> <span class="kc">True</span>

    <span class="k">def</span><span class="w"> </span><span class="nf">greet</span><span class="p">(</span><span class="bp">self</span><span class="p">)</span> <span class="o">-&gt;</span> <span class="nb">str</span><span class="p">:</span>
        <span class="k">return</span> <span class="sa">f</span><span class="s2">"Hello, </span><span class="si">{</span><span class="bp">self</span><span class="o">.</span><span class="n">name</span><span class="si">}</span><span class="s2">!"</span>
</pre></div>

        </div>
    </div>


    <div class="example">
        <div class="example-header">a11y-high-contrast-dark</div>
        <div class="code">
            <div class="highlight-a11y-high-contrast-dark"><pre><span></span><span class="kn">from</span><span class="w"> </span><span class="nn">dataclasses</span><span class="w"> </span><span class="kn">import</span> <span class="n">dataclass</span>


<span class="nd">@dataclass</span>
<span class="k">class</span><span class="w"> </span><span class="nc">User</span><span class="p">:</span>
    <span class="n">name</span><span class="p">:</span> <span class="nb">str</span>
    <span class="n">active</span><span class="p">:</span> <span class="nb">bool</span> <span class="o">=</span> <span class="kc">True</span>

    <span class="k">def</span><span class="w"> </span><span class="nf">greet</span><span class="p">(</span><span class="bp">self</span><span class="p">)</span> <span class="o">-&gt;</span> <span class="nb">str</span><span class="p">:</span>
        <span class="k">return</span> <span class="sa">f</span><span class="s2">"Hello, </span><span class="si">{</span><span class="bp">self</span><span class="o">.</span><span class="n">name</span><span class="si">}</span><span class="s2">!"</span>
</pre></div>

        </div>
    </div>


    <div class="example">
        <div class="example-header">a11y-high-contrast-light</div>
        <div class="code">
            <div class="highlight-a11y-high-contrast-light"><pre><span></span><span class="kn">from</span><span class="w"> </span><span class="nn">dataclasses</span><span class="w"> </span><span class="kn">import</span> <span class="n">dataclass</span>


<span class="nd">@dataclass</span>
<span class="k">class</span><span class="w"> </span><span class="nc">User</span><span class="p">:</span>
    <span class="n">name</span><span class="p">:</span> <span class="nb">str</span>
    <span class="n">active</span><span class="p">:</span> <span class="nb">bool</span> <span class="o">=</span> <span class="kc">True</span>

    <span class="k">def</span><span class="w"> </span><span class="nf">greet</span><span class="p">(</span><span class="bp">self</span><span class="p">)</span> <span class="o">-&gt;</span> <span class="nb">str</span><span class="p">:</span>
        <span class="k">return</span> <span class="sa">f</span><span class="s2">"Hello, </span><span class="si">{</span><span class="bp">self</span><span class="o">.</span><span class="n">name</span><span class="si">}</span><span class="s2">!"</span>
</pre></div>

        </div>
    </div>


    <div class="example">
        <div class="example-header">a11y-light</div>
        <div class="code">
            <div class="highlight-a11y-light"><pre><span></span><span class="kn">from</span><span class="w"> </span><span class="nn">dataclasses</span><span class="w"> </span><span class="kn">import</span> <span class="n">dataclass</span>


<span class="nd">@dataclass</span>
<span class="k">class</span><span class="w"> </span><span class="nc">User</span><span class="p">:</span>
    <span class="n">name</span><span class="p">:</span> <span class="nb">str</span>
    <span class="n">active</span><span class="p">:</span> <span class="nb">bool</span> <span class="o">=</span> <span class="kc">True</span>

    <span class="k">def</span><span class="w"> </span><span class="nf">greet</span><span class="p">(</span><span class="bp">self</span><span class="p">)</span> <span class="o">-&gt;</span> <span class="nb">str</span><span class="p">:</span>
        <span class="k">return</span> <span class="sa">f</span><span class="s2">"Hello, </span><span class="si">{</span><span class="bp">self</span><span class="o">.</span><span class="n">name</span><span class="si">}</span><span class="s2">!"</span>
</pre></div>

        </div>
    </div>


    <div class="example">
        <div class="example-header">abap</div>
        <div class="code">
            <div class="highlight-abap"><pre><span></span><span class="kn">from</span><span class="w"> </span><span class="nn">dataclasses</span><span class="w"> </span><span class="kn">import</span> <span class="n">dataclass</span>


<span class="nd">@dataclass</span>
<span class="k">class</span><span class="w"> </span><span class="nc">User</span><span class="p">:</span>
    <span class="n">name</span><span class="p">:</span> <span class="nb">str</span>
    <span class="n">active</span><span class="p">:</span> <span class="nb">bool</span> <span class="o">=</span> <span class="kc">True</span>

    <span class="k">def</span><span class="w"> </span><span class="nf">greet</span><span class="p">(</span><span class="bp">self</span><span class="p">)</span> <span class="o">-&gt;</span> <span class="nb">str</span><span class="p">:</span>
        <span class="k">return</span> <span class="sa">f</span><span class="s2">"Hello, </span><span class="si">{</span><span class="bp">self</span><span class="o">.</span><span class="n">name</span><span class="si">}</span><span class="s2">!"</span>
</pre></div>

        </div>
    </div>


    <div class="example">
        <div class="example-header">algol</div>
        <div class="code">
            <div class="highlight-algol"><pre><span></span><span class="kn">from</span><span class="w"> </span><span class="nn">dataclasses</span><span class="w"> </span><span class="kn">import</span> <span class="n">dataclass</span>


<span class="nd">@dataclass</span>
<span class="k">class</span><span class="w"> </span><span class="nc">User</span><span class="p">:</span>
    <span class="n">name</span><span class="p">:</span> <span class="nb">str</span>
    <span class="n">active</span><span class="p">:</span> <span class="nb">bool</span> <span class="o">=</span> <span class="kc">True</span>

    <span class="k">def</span><span class="w"> </span><span class="nf">greet</span><span class="p">(</span><span class="bp">self</span><span class="p">)</span> <span class="o">-&gt;</span> <span class="nb">str</span><span class="p">:</span>
        <span class="k">return</span> <span class="sa">f</span><span class="s2">"Hello, </span><span class="si">{</span><span class="bp">self</span><span class="o">.</span><span class="n">name</span><span class="si">}</span><span class="s2">!"</span>
</pre></div>

        </div>
    </div>


    <div class="example">
        <div class="example-header">algol_nu</div>
        <div class="code">
            <div class="highlight-algol_nu"><pre><span></span><span class="kn">from</span><span class="w"> </span><span class="nn">dataclasses</span><span class="w"> </span><span class="kn">import</span> <span class="n">dataclass</span>


<span class="nd">@dataclass</span>
<span class="k">class</span><span class="w"> </span><span class="nc">User</span><span class="p">:</span>
    <span class="n">name</span><span class="p">:</span> <span class="nb">str</span>
    <span class="n">active</span><span class="p">:</span> <span class="nb">bool</span> <span class="o">=</span> <span class="kc">True</span>

    <span class="k">def</span><span class="w"> </span><span class="nf">greet</span><span class="p">(</span><span class="bp">self</span><span class="p">)</span> <span class="o">-&gt;</span> <span class="nb">str</span><span class="p">:</span>
        <span class="k">return</span> <span class="sa">f</span><span class="s2">"Hello, </span><span class="si">{</span><span class="bp">self</span><span class="o">.</span><span class="n">name</span><span class="si">}</span><span class="s2">!"</span>
</pre></div>

        </div>
    </div>


    <div class="example">
        <div class="example-header">arduino</div>
        <div class="code">
            <div class="highlight-arduino"><pre><span></span><span class="kn">from</span><span class="w"> </span><span class="nn">dataclasses</span><span class="w"> </span><span class="kn">import</span> <span class="n">dataclass</span>


<span class="nd">@dataclass</span>
<span class="k">class</span><span class="w"> </span><span class="nc">User</span><span class="p">:</span>
    <span class="n">name</span><span class="p">:</span> <span class="nb">str</span>
    <span class="n">active</span><span class="p">:</span> <span class="nb">bool</span> <span class="o">=</span> <span class="kc">True</span>

    <span class="k">def</span><span class="w"> </span><span class="nf">greet</span><span class="p">(</span><span class="bp">self</span><span class="p">)</span> <span class="o">-&gt;</span> <span class="nb">str</span><span class="p">:</span>
        <span class="k">return</span> <span class="sa">f</span><span class="s2">"Hello, </span><span class="si">{</span><span class="bp">self</span><span class="o">.</span><span class="n">name</span><span class="si">}</span><span class="s2">!"</span>
</pre></div>

        </div>
    </div>


    <div class="example">
        <div class="example-header">autumn</div>
        <div class="code">
            <div class="highlight-autumn"><pre><span></span><span class="kn">from</span><span class="w"> </span><span class="nn">dataclasses</span><span class="w"> </span><span class="kn">import</span> <span class="n">dataclass</span>


<span class="nd">@dataclass</span>
<span class="k">class</span><span class="w"> </span><span class="nc">User</span><span class="p">:</span>
    <span class="n">name</span><span class="p">:</span> <span class="nb">str</span>
    <span class="n">active</span><span class="p">:</span> <span class="nb">bool</span> <span class="o">=</span> <span class="kc">True</span>

    <span class="k">def</span><span class="w"> </span><span class="nf">greet</span><span class="p">(</span><span class="bp">self</span><span class="p">)</span> <span class="o">-&gt;</span> <span class="nb">str</span><span class="p">:</span>
        <span class="k">return</span> <span class="sa">f</span><span class="s2">"Hello, </span><span class="si">{</span><span class="bp">self</span><span class="o">.</span><span class="n">name</span><span class="si">}</span><span class="s2">!"</span>
</pre></div>

        </div>
    </div>


    <div class="example">
        <div class="example-header">blinds-dark</div>
        <div class="code">
            <div class="highlight-blinds-dark"><pre><span></span><span class="kn">from</span><span class="w"> </span><span class="nn">dataclasses</span><span class="w"> </span><span class="kn">import</span> <span class="n">dataclass</span>


<span class="nd">@dataclass</span>
<span class="k">class</span><span class="w"> </span><span class="nc">User</span><span class="p">:</span>
    <span class="n">name</span><span class="p">:</span> <span class="nb">str</span>
    <span class="n">active</span><span class="p">:</span> <span class="nb">bool</span> <span class="o">=</span> <span class="kc">True</span>

    <span class="k">def</span><span class="w"> </span><span class="nf">greet</span><span class="p">(</span><span class="bp">self</span><span class="p">)</span> <span class="o">-&gt;</span> <span class="nb">str</span><span class="p">:</span>
        <span class="k">return</span> <span class="sa">f</span><span class="s2">"Hello, </span><span class="si">{</span><span class="bp">self</span><span class="o">.</span><span class="n">name</span><span class="si">}</span><span class="s2">!"</span>
</pre></div>

        </div>
    </div>


    <div class="example">
        <div class="example-header">blinds-light</div>
        <div class="code">
            <div class="highlight-blinds-light"><pre><span></span><span class="kn">from</span><span class="w"> </span><span class="nn">dataclasses</span><span class="w"> </span><span class="kn">import</span> <span class="n">dataclass</span>


<span class="nd">@dataclass</span>
<span class="k">class</span><span class="w"> </span><span class="nc">User</span><span class="p">:</span>
    <span class="n">name</span><span class="p">:</span> <span class="nb">str</span>
    <span class="n">active</span><span class="p">:</span> <span class="nb">bool</span> <span class="o">=</span> <span class="kc">True</span>

    <span class="k">def</span><span class="w"> </span><span class="nf">greet</span><span class="p">(</span><span class="bp">self</span><span class="p">)</span> <span class="o">-&gt;</span> <span class="nb">str</span><span class="p">:</span>
        <span class="k">return</span> <span class="sa">f</span><span class="s2">"Hello, </span><span class="si">{</span><span class="bp">self</span><span class="o">.</span><span class="n">name</span><span class="si">}</span><span class="s2">!"</span>
</pre></div>

        </div>
    </div>


    <div class="example">
        <div class="example-header">borland</div>
        <div class="code">
            <div class="highlight-borland"><pre><span></span><span class="kn">from</span><span class="w"> </span><span class="nn">dataclasses</span><span class="w"> </span><span class="kn">import</span> <span class="n">dataclass</span>


<span class="nd">@dataclass</span>
<span class="k">class</span><span class="w"> </span><span class="nc">User</span><span class="p">:</span>
    <span class="n">name</span><span class="p">:</span> <span class="nb">str</span>
    <span class="n">active</span><span class="p">:</span> <span class="nb">bool</span> <span class="o">=</span> <span class="kc">True</span>

    <span class="k">def</span><span class="w"> </span><span class="nf">greet</span><span class="p">(</span><span class="bp">self</span><span class="p">)</span> <span class="o">-&gt;</span> <span class="nb">str</span><span class="p">:</span>
        <span class="k">return</span> <span class="sa">f</span><span class="s2">"Hello, </span><span class="si">{</span><span class="bp">self</span><span class="o">.</span><span class="n">name</span><span class="si">}</span><span class="s2">!"</span>
</pre></div>

        </div>
    </div>


    <div class="example">
        <div class="example-header">bw</div>
        <div class="code">
            <div class="highlight-bw"><pre><span></span><span class="kn">from</span><span class="w"> </span><span class="nn">dataclasses</span><span class="w"> </span><span class="kn">import</span> <span class="n">dataclass</span>


<span class="nd">@dataclass</span>
<span class="k">class</span><span class="w"> </span><span class="nc">User</span><span class="p">:</span>
    <span class="n">name</span><span class="p">:</span> <span class="nb">str</span>
    <span class="n">active</span><span class="p">:</span> <span class="nb">bool</span> <span class="o">=</span> <span class="kc">True</span>

    <span class="k">def</span><span class="w"> </span><span class="nf">greet</span><span class="p">(</span><span class="bp">self</span><span class="p">)</span> <span class="o">-&gt;</span> <span class="nb">str</span><span class="p">:</span>
        <span class="k">return</span> <span class="sa">f</span><span class="s2">"Hello, </span><span class="si">{</span><span class="bp">self</span><span class="o">.</span><span class="n">name</span><span class="si">}</span><span class="s2">!"</span>
</pre></div>

        </div>
    </div>


    <div class="example">
        <div class="example-header">coffee</div>
        <div class="code">
            <div class="highlight-coffee"><pre><span></span><span class="kn">from</span><span class="w"> </span><span class="nn">dataclasses</span><span class="w"> </span><span class="kn">import</span> <span class="n">dataclass</span>


<span class="nd">@dataclass</span>
<span class="k">class</span><span class="w"> </span><span class="nc">User</span><span class="p">:</span>
    <span class="n">name</span><span class="p">:</span> <span class="nb">str</span>
    <span class="n">active</span><span class="p">:</span> <span class="nb">bool</span> <span class="o">=</span> <span class="kc">True</span>

    <span class="k">def</span><span class="w"> </span><span class="nf">greet</span><span class="p">(</span><span class="bp">self</span><span class="p">)</span> <span class="o">-&gt;</span> <span class="nb">str</span><span class="p">:</span>
        <span class="k">return</span> <span class="sa">f</span><span class="s2">"Hello, </span><span class="si">{</span><span class="bp">self</span><span class="o">.</span><span class="n">name</span><span class="si">}</span><span class="s2">!"</span>
</pre></div>

        </div>
    </div>


    <div class="example">
        <div class="example-header">colorful</div>
        <div class="code">
            <div class="highlight-colorful"><pre><span></span><span class="kn">from</span><span class="w"> </span><span class="nn">dataclasses</span><span class="w"> </span><span class="kn">import</span> <span class="n">dataclass</span>


<span class="nd">@dataclass</span>
<span class="k">class</span><span class="w"> </span><span class="nc">User</span><span class="p">:</span>
    <span class="n">name</span><span class="p">:</span> <span class="nb">str</span>
    <span class="n">active</span><span class="p">:</span> <span class="nb">bool</span> <span class="o">=</span> <span class="kc">True</span>

    <span class="k">def</span><span class="w"> </span><span class="nf">greet</span><span class="p">(</span><span class="bp">self</span><span class="p">)</span> <span class="o">-&gt;</span> <span class="nb">str</span><span class="p">:</span>
        <span class="k">return</span> <span class="sa">f</span><span class="s2">"Hello, </span><span class="si">{</span><span class="bp">self</span><span class="o">.</span><span class="n">name</span><span class="si">}</span><span class="s2">!"</span>
</pre></div>

        </div>
    </div>


    <div class="example">
        <div class="example-header">default</div>
        <div class="code">
            <div class="highlight-default"><pre><span></span><span class="kn">from</span><span class="w"> </span><span class="nn">dataclasses</span><span class="w"> </span><span class="kn">import</span> <span class="n">dataclass</span>


<span class="nd">@dataclass</span>
<span class="k">class</span><span class="w"> </span><span class="nc">User</span><span class="p">:</span>
    <span class="n">name</span><span class="p">:</span> <span class="nb">str</span>
    <span class="n">active</span><span class="p">:</span> <span class="nb">bool</span> <span class="o">=</span> <span class="kc">True</span>

    <span class="k">def</span><span class="w"> </span><span class="nf">greet</span><span class="p">(</span><span class="bp">self</span><span class="p">)</span> <span class="o">-&gt;</span> <span class="nb">str</span><span class="p">:</span>
        <span class="k">return</span> <span class="sa">f</span><span class="s2">"Hello, </span><span class="si">{</span><span class="bp">self</span><span class="o">.</span><span class="n">name</span><span class="si">}</span><span class="s2">!"</span>
</pre></div>

        </div>
    </div>


    <div class="example">
        <div class="example-header">dracula</div>
        <div class="code">
            <div class="highlight-dracula"><pre><span></span><span class="kn">from</span><span class="w"> </span><span class="nn">dataclasses</span><span class="w"> </span><span class="kn">import</span> <span class="n">dataclass</span>


<span class="nd">@dataclass</span>
<span class="k">class</span><span class="w"> </span><span class="nc">User</span><span class="p">:</span>
    <span class="n">name</span><span class="p">:</span> <span class="nb">str</span>
    <span class="n">active</span><span class="p">:</span> <span class="nb">bool</span> <span class="o">=</span> <span class="kc">True</span>

    <span class="k">def</span><span class="w"> </span><span class="nf">greet</span><span class="p">(</span><span class="bp">self</span><span class="p">)</span> <span class="o">-&gt;</span> <span class="nb">str</span><span class="p">:</span>
        <span class="k">return</span> <span class="sa">f</span><span class="s2">"Hello, </span><span class="si">{</span><span class="bp">self</span><span class="o">.</span><span class="n">name</span><span class="si">}</span><span class="s2">!"</span>
</pre></div>

        </div>
    </div>


    <div class="example">
        <div class="example-header">emacs</div>
        <div class="code">
            <div class="highlight-emacs"><pre><span></span><span class="kn">from</span><span class="w"> </span><span class="nn">dataclasses</span><span class="w"> </span><span class="kn">import</span> <span class="n">dataclass</span>


<span class="nd">@dataclass</span>
<span class="k">class</span><span class="w"> </span><span class="nc">User</span><span class="p">:</span>
    <span class="n">name</span><span class="p">:</span> <span class="nb">str</span>
    <span class="n">active</span><span class="p">:</span> <span class="nb">bool</span> <span class="o">=</span> <span class="kc">True</span>

    <span class="k">def</span><span class="w"> </span><span class="nf">greet</span><span class="p">(</span><span class="bp">self</span><span class="p">)</span> <span class="o">-&gt;</span> <span class="nb">str</span><span class="p">:</span>
        <span class="k">return</span> <span class="sa">f</span><span class="s2">"Hello, </span><span class="si">{</span><span class="bp">self</span><span class="o">.</span><span class="n">name</span><span class="si">}</span><span class="s2">!"</span>
</pre></div>

        </div>
    </div>


    <div class="example">
        <div class="example-header">friendly</div>
        <div class="code">
            <div class="highlight-friendly"><pre><span></span><span class="kn">from</span><span class="w"> </span><span class="nn">dataclasses</span><span class="w"> </span><span class="kn">import</span> <span class="n">dataclass</span>


<span class="nd">@dataclass</span>
<span class="k">class</span><span class="w"> </span><span class="nc">User</span><span class="p">:</span>
    <span class="n">name</span><span class="p">:</span> <span class="nb">str</span>
    <span class="n">active</span><span class="p">:</span> <span class="nb">bool</span> <span class="o">=</span> <span class="kc">True</span>

    <span class="k">def</span><span class="w"> </span><span class="nf">greet</span><span class="p">(</span><span class="bp">self</span><span class="p">)</span> <span class="o">-&gt;</span> <span class="nb">str</span><span class="p">:</span>
        <span class="k">return</span> <span class="sa">f</span><span class="s2">"Hello, </span><span class="si">{</span><span class="bp">self</span><span class="o">.</span><span class="n">name</span><span class="si">}</span><span class="s2">!"</span>
</pre></div>

        </div>
    </div>


    <div class="example">
        <div class="example-header">friendly_grayscale</div>
        <div class="code">
            <div class="highlight-friendly_grayscale"><pre><span></span><span class="kn">from</span><span class="w"> </span><span class="nn">dataclasses</span><span class="w"> </span><span class="kn">import</span> <span class="n">dataclass</span>


<span class="nd">@dataclass</span>
<span class="k">class</span><span class="w"> </span><span class="nc">User</span><span class="p">:</span>
    <span class="n">name</span><span class="p">:</span> <span class="nb">str</span>
    <span class="n">active</span><span class="p">:</span> <span class="nb">bool</span> <span class="o">=</span> <span class="kc">True</span>

    <span class="k">def</span><span class="w"> </span><span class="nf">greet</span><span class="p">(</span><span class="bp">self</span><span class="p">)</span> <span class="o">-&gt;</span> <span class="nb">str</span><span class="p">:</span>
        <span class="k">return</span> <span class="sa">f</span><span class="s2">"Hello, </span><span class="si">{</span><span class="bp">self</span><span class="o">.</span><span class="n">name</span><span class="si">}</span><span class="s2">!"</span>
</pre></div>

        </div>
    </div>


    <div class="example">
        <div class="example-header">fruity</div>
        <div class="code">
            <div class="highlight-fruity"><pre><span></span><span class="kn">from</span><span class="w"> </span><span class="nn">dataclasses</span><span class="w"> </span><span class="kn">import</span> <span class="n">dataclass</span>


<span class="nd">@dataclass</span>
<span class="k">class</span><span class="w"> </span><span class="nc">User</span><span class="p">:</span>
    <span class="n">name</span><span class="p">:</span> <span class="nb">str</span>
    <span class="n">active</span><span class="p">:</span> <span class="nb">bool</span> <span class="o">=</span> <span class="kc">True</span>

    <span class="k">def</span><span class="w"> </span><span class="nf">greet</span><span class="p">(</span><span class="bp">self</span><span class="p">)</span> <span class="o">-&gt;</span> <span class="nb">str</span><span class="p">:</span>
        <span class="k">return</span> <span class="sa">f</span><span class="s2">"Hello, </span><span class="si">{</span><span class="bp">self</span><span class="o">.</span><span class="n">name</span><span class="si">}</span><span class="s2">!"</span>
</pre></div>

        </div>
    </div>


    <div class="example">
        <div class="example-header">github-dark</div>
        <div class="code">
            <div class="highlight-github-dark"><pre><span></span><span class="kn">from</span><span class="w"> </span><span class="nn">dataclasses</span><span class="w"> </span><span class="kn">import</span> <span class="n">dataclass</span>


<span class="nd">@dataclass</span>
<span class="k">class</span><span class="w"> </span><span class="nc">User</span><span class="p">:</span>
    <span class="n">name</span><span class="p">:</span> <span class="nb">str</span>
    <span class="n">active</span><span class="p">:</span> <span class="nb">bool</span> <span class="o">=</span> <span class="kc">True</span>

    <span class="k">def</span><span class="w"> </span><span class="nf">greet</span><span class="p">(</span><span class="bp">self</span><span class="p">)</span> <span class="o">-&gt;</span> <span class="nb">str</span><span class="p">:</span>
        <span class="k">return</span> <span class="sa">f</span><span class="s2">"Hello, </span><span class="si">{</span><span class="bp">self</span><span class="o">.</span><span class="n">name</span><span class="si">}</span><span class="s2">!"</span>
</pre></div>

        </div>
    </div>


    <div class="example">
        <div class="example-header">github-dark-colorblind</div>
        <div class="code">
            <div class="highlight-github-dark-colorblind"><pre><span></span><span class="kn">from</span><span class="w"> </span><span class="nn">dataclasses</span><span class="w"> </span><span class="kn">import</span> <span class="n">dataclass</span>


<span class="nd">@dataclass</span>
<span class="k">class</span><span class="w"> </span><span class="nc">User</span><span class="p">:</span>
    <span class="n">name</span><span class="p">:</span> <span class="nb">str</span>
    <span class="n">active</span><span class="p">:</span> <span class="nb">bool</span> <span class="o">=</span> <span class="kc">True</span>

    <span class="k">def</span><span class="w"> </span><span class="nf">greet</span><span class="p">(</span><span class="bp">self</span><span class="p">)</span> <span class="o">-&gt;</span> <span class="nb">str</span><span class="p">:</span>
        <span class="k">return</span> <span class="sa">f</span><span class="s2">"Hello, </span><span class="si">{</span><span class="bp">self</span><span class="o">.</span><span class="n">name</span><span class="si">}</span><span class="s2">!"</span>
</pre></div>

        </div>
    </div>


    <div class="example">
        <div class="example-header">github-dark-high-contrast</div>
        <div class="code">
            <div class="highlight-github-dark-high-contrast"><pre><span></span><span class="kn">from</span><span class="w"> </span><span class="nn">dataclasses</span><span class="w"> </span><span class="kn">import</span> <span class="n">dataclass</span>


<span class="nd">@dataclass</span>
<span class="k">class</span><span class="w"> </span><span class="nc">User</span><span class="p">:</span>
    <span class="n">name</span><span class="p">:</span> <span class="nb">str</span>
    <span class="n">active</span><span class="p">:</span> <span class="nb">bool</span> <span class="o">=</span> <span class="kc">True</span>

    <span class="k">def</span><span class="w"> </span><span class="nf">greet</span><span class="p">(</span><span class="bp">self</span><span class="p">)</span> <span class="o">-&gt;</span> <span class="nb">str</span><span class="p">:</span>
        <span class="k">return</span> <span class="sa">f</span><span class="s2">"Hello, </span><span class="si">{</span><span class="bp">self</span><span class="o">.</span><span class="n">name</span><span class="si">}</span><span class="s2">!"</span>
</pre></div>

        </div>
    </div>


    <div class="example">
        <div class="example-header">github-light</div>
        <div class="code">
            <div class="highlight-github-light"><pre><span></span><span class="kn">from</span><span class="w"> </span><span class="nn">dataclasses</span><span class="w"> </span><span class="kn">import</span> <span class="n">dataclass</span>


<span class="nd">@dataclass</span>
<span class="k">class</span><span class="w"> </span><span class="nc">User</span><span class="p">:</span>
    <span class="n">name</span><span class="p">:</span> <span class="nb">str</span>
    <span class="n">active</span><span class="p">:</span> <span class="nb">bool</span> <span class="o">=</span> <span class="kc">True</span>

    <span class="k">def</span><span class="w"> </span><span class="nf">greet</span><span class="p">(</span><span class="bp">self</span><span class="p">)</span> <span class="o">-&gt;</span> <span class="nb">str</span><span class="p">:</span>
        <span class="k">return</span> <span class="sa">f</span><span class="s2">"Hello, </span><span class="si">{</span><span class="bp">self</span><span class="o">.</span><span class="n">name</span><span class="si">}</span><span class="s2">!"</span>
</pre></div>

        </div>
    </div>


    <div class="example">
        <div class="example-header">github-light-colorblind</div>
        <div class="code">
            <div class="highlight-github-light-colorblind"><pre><span></span><span class="kn">from</span><span class="w"> </span><span class="nn">dataclasses</span><span class="w"> </span><span class="kn">import</span> <span class="n">dataclass</span>


<span class="nd">@dataclass</span>
<span class="k">class</span><span class="w"> </span><span class="nc">User</span><span class="p">:</span>
    <span class="n">name</span><span class="p">:</span> <span class="nb">str</span>
    <span class="n">active</span><span class="p">:</span> <span class="nb">bool</span> <span class="o">=</span> <span class="kc">True</span>

    <span class="k">def</span><span class="w"> </span><span class="nf">greet</span><span class="p">(</span><span class="bp">self</span><span class="p">)</span> <span class="o">-&gt;</span> <span class="nb">str</span><span class="p">:</span>
        <span class="k">return</span> <span class="sa">f</span><span class="s2">"Hello, </span><span class="si">{</span><span class="bp">self</span><span class="o">.</span><span class="n">name</span><span class="si">}</span><span class="s2">!"</span>
</pre></div>

        </div>
    </div>


    <div class="example">
        <div class="example-header">github-light-high-contrast</div>
        <div class="code">
            <div class="highlight-github-light-high-contrast"><pre><span></span><span class="kn">from</span><span class="w"> </span><span class="nn">dataclasses</span><span class="w"> </span><span class="kn">import</span> <span class="n">dataclass</span>


<span class="nd">@dataclass</span>
<span class="k">class</span><span class="w"> </span><span class="nc">User</span><span class="p">:</span>
    <span class="n">name</span><span class="p">:</span> <span class="nb">str</span>
    <span class="n">active</span><span class="p">:</span> <span class="nb">bool</span> <span class="o">=</span> <span class="kc">True</span>

    <span class="k">def</span><span class="w"> </span><span class="nf">greet</span><span class="p">(</span><span class="bp">self</span><span class="p">)</span> <span class="o">-&gt;</span> <span class="nb">str</span><span class="p">:</span>
        <span class="k">return</span> <span class="sa">f</span><span class="s2">"Hello, </span><span class="si">{</span><span class="bp">self</span><span class="o">.</span><span class="n">name</span><span class="si">}</span><span class="s2">!"</span>
</pre></div>

        </div>
    </div>


    <div class="example">
        <div class="example-header">gotthard-dark</div>
        <div class="code">
            <div class="highlight-gotthard-dark"><pre><span></span><span class="kn">from</span><span class="w"> </span><span class="nn">dataclasses</span><span class="w"> </span><span class="kn">import</span> <span class="n">dataclass</span>


<span class="nd">@dataclass</span>
<span class="k">class</span><span class="w"> </span><span class="nc">User</span><span class="p">:</span>
    <span class="n">name</span><span class="p">:</span> <span class="nb">str</span>
    <span class="n">active</span><span class="p">:</span> <span class="nb">bool</span> <span class="o">=</span> <span class="kc">True</span>

    <span class="k">def</span><span class="w"> </span><span class="nf">greet</span><span class="p">(</span><span class="bp">self</span><span class="p">)</span> <span class="o">-&gt;</span> <span class="nb">str</span><span class="p">:</span>
        <span class="k">return</span> <span class="sa">f</span><span class="s2">"Hello, </span><span class="si">{</span><span class="bp">self</span><span class="o">.</span><span class="n">name</span><span class="si">}</span><span class="s2">!"</span>
</pre></div>

        </div>
    </div>


    <div class="example">
        <div class="example-header">gotthard-light</div>
        <div class="code">
            <div class="highlight-gotthard-light"><pre><span></span><span class="kn">from</span><span class="w"> </span><span class="nn">dataclasses</span><span class="w"> </span><span class="kn">import</span> <span class="n">dataclass</span>


<span class="nd">@dataclass</span>
<span class="k">class</span><span class="w"> </span><span class="nc">User</span><span class="p">:</span>
    <span class="n">name</span><span class="p">:</span> <span class="nb">str</span>
    <span class="n">active</span><span class="p">:</span> <span class="nb">bool</span> <span class="o">=</span> <span class="kc">True</span>

    <span class="k">def</span><span class="w"> </span><span class="nf">greet</span><span class="p">(</span><span class="bp">self</span><span class="p">)</span> <span class="o">-&gt;</span> <span class="nb">str</span><span class="p">:</span>
        <span class="k">return</span> <span class="sa">f</span><span class="s2">"Hello, </span><span class="si">{</span><span class="bp">self</span><span class="o">.</span><span class="n">name</span><span class="si">}</span><span class="s2">!"</span>
</pre></div>

        </div>
    </div>


    <div class="example">
        <div class="example-header">greative</div>
        <div class="code">
            <div class="highlight-greative"><pre><span></span><span class="kn">from</span><span class="w"> </span><span class="nn">dataclasses</span><span class="w"> </span><span class="kn">import</span> <span class="n">dataclass</span>


<span class="nd">@dataclass</span>
<span class="k">class</span><span class="w"> </span><span class="nc">User</span><span class="p">:</span>
    <span class="n">name</span><span class="p">:</span> <span class="nb">str</span>
    <span class="n">active</span><span class="p">:</span> <span class="nb">bool</span> <span class="o">=</span> <span class="kc">True</span>

    <span class="k">def</span><span class="w"> </span><span class="nf">greet</span><span class="p">(</span><span class="bp">self</span><span class="p">)</span> <span class="o">-&gt;</span> <span class="nb">str</span><span class="p">:</span>
        <span class="k">return</span> <span class="sa">f</span><span class="s2">"Hello, </span><span class="si">{</span><span class="bp">self</span><span class="o">.</span><span class="n">name</span><span class="si">}</span><span class="s2">!"</span>
</pre></div>

        </div>
    </div>


    <div class="example">
        <div class="example-header">gruvbox-dark</div>
        <div class="code">
            <div class="highlight-gruvbox-dark"><pre><span></span><span class="kn">from</span><span class="w"> </span><span class="nn">dataclasses</span><span class="w"> </span><span class="kn">import</span> <span class="n">dataclass</span>


<span class="nd">@dataclass</span>
<span class="k">class</span><span class="w"> </span><span class="nc">User</span><span class="p">:</span>
    <span class="n">name</span><span class="p">:</span> <span class="nb">str</span>
    <span class="n">active</span><span class="p">:</span> <span class="nb">bool</span> <span class="o">=</span> <span class="kc">True</span>

    <span class="k">def</span><span class="w"> </span><span class="nf">greet</span><span class="p">(</span><span class="bp">self</span><span class="p">)</span> <span class="o">-&gt;</span> <span class="nb">str</span><span class="p">:</span>
        <span class="k">return</span> <span class="sa">f</span><span class="s2">"Hello, </span><span class="si">{</span><span class="bp">self</span><span class="o">.</span><span class="n">name</span><span class="si">}</span><span class="s2">!"</span>
</pre></div>

        </div>
    </div>


    <div class="example">
        <div class="example-header">gruvbox-light</div>
        <div class="code">
            <div class="highlight-gruvbox-light"><pre><span></span><span class="kn">from</span><span class="w"> </span><span class="nn">dataclasses</span><span class="w"> </span><span class="kn">import</span> <span class="n">dataclass</span>


<span class="nd">@dataclass</span>
<span class="k">class</span><span class="w"> </span><span class="nc">User</span><span class="p">:</span>
    <span class="n">name</span><span class="p">:</span> <span class="nb">str</span>
    <span class="n">active</span><span class="p">:</span> <span class="nb">bool</span> <span class="o">=</span> <span class="kc">True</span>

    <span class="k">def</span><span class="w"> </span><span class="nf">greet</span><span class="p">(</span><span class="bp">self</span><span class="p">)</span> <span class="o">-&gt;</span> <span class="nb">str</span><span class="p">:</span>
        <span class="k">return</span> <span class="sa">f</span><span class="s2">"Hello, </span><span class="si">{</span><span class="bp">self</span><span class="o">.</span><span class="n">name</span><span class="si">}</span><span class="s2">!"</span>
</pre></div>

        </div>
    </div>


    <div class="example">
        <div class="example-header">igor</div>
        <div class="code">
            <div class="highlight-igor"><pre><span></span><span class="kn">from</span><span class="w"> </span><span class="nn">dataclasses</span><span class="w"> </span><span class="kn">import</span> <span class="n">dataclass</span>


<span class="nd">@dataclass</span>
<span class="k">class</span><span class="w"> </span><span class="nc">User</span><span class="p">:</span>
    <span class="n">name</span><span class="p">:</span> <span class="nb">str</span>
    <span class="n">active</span><span class="p">:</span> <span class="nb">bool</span> <span class="o">=</span> <span class="kc">True</span>

    <span class="k">def</span><span class="w"> </span><span class="nf">greet</span><span class="p">(</span><span class="bp">self</span><span class="p">)</span> <span class="o">-&gt;</span> <span class="nb">str</span><span class="p">:</span>
        <span class="k">return</span> <span class="sa">f</span><span class="s2">"Hello, </span><span class="si">{</span><span class="bp">self</span><span class="o">.</span><span class="n">name</span><span class="si">}</span><span class="s2">!"</span>
</pre></div>

        </div>
    </div>


    <div class="example">
        <div class="example-header">inkpot</div>
        <div class="code">
            <div class="highlight-inkpot"><pre><span></span><span class="kn">from</span><span class="w"> </span><span class="nn">dataclasses</span><span class="w"> </span><span class="kn">import</span> <span class="n">dataclass</span>


<span class="nd">@dataclass</span>
<span class="k">class</span><span class="w"> </span><span class="nc">User</span><span class="p">:</span>
    <span class="n">name</span><span class="p">:</span> <span class="nb">str</span>
    <span class="n">active</span><span class="p">:</span> <span class="nb">bool</span> <span class="o">=</span> <span class="kc">True</span>

    <span class="k">def</span><span class="w"> </span><span class="nf">greet</span><span class="p">(</span><span class="bp">self</span><span class="p">)</span> <span class="o">-&gt;</span> <span class="nb">str</span><span class="p">:</span>
        <span class="k">return</span> <span class="sa">f</span><span class="s2">"Hello, </span><span class="si">{</span><span class="bp">self</span><span class="o">.</span><span class="n">name</span><span class="si">}</span><span class="s2">!"</span>
</pre></div>

        </div>
    </div>


    <div class="example">
        <div class="example-header">lightbulb</div>
        <div class="code">
            <div class="highlight-lightbulb"><pre><span></span><span class="kn">from</span><span class="w"> </span><span class="nn">dataclasses</span><span class="w"> </span><span class="kn">import</span> <span class="n">dataclass</span>


<span class="nd">@dataclass</span>
<span class="k">class</span><span class="w"> </span><span class="nc">User</span><span class="p">:</span>
    <span class="n">name</span><span class="p">:</span> <span class="nb">str</span>
    <span class="n">active</span><span class="p">:</span> <span class="nb">bool</span> <span class="o">=</span> <span class="kc">True</span>

    <span class="k">def</span><span class="w"> </span><span class="nf">greet</span><span class="p">(</span><span class="bp">self</span><span class="p">)</span> <span class="o">-&gt;</span> <span class="nb">str</span><span class="p">:</span>
        <span class="k">return</span> <span class="sa">f</span><span class="s2">"Hello, </span><span class="si">{</span><span class="bp">self</span><span class="o">.</span><span class="n">name</span><span class="si">}</span><span class="s2">!"</span>
</pre></div>

        </div>
    </div>


    <div class="example">
        <div class="example-header">lilypond</div>
        <div class="code">
            <div class="highlight-lilypond"><pre><span></span><span class="kn">from</span><span class="w"> </span><span class="nn">dataclasses</span><span class="w"> </span><span class="kn">import</span> <span class="n">dataclass</span>


<span class="nd">@dataclass</span>
<span class="k">class</span><span class="w"> </span><span class="nc">User</span><span class="p">:</span>
    <span class="n">name</span><span class="p">:</span> <span class="nb">str</span>
    <span class="n">active</span><span class="p">:</span> <span class="nb">bool</span> <span class="o">=</span> <span class="kc">True</span>

    <span class="k">def</span><span class="w"> </span><span class="nf">greet</span><span class="p">(</span><span class="bp">self</span><span class="p">)</span> <span class="o">-&gt;</span> <span class="nb">str</span><span class="p">:</span>
        <span class="k">return</span> <span class="sa">f</span><span class="s2">"Hello, </span><span class="si">{</span><span class="bp">self</span><span class="o">.</span><span class="n">name</span><span class="si">}</span><span class="s2">!"</span>
</pre></div>

        </div>
    </div>


    <div class="example">
        <div class="example-header">lovelace</div>
        <div class="code">
            <div class="highlight-lovelace"><pre><span></span><span class="kn">from</span><span class="w"> </span><span class="nn">dataclasses</span><span class="w"> </span><span class="kn">import</span> <span class="n">dataclass</span>


<span class="nd">@dataclass</span>
<span class="k">class</span><span class="w"> </span><span class="nc">User</span><span class="p">:</span>
    <span class="n">name</span><span class="p">:</span> <span class="nb">str</span>
    <span class="n">active</span><span class="p">:</span> <span class="nb">bool</span> <span class="o">=</span> <span class="kc">True</span>

    <span class="k">def</span><span class="w"> </span><span class="nf">greet</span><span class="p">(</span><span class="bp">self</span><span class="p">)</span> <span class="o">-&gt;</span> <span class="nb">str</span><span class="p">:</span>
        <span class="k">return</span> <span class="sa">f</span><span class="s2">"Hello, </span><span class="si">{</span><span class="bp">self</span><span class="o">.</span><span class="n">name</span><span class="si">}</span><span class="s2">!"</span>
</pre></div>

        </div>
    </div>


    <div class="example">
        <div class="example-header">manni</div>
        <div class="code">
            <div class="highlight-manni"><pre><span></span><span class="kn">from</span><span class="w"> </span><span class="nn">dataclasses</span><span class="w"> </span><span class="kn">import</span> <span class="n">dataclass</span>


<span class="nd">@dataclass</span>
<span class="k">class</span><span class="w"> </span><span class="nc">User</span><span class="p">:</span>
    <span class="n">name</span><span class="p">:</span> <span class="nb">str</span>
    <span class="n">active</span><span class="p">:</span> <span class="nb">bool</span> <span class="o">=</span> <span class="kc">True</span>

    <span class="k">def</span><span class="w"> </span><span class="nf">greet</span><span class="p">(</span><span class="bp">self</span><span class="p">)</span> <span class="o">-&gt;</span> <span class="nb">str</span><span class="p">:</span>
        <span class="k">return</span> <span class="sa">f</span><span class="s2">"Hello, </span><span class="si">{</span><span class="bp">self</span><span class="o">.</span><span class="n">name</span><span class="si">}</span><span class="s2">!"</span>
</pre></div>

        </div>
    </div>


    <div class="example">
        <div class="example-header">material</div>
        <div class="code">
            <div class="highlight-material"><pre><span></span><span class="kn">from</span><span class="w"> </span><span class="nn">dataclasses</span><span class="w"> </span><span class="kn">import</span> <span class="n">dataclass</span>


<span class="nd">@dataclass</span>
<span class="k">class</span><span class="w"> </span><span class="nc">User</span><span class="p">:</span>
    <span class="n">name</span><span class="p">:</span> <span class="nb">str</span>
    <span class="n">active</span><span class="p">:</span> <span class="nb">bool</span> <span class="o">=</span> <span class="kc">True</span>

    <span class="k">def</span><span class="w"> </span><span class="nf">greet</span><span class="p">(</span><span class="bp">self</span><span class="p">)</span> <span class="o">-&gt;</span> <span class="nb">str</span><span class="p">:</span>
        <span class="k">return</span> <span class="sa">f</span><span class="s2">"Hello, </span><span class="si">{</span><span class="bp">self</span><span class="o">.</span><span class="n">name</span><span class="si">}</span><span class="s2">!"</span>
</pre></div>

        </div>
    </div>


    <div class="example">
        <div class="example-header">monokai</div>
        <div class="code">
            <div class="highlight-monokai"><pre><span></span><span class="kn">from</span><span class="w"> </span><span class="nn">dataclasses</span><span class="w"> </span><span class="kn">import</span> <span class="n">dataclass</span>


<span class="nd">@dataclass</span>
<span class="k">class</span><span class="w"> </span><span class="nc">User</span><span class="p">:</span>
    <span class="n">name</span><span class="p">:</span> <span class="nb">str</span>
    <span class="n">active</span><span class="p">:</span> <span class="nb">bool</span> <span class="o">=</span> <span class="kc">True</span>

    <span class="k">def</span><span class="w"> </span><span class="nf">greet</span><span class="p">(</span><span class="bp">self</span><span class="p">)</span> <span class="o">-&gt;</span> <span class="nb">str</span><span class="p">:</span>
        <span class="k">return</span> <span class="sa">f</span><span class="s2">"Hello, </span><span class="si">{</span><span class="bp">self</span><span class="o">.</span><span class="n">name</span><span class="si">}</span><span class="s2">!"</span>
</pre></div>

        </div>
    </div>


    <div class="example">
        <div class="example-header">murphy</div>
        <div class="code">
            <div class="highlight-murphy"><pre><span></span><span class="kn">from</span><span class="w"> </span><span class="nn">dataclasses</span><span class="w"> </span><span class="kn">import</span> <span class="n">dataclass</span>


<span class="nd">@dataclass</span>
<span class="k">class</span><span class="w"> </span><span class="nc">User</span><span class="p">:</span>
    <span class="n">name</span><span class="p">:</span> <span class="nb">str</span>
    <span class="n">active</span><span class="p">:</span> <span class="nb">bool</span> <span class="o">=</span> <span class="kc">True</span>

    <span class="k">def</span><span class="w"> </span><span class="nf">greet</span><span class="p">(</span><span class="bp">self</span><span class="p">)</span> <span class="o">-&gt;</span> <span class="nb">str</span><span class="p">:</span>
        <span class="k">return</span> <span class="sa">f</span><span class="s2">"Hello, </span><span class="si">{</span><span class="bp">self</span><span class="o">.</span><span class="n">name</span><span class="si">}</span><span class="s2">!"</span>
</pre></div>

        </div>
    </div>


    <div class="example">
        <div class="example-header">native</div>
        <div class="code">
            <div class="highlight-native"><pre><span></span><span class="kn">from</span><span class="w"> </span><span class="nn">dataclasses</span><span class="w"> </span><span class="kn">import</span> <span class="n">dataclass</span>


<span class="nd">@dataclass</span>
<span class="k">class</span><span class="w"> </span><span class="nc">User</span><span class="p">:</span>
    <span class="n">name</span><span class="p">:</span> <span class="nb">str</span>
    <span class="n">active</span><span class="p">:</span> <span class="nb">bool</span> <span class="o">=</span> <span class="kc">True</span>

    <span class="k">def</span><span class="w"> </span><span class="nf">greet</span><span class="p">(</span><span class="bp">self</span><span class="p">)</span> <span class="o">-&gt;</span> <span class="nb">str</span><span class="p">:</span>
        <span class="k">return</span> <span class="sa">f</span><span class="s2">"Hello, </span><span class="si">{</span><span class="bp">self</span><span class="o">.</span><span class="n">name</span><span class="si">}</span><span class="s2">!"</span>
</pre></div>

        </div>
    </div>


    <div class="example">
        <div class="example-header">night-owl</div>
        <div class="code">
            <div class="highlight-night-owl"><pre><span></span><span class="kn">from</span><span class="w"> </span><span class="nn">dataclasses</span><span class="w"> </span><span class="kn">import</span> <span class="n">dataclass</span>


<span class="nd">@dataclass</span>
<span class="k">class</span><span class="w"> </span><span class="nc">User</span><span class="p">:</span>
    <span class="n">name</span><span class="p">:</span> <span class="nb">str</span>
    <span class="n">active</span><span class="p">:</span> <span class="nb">bool</span> <span class="o">=</span> <span class="kc">True</span>

    <span class="k">def</span><span class="w"> </span><span class="nf">greet</span><span class="p">(</span><span class="bp">self</span><span class="p">)</span> <span class="o">-&gt;</span> <span class="nb">str</span><span class="p">:</span>
        <span class="k">return</span> <span class="sa">f</span><span class="s2">"Hello, </span><span class="si">{</span><span class="bp">self</span><span class="o">.</span><span class="n">name</span><span class="si">}</span><span class="s2">!"</span>
</pre></div>

        </div>
    </div>


    <div class="example">
        <div class="example-header">nord</div>
        <div class="code">
            <div class="highlight-nord"><pre><span></span><span class="kn">from</span><span class="w"> </span><span class="nn">dataclasses</span><span class="w"> </span><span class="kn">import</span> <span class="n">dataclass</span>


<span class="nd">@dataclass</span>
<span class="k">class</span><span class="w"> </span><span class="nc">User</span><span class="p">:</span>
    <span class="n">name</span><span class="p">:</span> <span class="nb">str</span>
    <span class="n">active</span><span class="p">:</span> <span class="nb">bool</span> <span class="o">=</span> <span class="kc">True</span>

    <span class="k">def</span><span class="w"> </span><span class="nf">greet</span><span class="p">(</span><span class="bp">self</span><span class="p">)</span> <span class="o">-&gt;</span> <span class="nb">str</span><span class="p">:</span>
        <span class="k">return</span> <span class="sa">f</span><span class="s2">"Hello, </span><span class="si">{</span><span class="bp">self</span><span class="o">.</span><span class="n">name</span><span class="si">}</span><span class="s2">!"</span>
</pre></div>

        </div>
    </div>


    <div class="example">
        <div class="example-header">nord-darker</div>
        <div class="code">
            <div class="highlight-nord-darker"><pre><span></span><span class="kn">from</span><span class="w"> </span><span class="nn">dataclasses</span><span class="w"> </span><span class="kn">import</span> <span class="n">dataclass</span>


<span class="nd">@dataclass</span>
<span class="k">class</span><span class="w"> </span><span class="nc">User</span><span class="p">:</span>
    <span class="n">name</span><span class="p">:</span> <span class="nb">str</span>
    <span class="n">active</span><span class="p">:</span> <span class="nb">bool</span> <span class="o">=</span> <span class="kc">True</span>

    <span class="k">def</span><span class="w"> </span><span class="nf">greet</span><span class="p">(</span><span class="bp">self</span><span class="p">)</span> <span class="o">-&gt;</span> <span class="nb">str</span><span class="p">:</span>
        <span class="k">return</span> <span class="sa">f</span><span class="s2">"Hello, </span><span class="si">{</span><span class="bp">self</span><span class="o">.</span><span class="n">name</span><span class="si">}</span><span class="s2">!"</span>
</pre></div>

        </div>
    </div>


    <div class="example">
        <div class="example-header">one-dark</div>
        <div class="code">
            <div class="highlight-one-dark"><pre><span></span><span class="kn">from</span><span class="w"> </span><span class="nn">dataclasses</span><span class="w"> </span><span class="kn">import</span> <span class="n">dataclass</span>


<span class="nd">@dataclass</span>
<span class="k">class</span><span class="w"> </span><span class="nc">User</span><span class="p">:</span>
    <span class="n">name</span><span class="p">:</span> <span class="nb">str</span>
    <span class="n">active</span><span class="p">:</span> <span class="nb">bool</span> <span class="o">=</span> <span class="kc">True</span>

    <span class="k">def</span><span class="w"> </span><span class="nf">greet</span><span class="p">(</span><span class="bp">self</span><span class="p">)</span> <span class="o">-&gt;</span> <span class="nb">str</span><span class="p">:</span>
        <span class="k">return</span> <span class="sa">f</span><span class="s2">"Hello, </span><span class="si">{</span><span class="bp">self</span><span class="o">.</span><span class="n">name</span><span class="si">}</span><span class="s2">!"</span>
</pre></div>

        </div>
    </div>


    <div class="example">
        <div class="example-header">paraiso-dark</div>
        <div class="code">
            <div class="highlight-paraiso-dark"><pre><span></span><span class="kn">from</span><span class="w"> </span><span class="nn">dataclasses</span><span class="w"> </span><span class="kn">import</span> <span class="n">dataclass</span>


<span class="nd">@dataclass</span>
<span class="k">class</span><span class="w"> </span><span class="nc">User</span><span class="p">:</span>
    <span class="n">name</span><span class="p">:</span> <span class="nb">str</span>
    <span class="n">active</span><span class="p">:</span> <span class="nb">bool</span> <span class="o">=</span> <span class="kc">True</span>

    <span class="k">def</span><span class="w"> </span><span class="nf">greet</span><span class="p">(</span><span class="bp">self</span><span class="p">)</span> <span class="o">-&gt;</span> <span class="nb">str</span><span class="p">:</span>
        <span class="k">return</span> <span class="sa">f</span><span class="s2">"Hello, </span><span class="si">{</span><span class="bp">self</span><span class="o">.</span><span class="n">name</span><span class="si">}</span><span class="s2">!"</span>
</pre></div>

        </div>
    </div>


    <div class="example">
        <div class="example-header">paraiso-light</div>
        <div class="code">
            <div class="highlight-paraiso-light"><pre><span></span><span class="kn">from</span><span class="w"> </span><span class="nn">dataclasses</span><span class="w"> </span><span class="kn">import</span> <span class="n">dataclass</span>


<span class="nd">@dataclass</span>
<span class="k">class</span><span class="w"> </span><span class="nc">User</span><span class="p">:</span>
    <span class="n">name</span><span class="p">:</span> <span class="nb">str</span>
    <span class="n">active</span><span class="p">:</span> <span class="nb">bool</span> <span class="o">=</span> <span class="kc">True</span>

    <span class="k">def</span><span class="w"> </span><span class="nf">greet</span><span class="p">(</span><span class="bp">self</span><span class="p">)</span> <span class="o">-&gt;</span> <span class="nb">str</span><span class="p">:</span>
        <span class="k">return</span> <span class="sa">f</span><span class="s2">"Hello, </span><span class="si">{</span><span class="bp">self</span><span class="o">.</span><span class="n">name</span><span class="si">}</span><span class="s2">!"</span>
</pre></div>

        </div>
    </div>


    <div class="example">
        <div class="example-header">pastie</div>
        <div class="code">
            <div class="highlight-pastie"><pre><span></span><span class="kn">from</span><span class="w"> </span><span class="nn">dataclasses</span><span class="w"> </span><span class="kn">import</span> <span class="n">dataclass</span>


<span class="nd">@dataclass</span>
<span class="k">class</span><span class="w"> </span><span class="nc">User</span><span class="p">:</span>
    <span class="n">name</span><span class="p">:</span> <span class="nb">str</span>
    <span class="n">active</span><span class="p">:</span> <span class="nb">bool</span> <span class="o">=</span> <span class="kc">True</span>

    <span class="k">def</span><span class="w"> </span><span class="nf">greet</span><span class="p">(</span><span class="bp">self</span><span class="p">)</span> <span class="o">-&gt;</span> <span class="nb">str</span><span class="p">:</span>
        <span class="k">return</span> <span class="sa">f</span><span class="s2">"Hello, </span><span class="si">{</span><span class="bp">self</span><span class="o">.</span><span class="n">name</span><span class="si">}</span><span class="s2">!"</span>
</pre></div>

        </div>
    </div>


    <div class="example">
        <div class="example-header">perldoc</div>
        <div class="code">
            <div class="highlight-perldoc"><pre><span></span><span class="kn">from</span><span class="w"> </span><span class="nn">dataclasses</span><span class="w"> </span><span class="kn">import</span> <span class="n">dataclass</span>


<span class="nd">@dataclass</span>
<span class="k">class</span><span class="w"> </span><span class="nc">User</span><span class="p">:</span>
    <span class="n">name</span><span class="p">:</span> <span class="nb">str</span>
    <span class="n">active</span><span class="p">:</span> <span class="nb">bool</span> <span class="o">=</span> <span class="kc">True</span>

    <span class="k">def</span><span class="w"> </span><span class="nf">greet</span><span class="p">(</span><span class="bp">self</span><span class="p">)</span> <span class="o">-&gt;</span> <span class="nb">str</span><span class="p">:</span>
        <span class="k">return</span> <span class="sa">f</span><span class="s2">"Hello, </span><span class="si">{</span><span class="bp">self</span><span class="o">.</span><span class="n">name</span><span class="si">}</span><span class="s2">!"</span>
</pre></div>

        </div>
    </div>


    <div class="example">
        <div class="example-header">pitaya-smoothie</div>
        <div class="code">
            <div class="highlight-pitaya-smoothie"><pre><span></span><span class="kn">from</span><span class="w"> </span><span class="nn">dataclasses</span><span class="w"> </span><span class="kn">import</span> <span class="n">dataclass</span>


<span class="nd">@dataclass</span>
<span class="k">class</span><span class="w"> </span><span class="nc">User</span><span class="p">:</span>
    <span class="n">name</span><span class="p">:</span> <span class="nb">str</span>
    <span class="n">active</span><span class="p">:</span> <span class="nb">bool</span> <span class="o">=</span> <span class="kc">True</span>

    <span class="k">def</span><span class="w"> </span><span class="nf">greet</span><span class="p">(</span><span class="bp">self</span><span class="p">)</span> <span class="o">-&gt;</span> <span class="nb">str</span><span class="p">:</span>
        <span class="k">return</span> <span class="sa">f</span><span class="s2">"Hello, </span><span class="si">{</span><span class="bp">self</span><span class="o">.</span><span class="n">name</span><span class="si">}</span><span class="s2">!"</span>
</pre></div>

        </div>
    </div>


    <div class="example">
        <div class="example-header">rainbow_dash</div>
        <div class="code">
            <div class="highlight-rainbow_dash"><pre><span></span><span class="kn">from</span><span class="w"> </span><span class="nn">dataclasses</span><span class="w"> </span><span class="kn">import</span> <span class="n">dataclass</span>


<span class="nd">@dataclass</span>
<span class="k">class</span><span class="w"> </span><span class="nc">User</span><span class="p">:</span>
    <span class="n">name</span><span class="p">:</span> <span class="nb">str</span>
    <span class="n">active</span><span class="p">:</span> <span class="nb">bool</span> <span class="o">=</span> <span class="kc">True</span>

    <span class="k">def</span><span class="w"> </span><span class="nf">greet</span><span class="p">(</span><span class="bp">self</span><span class="p">)</span> <span class="o">-&gt;</span> <span class="nb">str</span><span class="p">:</span>
        <span class="k">return</span> <span class="sa">f</span><span class="s2">"Hello, </span><span class="si">{</span><span class="bp">self</span><span class="o">.</span><span class="n">name</span><span class="si">}</span><span class="s2">!"</span>
</pre></div>

        </div>
    </div>


    <div class="example">
        <div class="example-header">rrt</div>
        <div class="code">
            <div class="highlight-rrt"><pre><span></span><span class="kn">from</span><span class="w"> </span><span class="nn">dataclasses</span><span class="w"> </span><span class="kn">import</span> <span class="n">dataclass</span>


<span class="nd">@dataclass</span>
<span class="k">class</span><span class="w"> </span><span class="nc">User</span><span class="p">:</span>
    <span class="n">name</span><span class="p">:</span> <span class="nb">str</span>
    <span class="n">active</span><span class="p">:</span> <span class="nb">bool</span> <span class="o">=</span> <span class="kc">True</span>

    <span class="k">def</span><span class="w"> </span><span class="nf">greet</span><span class="p">(</span><span class="bp">self</span><span class="p">)</span> <span class="o">-&gt;</span> <span class="nb">str</span><span class="p">:</span>
        <span class="k">return</span> <span class="sa">f</span><span class="s2">"Hello, </span><span class="si">{</span><span class="bp">self</span><span class="o">.</span><span class="n">name</span><span class="si">}</span><span class="s2">!"</span>
</pre></div>

        </div>
    </div>


    <div class="example">
        <div class="example-header">sas</div>
        <div class="code">
            <div class="highlight-sas"><pre><span></span><span class="kn">from</span><span class="w"> </span><span class="nn">dataclasses</span><span class="w"> </span><span class="kn">import</span> <span class="n">dataclass</span>


<span class="nd">@dataclass</span>
<span class="k">class</span><span class="w"> </span><span class="nc">User</span><span class="p">:</span>
    <span class="n">name</span><span class="p">:</span> <span class="nb">str</span>
    <span class="n">active</span><span class="p">:</span> <span class="nb">bool</span> <span class="o">=</span> <span class="kc">True</span>

    <span class="k">def</span><span class="w"> </span><span class="nf">greet</span><span class="p">(</span><span class="bp">self</span><span class="p">)</span> <span class="o">-&gt;</span> <span class="nb">str</span><span class="p">:</span>
        <span class="k">return</span> <span class="sa">f</span><span class="s2">"Hello, </span><span class="si">{</span><span class="bp">self</span><span class="o">.</span><span class="n">name</span><span class="si">}</span><span class="s2">!"</span>
</pre></div>

        </div>
    </div>


    <div class="example">
        <div class="example-header">solarized-dark</div>
        <div class="code">
            <div class="highlight-solarized-dark"><pre><span></span><span class="kn">from</span><span class="w"> </span><span class="nn">dataclasses</span><span class="w"> </span><span class="kn">import</span> <span class="n">dataclass</span>


<span class="nd">@dataclass</span>
<span class="k">class</span><span class="w"> </span><span class="nc">User</span><span class="p">:</span>
    <span class="n">name</span><span class="p">:</span> <span class="nb">str</span>
    <span class="n">active</span><span class="p">:</span> <span class="nb">bool</span> <span class="o">=</span> <span class="kc">True</span>

    <span class="k">def</span><span class="w"> </span><span class="nf">greet</span><span class="p">(</span><span class="bp">self</span><span class="p">)</span> <span class="o">-&gt;</span> <span class="nb">str</span><span class="p">:</span>
        <span class="k">return</span> <span class="sa">f</span><span class="s2">"Hello, </span><span class="si">{</span><span class="bp">self</span><span class="o">.</span><span class="n">name</span><span class="si">}</span><span class="s2">!"</span>
</pre></div>

        </div>
    </div>


    <div class="example">
        <div class="example-header">solarized-light</div>
        <div class="code">
            <div class="highlight-solarized-light"><pre><span></span><span class="kn">from</span><span class="w"> </span><span class="nn">dataclasses</span><span class="w"> </span><span class="kn">import</span> <span class="n">dataclass</span>


<span class="nd">@dataclass</span>
<span class="k">class</span><span class="w"> </span><span class="nc">User</span><span class="p">:</span>
    <span class="n">name</span><span class="p">:</span> <span class="nb">str</span>
    <span class="n">active</span><span class="p">:</span> <span class="nb">bool</span> <span class="o">=</span> <span class="kc">True</span>

    <span class="k">def</span><span class="w"> </span><span class="nf">greet</span><span class="p">(</span><span class="bp">self</span><span class="p">)</span> <span class="o">-&gt;</span> <span class="nb">str</span><span class="p">:</span>
        <span class="k">return</span> <span class="sa">f</span><span class="s2">"Hello, </span><span class="si">{</span><span class="bp">self</span><span class="o">.</span><span class="n">name</span><span class="si">}</span><span class="s2">!"</span>
</pre></div>

        </div>
    </div>


    <div class="example">
        <div class="example-header">staroffice</div>
        <div class="code">
            <div class="highlight-staroffice"><pre><span></span><span class="kn">from</span><span class="w"> </span><span class="nn">dataclasses</span><span class="w"> </span><span class="kn">import</span> <span class="n">dataclass</span>


<span class="nd">@dataclass</span>
<span class="k">class</span><span class="w"> </span><span class="nc">User</span><span class="p">:</span>
    <span class="n">name</span><span class="p">:</span> <span class="nb">str</span>
    <span class="n">active</span><span class="p">:</span> <span class="nb">bool</span> <span class="o">=</span> <span class="kc">True</span>

    <span class="k">def</span><span class="w"> </span><span class="nf">greet</span><span class="p">(</span><span class="bp">self</span><span class="p">)</span> <span class="o">-&gt;</span> <span class="nb">str</span><span class="p">:</span>
        <span class="k">return</span> <span class="sa">f</span><span class="s2">"Hello, </span><span class="si">{</span><span class="bp">self</span><span class="o">.</span><span class="n">name</span><span class="si">}</span><span class="s2">!"</span>
</pre></div>

        </div>
    </div>


    <div class="example">
        <div class="example-header">stata-dark</div>
        <div class="code">
            <div class="highlight-stata-dark"><pre><span></span><span class="kn">from</span><span class="w"> </span><span class="nn">dataclasses</span><span class="w"> </span><span class="kn">import</span> <span class="n">dataclass</span>


<span class="nd">@dataclass</span>
<span class="k">class</span><span class="w"> </span><span class="nc">User</span><span class="p">:</span>
    <span class="n">name</span><span class="p">:</span> <span class="nb">str</span>
    <span class="n">active</span><span class="p">:</span> <span class="nb">bool</span> <span class="o">=</span> <span class="kc">True</span>

    <span class="k">def</span><span class="w"> </span><span class="nf">greet</span><span class="p">(</span><span class="bp">self</span><span class="p">)</span> <span class="o">-&gt;</span> <span class="nb">str</span><span class="p">:</span>
        <span class="k">return</span> <span class="sa">f</span><span class="s2">"Hello, </span><span class="si">{</span><span class="bp">self</span><span class="o">.</span><span class="n">name</span><span class="si">}</span><span class="s2">!"</span>
</pre></div>

        </div>
    </div>


    <div class="example">
        <div class="example-header">stata-light</div>
        <div class="code">
            <div class="highlight-stata-light"><pre><span></span><span class="kn">from</span><span class="w"> </span><span class="nn">dataclasses</span><span class="w"> </span><span class="kn">import</span> <span class="n">dataclass</span>


<span class="nd">@dataclass</span>
<span class="k">class</span><span class="w"> </span><span class="nc">User</span><span class="p">:</span>
    <span class="n">name</span><span class="p">:</span> <span class="nb">str</span>
    <span class="n">active</span><span class="p">:</span> <span class="nb">bool</span> <span class="o">=</span> <span class="kc">True</span>

    <span class="k">def</span><span class="w"> </span><span class="nf">greet</span><span class="p">(</span><span class="bp">self</span><span class="p">)</span> <span class="o">-&gt;</span> <span class="nb">str</span><span class="p">:</span>
        <span class="k">return</span> <span class="sa">f</span><span class="s2">"Hello, </span><span class="si">{</span><span class="bp">self</span><span class="o">.</span><span class="n">name</span><span class="si">}</span><span class="s2">!"</span>
</pre></div>

        </div>
    </div>


    <div class="example">
        <div class="example-header">tango</div>
        <div class="code">
            <div class="highlight-tango"><pre><span></span><span class="kn">from</span><span class="w"> </span><span class="nn">dataclasses</span><span class="w"> </span><span class="kn">import</span> <span class="n">dataclass</span>


<span class="nd">@dataclass</span>
<span class="k">class</span><span class="w"> </span><span class="nc">User</span><span class="p">:</span>
    <span class="n">name</span><span class="p">:</span> <span class="nb">str</span>
    <span class="n">active</span><span class="p">:</span> <span class="nb">bool</span> <span class="o">=</span> <span class="kc">True</span>

    <span class="k">def</span><span class="w"> </span><span class="nf">greet</span><span class="p">(</span><span class="bp">self</span><span class="p">)</span> <span class="o">-&gt;</span> <span class="nb">str</span><span class="p">:</span>
        <span class="k">return</span> <span class="sa">f</span><span class="s2">"Hello, </span><span class="si">{</span><span class="bp">self</span><span class="o">.</span><span class="n">name</span><span class="si">}</span><span class="s2">!"</span>
</pre></div>

        </div>
    </div>


    <div class="example">
        <div class="example-header">trac</div>
        <div class="code">
            <div class="highlight-trac"><pre><span></span><span class="kn">from</span><span class="w"> </span><span class="nn">dataclasses</span><span class="w"> </span><span class="kn">import</span> <span class="n">dataclass</span>


<span class="nd">@dataclass</span>
<span class="k">class</span><span class="w"> </span><span class="nc">User</span><span class="p">:</span>
    <span class="n">name</span><span class="p">:</span> <span class="nb">str</span>
    <span class="n">active</span><span class="p">:</span> <span class="nb">bool</span> <span class="o">=</span> <span class="kc">True</span>

    <span class="k">def</span><span class="w"> </span><span class="nf">greet</span><span class="p">(</span><span class="bp">self</span><span class="p">)</span> <span class="o">-&gt;</span> <span class="nb">str</span><span class="p">:</span>
        <span class="k">return</span> <span class="sa">f</span><span class="s2">"Hello, </span><span class="si">{</span><span class="bp">self</span><span class="o">.</span><span class="n">name</span><span class="si">}</span><span class="s2">!"</span>
</pre></div>

        </div>
    </div>


    <div class="example">
        <div class="example-header">vim</div>
        <div class="code">
            <div class="highlight-vim"><pre><span></span><span class="kn">from</span><span class="w"> </span><span class="nn">dataclasses</span><span class="w"> </span><span class="kn">import</span> <span class="n">dataclass</span>


<span class="nd">@dataclass</span>
<span class="k">class</span><span class="w"> </span><span class="nc">User</span><span class="p">:</span>
    <span class="n">name</span><span class="p">:</span> <span class="nb">str</span>
    <span class="n">active</span><span class="p">:</span> <span class="nb">bool</span> <span class="o">=</span> <span class="kc">True</span>

    <span class="k">def</span><span class="w"> </span><span class="nf">greet</span><span class="p">(</span><span class="bp">self</span><span class="p">)</span> <span class="o">-&gt;</span> <span class="nb">str</span><span class="p">:</span>
        <span class="k">return</span> <span class="sa">f</span><span class="s2">"Hello, </span><span class="si">{</span><span class="bp">self</span><span class="o">.</span><span class="n">name</span><span class="si">}</span><span class="s2">!"</span>
</pre></div>

        </div>
    </div>


    <div class="example">
        <div class="example-header">vs</div>
        <div class="code">
            <div class="highlight-vs"><pre><span></span><span class="kn">from</span><span class="w"> </span><span class="nn">dataclasses</span><span class="w"> </span><span class="kn">import</span> <span class="n">dataclass</span>


<span class="nd">@dataclass</span>
<span class="k">class</span><span class="w"> </span><span class="nc">User</span><span class="p">:</span>
    <span class="n">name</span><span class="p">:</span> <span class="nb">str</span>
    <span class="n">active</span><span class="p">:</span> <span class="nb">bool</span> <span class="o">=</span> <span class="kc">True</span>

    <span class="k">def</span><span class="w"> </span><span class="nf">greet</span><span class="p">(</span><span class="bp">self</span><span class="p">)</span> <span class="o">-&gt;</span> <span class="nb">str</span><span class="p">:</span>
        <span class="k">return</span> <span class="sa">f</span><span class="s2">"Hello, </span><span class="si">{</span><span class="bp">self</span><span class="o">.</span><span class="n">name</span><span class="si">}</span><span class="s2">!"</span>
</pre></div>

        </div>
    </div>


    <div class="example">
        <div class="example-header">xcode</div>
        <div class="code">
            <div class="highlight-xcode"><pre><span></span><span class="kn">from</span><span class="w"> </span><span class="nn">dataclasses</span><span class="w"> </span><span class="kn">import</span> <span class="n">dataclass</span>


<span class="nd">@dataclass</span>
<span class="k">class</span><span class="w"> </span><span class="nc">User</span><span class="p">:</span>
    <span class="n">name</span><span class="p">:</span> <span class="nb">str</span>
    <span class="n">active</span><span class="p">:</span> <span class="nb">bool</span> <span class="o">=</span> <span class="kc">True</span>

    <span class="k">def</span><span class="w"> </span><span class="nf">greet</span><span class="p">(</span><span class="bp">self</span><span class="p">)</span> <span class="o">-&gt;</span> <span class="nb">str</span><span class="p">:</span>
        <span class="k">return</span> <span class="sa">f</span><span class="s2">"Hello, </span><span class="si">{</span><span class="bp">self</span><span class="o">.</span><span class="n">name</span><span class="si">}</span><span class="s2">!"</span>
</pre></div>

        </div>
    </div>


    <div class="example">
        <div class="example-header">zenburn</div>
        <div class="code">
            <div class="highlight-zenburn"><pre><span></span><span class="kn">from</span><span class="w"> </span><span class="nn">dataclasses</span><span class="w"> </span><span class="kn">import</span> <span class="n">dataclass</span>


<span class="nd">@dataclass</span>
<span class="k">class</span><span class="w"> </span><span class="nc">User</span><span class="p">:</span>
    <span class="n">name</span><span class="p">:</span> <span class="nb">str</span>
    <span class="n">active</span><span class="p">:</span> <span class="nb">bool</span> <span class="o">=</span> <span class="kc">True</span>

    <span class="k">def</span><span class="w"> </span><span class="nf">greet</span><span class="p">(</span><span class="bp">self</span><span class="p">)</span> <span class="o">-&gt;</span> <span class="nb">str</span><span class="p">:</span>
        <span class="k">return</span> <span class="sa">f</span><span class="s2">"Hello, </span><span class="si">{</span><span class="bp">self</span><span class="o">.</span><span class="n">name</span><span class="si">}</span><span class="s2">!"</span>
</pre></div>

        </div>
    </div>
</div>
