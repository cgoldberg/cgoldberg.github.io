---
title: Controlling Squeezbox From The Terminal
description: Using the Lyrion Music  Server API from Bash with Curl
date: 2025-12-18
tags: [music, bash]
---

![Squeezebox Touch](/assets/img/posts/2025-12-18_squeezebox_touch.jpg){: .right w="250"}

This is a tutorial on controlling a Squeezebox music player from the command
line via [Lyrion Music Server](https://lyrion.org) (LMS) JSON-RPC API. There
are lots of ways to control a Squeezbox: from the device itself, LMS web
interface, LMS CLI, IR remote control, and various mobile apps. However, I'm
in a Linux terminal all day and just need a few commands to control my music
without intalling the CLI or opening a web page. I just want the following
one-letter shell commands:

- `s` - show current playing track
- `m` - play a random shuffled mix
- `n` - skip to the next track
- `p` - pause/resume

###  What is a Squeezebox and what is Lyrion Music Server?

Squeezebox is a network music player (streamer). It began its life as the
SliMP3, introduced in 2001 by Slim Devices. It had an ethernet interface
and played MP3 music files from a media server. In 2006, Slim Devices was
acquired by Logitech, and they sold many new versions of the Squeezebox that
included features like support for more media formats, WiFi, digitial output,
touch-screen interfaces, etc.

The
[hardware was discontinued](https://lyrion.org/players-and-controllers/#squeezebox-hardware-discontinued)
in 2012, but there are still many ways to use a Squeezebox (besides buying an
old one). Several companies manufacture
[compatible streamers and amps](https://lyrion.org/players-and-controllers/#other-hardware)
, and many people build their own compatible players using a Raspberry Pi or
similar cheap single-board computers or mini-PCs that run a
[software based player](https://lyrion.org/players-and-controllers/#software-based-players).

To use a Squeezebox, you need to connect it to a cpmpatible media server. Over
the years, the official server has been renamed many times: SlimServer, Squeezebox
Server, SqueezeCenter, Logitech Media Server, and now Lyrion Music Server. It
has many plugins to connect with online streaming services, and allows you to
index and play your own music collection. It runs on several different
platforms, and is really easy to setup. I run it via Docker on a QNAP NAS.

Thankfully, the original server code and most of the associated utilites were
released under an open source license
(mostly [GPLv2](https://www.gnu.org/licenses/old-licenses/gpl-2.0.html)), and
it lives on today! The server is written in Perl 5 and still has pretty active
development on [GitHub](https://github.com/LMS-Community/slimserver) with
regular releases.

### Using the JSON-RPC API

To control it from the terminal, I use simple command-line tools:

- [bash](https://www.gnu.org/software/bash) (shell)
- [curl](https://curl.se) (http client)
- [jq](https://jqlang.org) (json parser)

These should all be available or easily installed on any Linux distro, macOS,
Windows (via MSYS2, Git-Bash, or WSL2), or almost any other platform.

To contol the player, you need to know 2 things:

- Lyrion Music Server IP address and port (default port is `9000`)
- Squeezebox MAC address

Then you can control the player by sending HTTP POST requests with a JSON
payload to the `http://<IP>:<PORT>/jsonrpc.js` endpoint.

#### Example

My LMS server and Squeezebox player are both connected to my local network. The
IP address of my server is `10.0.0.100` (default port `9000`), and the MAC
address of my Squeezebox is `00:04:20:23:82:6f`. With this `curl` command, I
can send pause my player:

```shell
curl -d '{"method":"slim.request","params":["00:04:20:23:82:6f",["pause"]]}' \
    http://10.0.0.100:9000/jsonrpc.js
```

#### Code

To implement the commands I wanted, I created a file with some Bash functions
and gave them really short aliases. I save this as `~/.bashrc_squeezebox` and
in my `~/.bashrc`, I add `source ~/.bashrc_squeezebox`.

Now, I can just type a one-letter command into my terminal:

- `s <enter>` (show current playing track)
- `m <enter>` (play a random shuffled mix)
- `n <enter>` (skip to the next track)
- `p <enter>` (pause/resume)

```bash
# =============================================================
# Bash functions and aliases for controlling Squeezebox via LMS
# - requires: curl, awk, jq
# =============================================================


LMS_URL="http://10.0.0.100:9000"
SQUEEZEBOX_MAC="00:04:20:23:82:6f"


# send request to Squeezebox player API on local nextwork
send-squeezebox-cmd () {
    local command="$1"
    local payload='{
            "method": "slim.request",
            "params": [
                "'"${SQUEEZEBOX_MAC}"'",
                '"${command}"'
            ]
    }'
    lms_result="$(
        curl \
            --fail \
            --ipv4 \
            --silent \
            --retry 0 \
            --connect-timeout 3 \
            --max-time 7 \
            --data "${payload}" \
            "${LMS_URL}/jsonrpc.js" \
    )"
    if [ -z "${lms_result}" ]; then
        echo "can't reach LMS or Squeezebox"
        return 1
    fi
}


# show currently playing track on Squeezebox player
squeezebox-show () {
    if send-squeezebox-cmd '["status", "-", 1, "tags:a"]'; then
        jq -r '.result.playlist_loop | .[0] | "\(.artist) - \(.title)"' \
            <<< "${lms_result}" \
            | awk '{print "\033[1m" $0 "\033[0m"}'
    fi
}
alias s=squeezebox-show


# skip to next track in playlist on Squeezebox player
squeezebox-next () {
    if send-squeezebox-cmd '["button", "jump_fwd"]'; then
        squeezebox-show
    fi
}
alias n=squeezebox-next


# play random song mix on Squeezebox player
squeezebox-mix () {
    if send-squeezebox-cmd '["randomplay", "tracks"]'; then
        squeezebox-show
    fi
}
alias m="squeezebox-mix"


# pause/resume audio on Squeezebox player
squeezebox-pause () {
    send-squeezebox-cmd '["pause"]'
}
alias p="squeezebox-pause"
```
{: file='.bashrc_squeezebox'}
