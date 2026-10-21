---
title: How to Publish a Python Package on PyPI
description: Releasing a new Python Package on PyPI (Python Package Index)
date: 2025-03-25
tags: [programming, python]
---

> [PyPI Trusted Publishing](https://docs.pypi.org/trusted-publishers/)
is the modern recommended way to publish packages when supported by your CI
provider. This guide covers manual publishing, which is still useful for
understanding the publishing process and for situations where Trusted Publishing
isn't an option.
{: .prompt-warning }

This guide covers the steps for packaging and publishing Python software on
[PyPI][pypi] (Python Package Index) using the traditional Python toolchain.
The instructions were developed on Linux but should be broadly applicable to
other operating systems.

[Python Package Index][pypi] (PyPI) is a repository of software for the Python
programming language. It contains over 600k Python packages. PyPI allows
package authors to distribute their software by
[publishing packages][packaging]. Python users can then easily download or
[install][installing] them with common Python tools.

This guide assumes you have a project hosted in a public repository on
[GitHub][github] that you would like to publish. Your project must contain a
packaging configuration file
([`pyproject.toml`][pyproject] or the older `setup.py`).

These are the steps to tag, build, and release:

- Update the version number in your packaging configuration file
- Tag a new release and push it to GitHub:

```
git fetch --tags
git tag  # view tags
git tag <version>
git push origin <version>
```

(the version tag identifies the commit associated with the release)

- Create a new virtual environment and install the dependencies:

```
python3 -m venv
source venv/bin/activate
pip install --upgrade build pip twine
```

- Build the package:

```
python -m build
```

(this will build a source distribution (sdist) and binary distribution (wheel)
in the `dist` directory)

- Validate the built distributions:

```
python -m twine check dist/*
```

- Generate an [API token][api-token]
- Upload the new packages to PyPI:

```
python -m twine check dist/*
python -m twine upload --repository pypi dist/*
```

(enter the API token when prompted)

After upload completes, the new package will be available to install with
`pip install <package>` (or `--upgrade`).

The content of your `readme` from `pyproject.toml` will be viewable in a
browser at: `https://pypi.org/project/<package>/<version>/`.

After publishing a new release, you should bump the version number in your repo
to a development version to signify a new version is open for development.

> **Note**: Newer tools offer alternatives to the traditional Python toolchain,
simplifying and automating the build, packaging, and publishing process.
Reusable workflows are also available on most CI platforms to streamline
publishing and improve security.
{: .prompt-info }

[installing]: https://packaging.python.org/en/latest/tutorials/installing-packages
[packaging]: https://packaging.python.org/en/latest/tutorials/packaging-projects
[pypi]: https://pypi.org
[api-token]: https://pypi.org/manage/account/#api-tokens
[pyproject]: https://packaging.python.org/en/latest/guides/writing-pyproject-toml
[github]: https://github.com
