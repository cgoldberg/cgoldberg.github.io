---
title: Chrome Performance Logs with Selenium and Python
description: Analyzing browser performance logs
date: 2025-08-07
tags: [chrome, programming, python, selenium, performance]
---

This is an introduction to using [Chrome](https://www.google.com/chrome)
performance logs with [Selenium](https://www.selenium.dev/selenium/docs/api/py)
and [Python](https://python.org). Browser performance logs contain timing data
and other information that are captured during web page loads. It is similar to
what you see in Chrome [DevTools](https://developer.chrome.com/docs/devtools)
Network tab.

This requires the [selenium](https://pypi.org/project/selenium)
package (client bindings) for Python used to automate your browser.

To access performance logs with Selenium, you first need to create a
driver instance with the performance logging preference enabled:

```python
from selenium import webdriver

options = webdriver.ChromeOptions()
options.set_capability("goog:loggingPrefs", {"performance": "ALL"})
driver = webdriver.Chrome(options=options)
```

You can then navigate to a URL and get the performance log containing network
request information for the page that was loaded:

```python
driver.get("https://example.com")
log = driver.get_log("performance")
```

This returns a list of dictionaries containing log entries. The pertinent log
message is in a JSON blob that can be accessed with the `message` key in each
dictionary. You can parse the JSON blob and load it into a dictionary. From
there, the actual log message is in a nested dictionary accessed by another
`message` key. You can then access the message's `method` (string) and `params`
(dictionary).

Here is an example of accessing each log message's `method` and `params`:

```python
import json
from selenium import webdriver

URL = "https://example.com"

options = webdriver.ChromeOptions()
options.set_capability("goog:loggingPrefs", {"performance": "ALL"})
driver = webdriver.Chrome(options=options)
driver.get(URL)

for entry in driver.get_log("performance"):
    message = json.loads(entry["message"])["message"]
    method = message["method"]
    params = message["params"]
```

The methods captured are:
- `Network.dataReceived`
- `Network.loadingFinished`
- `Network.policyUpdated`
- `Network.requestServedFromCache`
- `Network.requestWillBeSent`
- `Network.requestWillBeSentExtraInfo`
- `Network.responseReceived`
- `Network.responseReceivedExtraInfo`
- `Page.domContentEventFired`
- `Page.frameNavigated`
- `Page.frameResized`
- `Page.frameStartedLoading`
- `Page.frameStartedNavigating`
- `Page.frameStoppedLoading`
- `Page.loadEventFired`

The `params` associated with each of these contain different information and
timestamps for network requests/responses and page load events. You can use
this data to analyze and profile network and page load performance for your
website.

Here is an example of using Chrome performance logs to report the domains
accessed and URLs requested when loading the page at
[https://selenium.dev](https://selenium.dev):

```python
#!/usr/bin/env python3
#
# print a report of domains accessed and URLs requested during a
# web page load in Chrome browser.
#
# author: Corey Goldberg - https://github.com/cgoldberg

import json
from urllib.parse import urlparse

from selenium import webdriver


def load_page(url):
    """Loads a web page and retrieves the performance log."""
    options = webdriver.ChromeOptions()
    options.set_capability("goog:loggingPrefs", {"performance": "ALL"})
    with webdriver.Chrome(options=options) as driver:
        driver.get(page_url)
        log = driver.get_log("performance")
    return log


def get_urls_and_domains(perf_log):
    """Gets lists of domains and URLs from requests in performance log."""
    domains = set()
    urls = []
    for entry in perf_log:
        message = json.loads(entry["message"])["message"]
        if message["method"] == "Network.requestWillBeSent":
            url = message["params"]["request"]["url"]
            domain = urlparse(url).netloc
            if domain:
                urls.append(url)
                domains.add(domain)
    return sorted(domains), sorted(urls)


if __name__ == "__main__":
    page_url = "https://selenium.dev"

    perf_log = load_page(page_url)
    domains, urls = get_urls_and_domains(perf_log)

    print(f"network requests when loading '{page_url}':\n")
    print(f"{len(domains)} domains:")
    for domain in domains:
        print(f" - {domain}")
    print()
    print(f"{len(urls)} urls:")
    for url in urls:
        print(f" - {url}")
```

When you run this script, the output looks like:

```
network requests when loading 'https://selenium.dev':

8 domains:
 - cdn.jsdelivr.net
 - code.jquery.com
 - fonts.googleapis.com
 - fonts.gstatic.com
 - plausible.io
 - selenium.dev
 - www.netlify.com
 - www.selenium.dev

23 urls:
 - https://cdn.jsdelivr.net/npm/@docsearch/css@3.6.0
 - https://cdn.jsdelivr.net/npm/@docsearch/js@3.6.0
 - https://code.jquery.com/jquery-3.7.1.min.js
 - https://fonts.googleapis.com/css?family=Encode+Sans:300,300i,400,400i,700,700i&display=swap
 - https://fonts.gstatic.com/s/encodesans/v22/LDIhapOFNxEwR-Bd1O9uYNmnUQomAgE25imKSbHLSMA6.woff2
 - https://plausible.io/js/plausible.js
 - https://selenium.dev/
 - https://www.netlify.com/v3/img/components/netlify-light.svg
 - https://www.selenium.dev/
 - https://www.selenium.dev/css/prism.css
 - https://www.selenium.dev/favicons/favicon.ico
 - https://www.selenium.dev/images/sponsors/applitools.png
 - https://www.selenium.dev/images/sponsors/bright-data.png
 - https://www.selenium.dev/images/sponsors/browserstack.png
 - https://www.selenium.dev/images/sponsors/lambda-test.png
 - https://www.selenium.dev/images/sponsors/saucelabs.png
 - https://www.selenium.dev/js/docsearch-fix.js
 - https://www.selenium.dev/js/main.min.0a56205ed1c75268f017591e5418fdb944578a279fe7c7abe3981ebed191c341.js
 - https://www.selenium.dev/js/prism.js
 - https://www.selenium.dev/js/tabpane-persist.js
 - https://www.selenium.dev/scss/main.min.6d9ec00f116673042486c0086bf8ce0719532a8bb9d972fe34e86be6010ccb3c.css
 - https://www.selenium.dev/webfonts/fa-brands-400.woff2
 - https://www.selenium.dev/webfonts/fa-solid-900.woff2
```
