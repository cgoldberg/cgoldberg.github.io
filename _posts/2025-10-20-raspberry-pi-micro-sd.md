---
title: Create a Micro SD Card With a Raspberry Pi OS Image
description: Make a bootable card from the Linux comnmand line
date: 2025-10-20
tags: [linux]
---

### Overview

[Raspberry Pi](https://www.raspberrypi.com) uses a Micro SD card for storage.
This is your "hard drive" that the operating system and all your files are
stored on. There are several Linux distros you can choose to run, but
[Raspberry Pi OS](https://www.raspberrypi.com/documentation/computers/os.html)
(based on [Debian](https://www.debian.org) stable) is the official supported
operating system. You will need a copy of this on your Micro SD card to boot
your Pi. There are lots of tools for creating a useable card, but I think it's
easiest to just make one from the command line if you already have a Linux
system.

### Tips for buying an SD card

The faster your Micro SD card is, the better your system will run. During
normal use, there will be a lot of reads/writes to the card, so they might
eventually wear out or get corrupted. Look for cards that are labeled
"Industrial" or "Endurance" for the longest life-span.

### Creating the Micro SD card disk image

1. Download the latest OS from:
    - https://www.raspberrypi.com/software/operating-systems
2. Uncompress the `.xz` archive to extract the image:
    - `sudo apt install xz-utils` or similar (if needed)
    - `unxz <filename>.xz`
3. Insert the SD card or a USB adapter containing the SD card
4. Run `df` to find the device name
    - make sure to use device name, not partition (i.e. `/dev/sda`, not `/dev/sda1`)
5. Write the image to the SD card
    - this will completely wipe the card (no need to format it beforehand)
    - `sudo dd if=/path/to/<IMAGE>.img of=/dev/<DEVICE> bs=4M status=progress`
    - example: `sudo dd if=./2025-10-01-raspios-trixie-arm64.img of=/dev/sdc bs=4M status=progress`
6. Wait for the image to finish writing
    - it writes to disk asynchronously, so when the command returns, it is not finished writing
    - watch for the disk i/o to complete with: `iostat -p 1`
7. Safely eject the SD card
