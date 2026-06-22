---
title: CLI and Python API for running Talend Cloud jobs
description: Python package for Talend Cloud job execution and monitoring (talend-task)
date: 2026-06-20
tags: [programming, python, open source]
---

I am using the [Talend Cloud][talend-cloud] platform (now part of
[Qlik][qlik-home]) for ETL pipelines and data workflows. I needed a way to
remotely execute and monitor jobs from the command line, so I wrote
**talend-task** (MIT licensed).

**`talend-task`** Python package:

- Releases: [PyPI][pypi-home]
- Development: [GitHub Repo][github-repo]

### About talend-task

The `talend-task` package provides a command-line interface and Python API
client for executing and monitoring jobs in [Talend Cloud][talend-cloud],
including ETL pipelines and other data workflows. It uses the
[Processing API][talend-processing-api] to trigger executions and monitor
their status.

The package consists of:

- command-line interface (`talend_task`)
- Python API client module (`talend_task.talend_client`) providing the
  `TalendClient` class
  - [API documentation][api-docs]

In this package, a “job” refers to a runnable Talend Task. Running a job creates
a corresponding Talend Execution.

### Installation

Install the package from [PyPI][pypi-home]:

```console
pip install talend-task
```

### CLI

`talend_task` is a CLI for running and monitoring jobs in
[Talend Cloud][talend-cloud].

After installation, the `talend_task` command is available in your shell.

Select a job interactively or pass `--job` directly.

```text
$ talend_task --help
usage: talend_task [-h] [--debug] [--wait] [--activity] [--job NAME] [--timeout SECS]
                   [--poll-interval SECS]

Talend Cloud CLI

options:
  -h, --help            show this help message and exit
  --debug               enable debug logging
  --wait                wait for job to complete and return status
  --activity            show recent runs without executing job (cannot use --wait)
  --job NAME            job name
  --timeout SECS        timeout (requires --wait, default: none)
  --poll-interval SECS  polling interval (requires --wait, default: 5)
```

----

### Example CLI Usage

#### Direct Mode:

Run a job by providing `--job <name>`:

```console
talend_task --wait --job Job1
```

#### Interactive Mode:

Run the CLI without specifying a job to select and execute one from a menu:

```console
talend_task --wait
```

#### Activity Mode:

Show recent runs for a job without executing it:

```console
talend_task --activity --job Job1
```

----

### CLI Screenshots

#### Interactive mode:

![Screenshot](https://raw.githubusercontent.com/cgoldberg/talend-task/refs/heads/main/screenshots/screenshot-terminal-interactive-mode.png)

#### Direct mode:

![Screenshot](https://raw.githubusercontent.com/cgoldberg/talend-task/refs/heads/main/screenshots/screenshot-terminal-direct-mode.png)

#### Activity mode:

![Screenshot](https://raw.githubusercontent.com/cgoldberg/talend-task/refs/heads/main/screenshots/screenshot-terminal-activity-mode.png)

----

### Python API Client

Use the `TalendClient` class to interact with Talend Cloud from Python.

See the [API documentation][api-docs] for details.

### Example Client Usage

```python
from talend_task import TalendClient

api_url = "https://api.us.cloud.talend.com"
access_token = "SECRET"

with TalendClient(api_url, access_token) as client:
    job_id = client.get_job_id("Job_123")
    status = client.run(job_id, wait=True)
```

[github-repo]: https://github.com/cgoldberg/talend-task
[pypi-home]: https://pypi.org/project/talend-task
[api-docs]: https://coreygoldberg.com/talend-task
[qlik-home]: https://qlik.com
[talend-cloud]: https://talend.com
[talend-processing-api]: https://talend.qlik.dev/apis/processing/2021-03
