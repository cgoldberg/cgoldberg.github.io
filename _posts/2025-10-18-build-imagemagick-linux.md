---
title: Building ImageMagick From Source
description: Compiling ImageMagick source code on Linux
date: 2025-10-18
tags: [linux, debian, raspberry-pi]
---

[ImageMagick](https://imagemagick.org) is a free, open-source software suite,
used for editing and manipulating digital images. It includes several
command-line tools and APIs that are very useful for image processing tasks
(creating, editing, converting, and displaying images in 200+ formats).

The [official downloads](https://imagemagick.org/script/download.php) include
binaries for many platforms. Annoyingly, they only offer an
[AppImage](https://appimage.org) for Linux that runs on x86-64. Since I want
to use it on a Raspberry Pi running on ARM64, that doesn't help. Raspberry Pi
OS is based on Debian, so you can simply install ImageMagick from the official
repos with:

```console
sudo apt install imagemagick
```

However, the version you get might be older than you would like.

So how do you get the latest version on a Linux ARM64 system? Use the source,
Luke!

Building ImageMagick from its source code is pretty easy. This will compile all
the executables and install them on your system. (these instructions are for
Debian based systems - Ubuntu, Mint, etc - but similar steps should work on any
Linux distro)

First, we need to install a C compiler toolchain, VCS, and some dependency
libraries:

```console
sudo apt install build-essential git libjpeg-dev libpng-dev
```

Next, we can download the source code:

```console
git clone --depth 1 https://github.com/ImageMagick/ImageMagick.git
```

This will get the latest code from the official repository. We are going
to build the `main` branch in its current state (under development). If you
want to build a previously released version, you should do a full clone
(remove `--depth 1`) and checkout a
[specific tag](https://github.com/ImageMagick/ImageMagick/tags).

Once we have the code, we can move to its directory and configure the build:

```console
cd ImageMagick
./configure
```

Now, let's compile the executables:

```console
make
```

(this will take several minutes)

The binaries are now compiled and we can install them. This will move the files
(executables and shared libraries) to the appropriate locations on your system
and create the necessary links and cache:

```console
sudo make install
sudo ldconfig /usr/local/lib
```

That's it! The following command should now run succesfully:

```console
magick --version
```

ImageMagick is now ready to use.
