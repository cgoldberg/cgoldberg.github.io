---
title: Building a WebDriver Client in Bash
description: Controlling a web browser with Bash and Curl
date: 2025-08-10
tags: [programming, selenium, webdriver, bash, chrome]
---

*Disclaimer: there is probably no reason you would ever want to roll your own
WebDriver client in Bash. There are plenty of clients available in many
languages that are robust and well-tested, including official clients from the
Selenium project in Java, Python, C#, JavaScript, and Ruby. This post simply
explores how WebDriver works.*

### How WebDriver works

[Selenium](https://selenium.dev)
[WebDriver](https://selenium.dev/documentation/webdriver) allows you to
programtically control (automate) a web browser.

Traditionally, Selenium's client code communicates with a vendor provided
binary "WebDriver" (i.e. `chromedriver`, `geckodriver`) that in turn
communicates with a browser to control its actions. Commands are sent to the
driver using HTTP requests, as defined in the
[W3C WebDriver](https://w3c.github.io/webdriver) spec.

This model (AKA "WebDriver Classic") is currently how most of Selenium's
browser automation works. However, that is [slowly] changing with the
introduction of Selenium WebDriver's
[BiDirectional functionality](https://selenium.dev/documentation/webdriver/bidi/)
(AKA "WebDriver BiDi"). This new model is defined in the [W3C WebDriver
BiDi](https://w3c.github.io/webdriver-bidi) spec. Rather than using HTTP with
request/response commands, BiDi uses WebSockets for asynchronous interaction
with the underlying browser.

Many features of WebDriver Bidi are available right now, and more will be
available soon. However, we can still use WebDriver Classic, and that is
what this article deals with.

### Running chromedriver

When using modern versions of Selenium, the process of downloading, installing,
and managing the underlying WebDriver is handled for you via
[Selenium Manager](https://www.selenium.dev/documentation/selenium_manager).
In most cases, you can just use Selenium client code and forget about the
WebDriver binary even existing. However, if you wanted to, you could run the
WebDriver binary yourself and use it without Selenium's client code.

For example, you could use `chromedriver` to control a Chrome browser. For
this, you will need to download a `chromedriver` binary for your platform
that matches the version of Chrome you are running. You can find links to all
the `chromedriver` binaries on the
[Chrome for Testing availability dashboard](https://googlechromelabs.github.io/chrome-for-testing).

Once you have downloaded and extracted the binary, you can run it from the
command line. Normally, `chromedriver` picks a random port and listens for
requests. To make things easier for this, you can specify a port when starting
it:

```shell
./chromedriver --port=9999
```

### Controlling Chrome

Once `chromedriver` is running, you can send it commands via HTTP to specify
what you want it to do. You can use any HTTP client to do this. Here we will
use `curl`, since it is probably the most common HTTP CLI and available on
most systems.

Using curl, you can control the browser by sending HTTP requests to various
endpoints. For example, to launch a Chrome browser, you can send:

```shell
curl -sS \
  --header "Content-Type: application/json" \
  --request "POST" \
  --data '{"capabilities": {"alwaysMatch": {"browserName": "chrome"}}}' \
  "http://localhost:9999/session"
```

This will return an HTTP response with a body containing a JSON payload. Inside
the JSON blob, you will find a `sessionId`. This is used in subsequest requests
so you can communicate withe same browser you just launched.

Now that the browser is running, you can control it using any of the available
WebDriver commands. For example, to navigate to a web page, you can send this
command:

```shell
curl -sS \
  --header "Content-Type: application/json" \
  --request "POST" \
  --data '{"url": "https://example.com"}' \
  "http://localhost:9999/session/8794755b97ffe374e837b21d9dbed095/url
```

Note that in this case, we are communicating with `chromedriver` running on the
local machine (localhost). However, you could just as easily run it on a
different host and use the remote host's IP address or hostname.

### Writing a Bash WebDriver client

Now that you know how to talk to a WebDriver, you can build a simple Bash
client using command line tools like [curl](https://curl.se) and
[jq](https://jqlang.org).

Here is an example Bash WebDriver client. It only implements a few functions:

- `launch_browser` - launch the specified browser
- `quit_browser` - exit the browser
- `goto` - navigate to a web page
- `get_title` - print the page title

```bash
# Bash WebDriver
# requires: bash, curl, jq

# defaults
HOST='localhost'
PORT='9999'

send_command () {
    local wd_url="$1"
    local method="$2"
    local data="$3"
    local value=$(
        curl -sS \
          --header 'Content-Type: application/json' \
          --request "${method}" \
          --data "${data}" \
          "${wd_url}" \
        | jq -r '.value'
      )
      local try_session=$(jq -r '.sessionId' 2>/dev/null <<< "${value}")
      if [ -n "${try_session}" ] && [ "${try_session}" != "null" ]; then
          SESSION_ID="${try_session}"
      fi
      if [ -z "${endpoint}" ]; then
          value="null"
      fi
      if [ "${value}" != "null" ]; then
          echo "${value}"
      fi
}

launch_browser () {
    local browser="$1"
    local wd_url="http://${HOST}:${PORT}/session"
    local data='{"capabilities": {"alwaysMatch": {"browserName": "'"${browser}"'"}}}'
    send_command "${wd_url}" 'POST' "${data}"
}

quit_browser () {
    local wd_url="http://${HOST}:${PORT}/session/${SESSION_ID}"
    send_command "${wd_url}" 'DELETE' '{}'
}

goto () {
    local url="$1"
    local wd_url="http://${HOST}:${PORT}/session/${SESSION_ID}/url"
    send_command "${wd_url}" 'POST' '{"url": "'"${url}"'"}'
}

get_title () {
    local wd_url="http://${HOST}:${PORT}/session/${SESSION_ID}/title"
    send_command "${wd_url}" 'GET' '{}'
}
```
{: file='webdriver.sh'}

Here is an example script using the Bash WebDriver client:

```bash
#!/usr/bin/env bash

source ./webdriver.sh

launch_browser 'chrome'
goto 'https://example.com'
title="$(get_title)"
quit_browser
```
{: file='test.sh'}

Now that you understand how it works, save yourself the trouble and go
download one of the official
[Selenium WebDriver clients](https://www.selenium.dev/downloads) for your
language of choice... not Bash!
