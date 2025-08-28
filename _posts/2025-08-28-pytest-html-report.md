---
title: Python - Customize Your pytest HTML Reports
description: Adding additional information to test reports with pytest-html
date: 2025-08-28
tags: [python, pytest, testing]
---


[pytest](https://pytest.org) is the most commonly used test framework for
Python. There are
[many great plugins](https://docs.pytest.org/en/stable/reference/plugin_list.html)
available for enhancing its functionality. One commonly used plugin is
[pytest-html](https://pypi.org/project/pytest-html). It is used for generating
HTML test reports that contain information about tests that were run
(test names, pass/fail/skip status, error messages, timing, etc).

The documentation for pytest-html is a little bit lacking when it comes to
customizing the test report. I wanted to add additional information like a
report title, project version, and a description of each test. Below is what
I came up with.

Using the plugin is very simple. First install it along with pytest:

```
pip install pytest pytest-html
```

Then create your tests using the standard naming conventions. For example,
create a file named `test_foo.py` containing the following test:

```python
def test_foo():
    """This is my test description."""
    assert 1 == 1
```

I added a docstring to my test function with a description of the test. We will
later see this next to the test in the report.

I added the following to my pytest configuration (`conftest.py`):

```python
import pytest
from pytest_metadata.plugin import metadata_key


TITLE = "My Test Report Title"
PROJECT = "Project v1.0.0"


def pytest_configure(config):
    config.stash[metadata_key]["Project"] = PROJECT


def pytest_html_report_title(report):
    report.title = TITLE


def pytest_html_results_table_header(cells):
    cells.insert(2, "<td><b>Description</b></td>")


def pytest_html_results_table_row(report, cells):
    description = getattr(report, "description", "")
    cells.insert(2, f"<td>{description}</td>")


@pytest.hookimpl(hookwrapper=True)
def pytest_runtest_makereport(item, call):
    outcome = yield
    if item.function.__doc__:
        outcome._result.description = item.function.__doc__
```

This configuration adds a title, project version information in the
"Environment" table, and an additional column in the report details
named "Description", that contains the docstring from each test.

I can execute the test and generate a report by running:

```
pytest --html=report.html --self-contained-html
```

The generated report (`report.html`) looks like this:

![pytest-html report screenshot](/assets/img/posts/2025-08-28-pytest-html.png){: w="600" }

(tested using pytest 8.4.1 and pytest-html 4.1.1)
