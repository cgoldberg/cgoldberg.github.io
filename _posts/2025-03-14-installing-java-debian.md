---
title: Installing OpenJDK on Debian (Linux)
description: How to install OpenJDK (Java) on Debian Stable (Linux)
date: 2025-03-14
tags: [programming, java]
---

I am running Debian Stable (AKA Debian 12 Bookworm for AMD64 64-bit) as my Linux Distro. I need to do some Java development, so I need a Java JDK/JRE. I prefer OpenJDK to the Oracle JDK... so here are some quick instructions for getting it setup.

In the Debian Stable Apt repositories, you can find OpenJDK 17. If this is sufficient, you can install it by simply running:

```bash
$ sudo apt install default-jdk
```

That will install the JDK and JRE. If you only need the JRE, you can run:

```bash
$ sudo apt install default-jre
```

If you need a newer version of OpenJDK, you can get it from the Azul Zulu Apt repo. First, you need to add the external repository:

```bash
$ sudo apt install extrepo
$ sudo extrepo enable zulu-openjdk
$ sudo apt update
```

Next, install `zulu<major_version>-jdk` (or `zulu<major_version>-jre` if you only need the JRE). For example, to install OpenJDK 21, you can run:

```bash
$ sudo apt install zulu21-jdk
```

You can verify it is installed correctly by running:

```bash
$ javac --version
```
That's it!

Note: These instructions should also work on Ubuntu.
