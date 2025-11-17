---
title: Python - Video Recording Selenium Web UI Tests
description: Capturing a video recording of Selenium tests with pytest and ffmpeg
date: 2025-11-17
tags: [programming, selenium, python, pytest, testing, chrome, windows]
---

### Overview

This article shows how to create a video recording of
[Selenium](https://selenium.dev)
[WebDriver](https://selenium.dev/documentation/webdriver) tests on Windows
using Python. The code will use the
[Selenium Python bindings](https://selenium.dev/selenium/docs/api/py) along
with [pytest](https://pytest.org). If you are unfamiliar with those, you will
have to RTFM on your own. The screen recording is done with
[ffmpeg](https://ffmpeg.org), a popular cross-platform open source video
editing/recording program.

### Some caveats

- This code only works on Windows. You can use ffmpeg on other platforms, but
  you will need to use different capture filters and command line arguments.
- This approach records your local desktop, so it won't work with browsers
  running in headless mode or running remotely via Selenium Grid.
- To run the example code, you need to have Python installed (along with the
  `selenium` and `pytest` packages), and `ffmpeg`
  [installed](https://ffmpeg.org/download.html) and available in your PATH.


### Code examples

Tests are recorded using a function scoped fixture. When this fixture is used
in a test, it will start ffmpeg in a background process, and stop the recording
when the test completes. Each video is saved in a seprate file using the test's
name (i.e. `video_test_example.mp4`). Videos are written to the current
directory and overwritten each time it is run. You can alter the fixture to
save them somewhere else or incorporate them in test reports. The code also
adds a `--record` command line argument to enable recording when calling
pytest.

Here is a pytest `conftest.py` with the recording fixture:

```python
import signal
import shlex
import subprocess

import pytest


def pytest_addoption(parser):
    parser.addoption(
        "--record",
        action="store_true",
        help="enable video recording",
    )


@pytest.fixture
def record(request):
    if request.config.getoption("--record"):
        test_name = request.node.name
        cmd = (
            "ffmpeg -y -f gdigrab -framerate 30 -i desktop "
            f"-vcodec libx264 video_{test_name}.mp4"
        )
        proc = subprocess.Popen(
            shlex.split(cmd),
            creationflags=subprocess.CREATE_NEW_PROCESS_GROUP,
            stderr=subprocess.DEVNULL,
        )
        yield True
        proc.send_signal(signal.CTRL_BREAK_EVENT)
    else:
        yield False
```
{: file='conftest.py'}

Note: Windows doesn't have good signal handling like POSIX does, so terminating
the ffmpeg process normally leaves you with a corrupt video file. To work
around that, we have to create a process group and send `CTRL_BREAK` to get it
to exist cleanly.

Here is a test file has a fixture that launches a Chrome browser for each test.
This `driver` fixture calls the `record` fixture. This file also has 2 example
tests that use the recording driver:

```python
import time

import pytest
from selenium import webdriver


@pytest.fixture
def driver(record):
    with webdriver.Chrome() as _driver:
        _driver.maximize_window()
        yield _driver
        if record:
            time.sleep(3)


def test_example_1(driver):
    driver.get("https://example.com")
    assert "Example Domain" in driver.title


def test_example_2(driver):
    driver.get("https://selenium.dev")
    assert "Selenium" in driver.title
```
{: file='test_recording.py'}

Note: There is a short sleep before closing the browser when recording is
enabled, so the video doesn't end abruptly without being able to see the
results in the UI.

To run these tests with recording enabled, you would call pytest with the
`--record` argument we added: `pytest --record test_recording.py`. This will
produce a video file for each test.
