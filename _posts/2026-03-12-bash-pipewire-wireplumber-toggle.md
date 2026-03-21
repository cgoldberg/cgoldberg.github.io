---
title: Linux - Toggle PipeWire Audio Output
description: Switch between 2 audio devices with WirePlumber CLI
date: 2026-03-21
tags: [bash, linux]
---

Most modern Linux desktop systems use PipeWire for managing audio streams.
WirePlumber is a session manager for PipeWire.

On my Debian system, I sometimes listen to audio through my headphones
(plugged into the 1/8-inch jack in my monitor), and sometimes through a set
of small speakers (plugged into a USB DAC). I need a simple way to switch
back and forth between USB and HDMI output without opening a GUI or running
several shell commands. This small Bash script is what I came up with. I just
run it, and it toggles audio output between the 2 devices. I assigned a
keyboard shortcut (F12) in Gnome, so I can run it by pressing a key.

This script uses the WirePlumber Control CLI (`wpctl`) to achieve this. To set
it up, you need to know the ID for the 2 audio sinks you want to switch
between.

To find them, run:

```console
wpctl status
```

Look for the `Sinks` section in the output. You should see a section like this:

```console
 ├─ Sinks:
 │      35. PCM2704C stereo audio DAC Digital Stereo (IEC958) [vol: 0.65]
 │  *   57. Radeon High Definition Audio Controller [Rembrandt/Strix] Digital Stereo (HDMI) [vol: 0.51]
```

In my case, the ID's are `35` and `37`. I set these as values for
`HEADPHONE_SINK` and `SPEAKER_SINK` in my script. The rest of the logic sets
the default sink to whichever one is not currently in use and moves the
currently playing stream to it:

```bash
#!/usr/bin/env bash
#
# Toggle PipeWire audio output device/sink
#
# - uses WirePlumber to switch audio output between HDMI (headphones) and
#   USB DAC (speakers)

HEADPHONE_SINK=35 # HDMI
SPEAKER_SINK=57 # USB DAC

current_sink=$(wpctl status | awk '
    /\*/ {
        match($0, /[0-9]+\./)
        if (RSTART) { print substr($0,RSTART,RLENGTH); exit }
    }
' | tr -d '.')

if [ "${current_sink}" = "${HEADPHONE_SINK}" ]; then
    new_sink="${SPEAKER_SINK}"
else
    new_sink="${HEADPHONE_SINK}"
fi

wpctl set-default "${new_sink}"

# move currently playing audio streams to the new sink
wpctl status | awk '
    /Streams:/ {in_streams=1}
    /Video/ {in_streams=0}
    in_streams && /^[[:space:]]*[0-9]+\.\s+output/ {
        match($0, /[0-9]+\./)
        if (RSTART) print substr($0,RSTART,RLENGTH)
    }
' | tr -d '.' | xargs -r -I{} wpctl set {} "${new_sink}"

echo "switched audio output to sink ${new_sink}"
```
{: file='toggle-audio-sink.sh'}

Now I can toggle my audio output between headphones and speakers by pressing
a key that runs this script!
