---
title: How to Publish a Python Package on PyPI
description: Instructions for releasing a new Python Package on PyPI (Python Package Index)
date: 2025-03-25
tags: [programming, python]
---

This is basically for my own reference (because I always forget the steps), but
here are instructions for packaging and publishing Python software on
[PyPI][pypi] (Python Package Index). These instructions were created using
Linux, but should generally be the same for any operating system.

[Python Package Index][pypi] (PyPI) is a repository of software for the Python
programming language. It contains over 600k Python packages. PyPI allows
package authors to distribute their software by
[publishing packages][packaging]. Python users can then easily download or
[install][installing] them with common Python tools.

This guide assumes you have a project hosted in a public repository on
[GitHub][github] that you would like to publish. Your project must contain a
packaging configuration file
([`pyproject.toml`][pyproject] or the older `setup.py`).


These are the steps I follow to tag, build, and release:

- Update the version number in your packaging configuration file
- Tag a new release and push it to GitHub:

```console
git fetch --tags
git tag <version number>
git tag # to view tags
git push origin --tags
```
(setting a tag with a version number lets users know which commit coressponds
with the release)

- Create a new virtual environment and install the dependencies:

```console
python3 -m venv
source venv/bin/activate
pip install --upgrade build pip twine
```
- Build the package:

```console
python -m build
```

(this will build a Source Distribution (sdist) and Binary Distribution (wheel) in the `dist` directory)

- Generate an [API token][api-token] on PyPI (create an account first if needed)
- Upload the new package to PyPI:

```console
python -m twine check dist/*
python -m twine upload --repository pypi dist/*
```

(enter the API token when prompted)

Done!

Your package should now be available on PyPI.

----

Note: You can automate this process to make publishing easier. There are workflows available
on GitHub Actions or your CI tool of choice that will accomplish roughly the same thing.

[installing]: https://packaging.python.org/en/latest/tutorials/installing-packages
[packaging]: https://packaging.python.org/en/latest/tutorials/packaging-projects
[pypi]: https://pypi.org
[api-token]: https://pypi.org/manage/account/#api-tokens
[pyproject]: https://packaging.python.org/en/latest/guides/writing-pyproject-toml
[github]: https://github.com
