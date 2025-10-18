---
title: Connecting to Android with SSH
description: Running an SSH server with Termux
date: 2025-08-17
tags: [android, linux]
---

[Secure Shell Protocol](https://en.wikipedia.org/wiki/Secure_Shell) (SSH) is a
way to securely access a server for remote login or command execution. I
recently wanted to use [rsync](https://rsync.samba.org) for copying data to my
Android phone. Since Android is based on Linux, it's very easy to use standard
Linux tools on your device.

To access your device with SSH, you need to run an SSH server. There are many
ways to do this on Android, but the easiest way I found was running
[OpenSSH](https://www.openssh.com) through [Termux](https://termux.dev).

Termux is an Android application that provides a terminal emulator and many
Linux tools. You can use it without root access and it lets you install and
run many familiar Linux packages.

The easiest way to get Termux is from [F-Droid](https://f-droid.org). You can
either install the F-Droid app and search for Termux, or just download/install
the Termux APK directly from the
[F-Droid catalogue](https://f-droid.org/en/packages/com.termux).

Once you have Termux installed, open it up, and you will be at a Bash command
prompt.

### Update and allow storage access

You should start by updating the package list:

```shell
pkg update
```

Next, grant Termux storage permissions so it can access your filesystem:

```shell
termux-setup-storage
```

(you will get a popup asking you to allow access)

### Find your IP and username

You will need to know your device's IP address and username to connect to it.
The following commands will give you that information:

```shell
ifconfig
whoami
```

(make sure you are connected to your network via WiFi so you are getting a
LAN IP)

### Install OpenSSH and set a password

Next, install the OpenSSH server:

```shell
pkg install openssh
```

If you don't want to mess with SSH keys, you can just set a password for
connections:

```shell
passwd
```

Now, you can run the SSH server:

```shell
sshd
```

(it listens on port 8022 by default)

### Connecting to your device with SSH

At this point, an SSH server is running that you connect to from any device
on your network running an SSH client.

For example, on my Linux laptop, I can simply run:

```shell
ssh <username>@<ip> -p <port>
```

For example:

```shell
ssh u0_a142@10.0.0.200 -p 8022
```

After verifying the host identity and entering my password, I am remotely
logged into the Android device and at a Bash shell prompt.

That's it!
