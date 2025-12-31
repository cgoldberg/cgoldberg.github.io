---
title: Selenium - Year In Development (2025)
description: '"the reports of our death are greatly exaggerated"'
date: 2025-12-31
tags: [programming, selenium, testing, open source]
---

Happy New Year everyone!

![Seleium Logo](/assets/img/posts/2025-12-31_selenium_logo.png){: .right w="100"}

I have been using [Selenium](https://selenium.dev) for browser automation
since 2006. I made my first code contribution to the project in 2011 and
became a maintainer in 2016. I took a break for quite a while, but stepped
back into working on Selenium development with a vengance in 2025 (I had 94 of
[my pull
requests](https://github.com/search?q=org%3ASeleniumHQ+author%3Acgoldberg&type=pullrequests)
were merged this year).

We had active year in development: shipping 15 releases, adding new code and
features, fixing bugs, improving testing and CI infrastructure, and generally
making everything better for all of our users. It has been great participating
in an active community-driven open source project. Hopefully, we crush 2026 by
shipping Selenium 5 with
(BiDi)[https://www.selenium.dev/documentation/webdriver/bidi]!

Here are some stats of our
[development work](https://github.com/SeleniumHQ/selenium) for the year:

```console
GitHub repo: https://github.com/SeleniumHQ/selenium


All-time stats
--------------
Age: 21 years, 2 months
Commits: 33,753
Contributors: 935


Activity in 2025
----------------
Commits: 1,333
Contributors: 74


Contributors per language in 2025
---------------------------------
.NET:     12
Java:     36
JS:       15
Python:   36
Ruby:     19
Rust:     6
Shell:    9


Lines modified per language in 2025
-----------------------------------
.NET:    128,145 (+65,089/-63,056)
Java:    35,049 (+21,287/-13,762)
JS:      720,891 (+135,666/-585,225)
Python:  29,569 (+19,499/-10,070)
Ruby:    5,820 (+3,667/-2,153)
Rust:    1,442 (+1,077/-365)
Shell:   209 (+134/-75)


Top contributors for .NET in 2025:
┌─────────────────────────────────────────────────────┐
│Author                            Last Edit   Commits│
├─────────────────────────────────────────────────────┤
│Nikolay Borisenko                 6 days ago      145│
│Michael Render                    2 weeks ago      91│
│Diego Molina                      4 mon. ago        8│
│Puja Jagani                       8 mon. ago        3│
│Corey Goldberg                    3 mon. ago        2│
│...6 more...                                         │
└─────────────────────────────────────────────────────┘


Top contributors for Java in 2025:
┌─────────────────────────────────────────────────────┐
│Author                            Last Edit   Commits│
├─────────────────────────────────────────────────────┤
│Andrei Solntsev                   1 day ago        30│
│Viet Nguyen Duc                   3 weeks ago      30│
│Diego Molina                      2 mon. ago       29│
│mk868                             3 weeks ago      28│
│Swastik Baranwal                  6 days ago       17│
│...30 more...                                        │
└─────────────────────────────────────────────────────┘


Top contributors for JS in 2025:
┌─────────────────────────────────────────────────────┐
│Author                            Last Edit   Commits│
├─────────────────────────────────────────────────────┤
│Navin Chandra                     4 mon. ago        8│
│Puja Jagani                       6 mon. ago        7│
│Sri Harsha                        9 mon. ago        7│
│Simon Stewart                     1 week ago        4│
│Diego Molina                      2 mon. ago        4│
│...9 more...                                         │
└─────────────────────────────────────────────────────┘


Top contributors for Python in 2025:
┌─────────────────────────────────────────────────────┐
│Author                            Last Edit   Commits│
├─────────────────────────────────────────────────────┤
│Corey Goldberg                    9 min. ago       94│
│Navin Chandra                     2 days ago       41│
│Diego Molina                      3 weeks ago      17│
│Swastik Baranwal                  1 month ago      14│
│Simon Benzer                      6 mon. ago       11│
│...30 more...                                        │
└─────────────────────────────────────────────────────┘


Top contributors for Ruby in 2025:
┌─────────────────────────────────────────────────────┐
│Author                            Last Edit   Commits│
├─────────────────────────────────────────────────────┤
│Titus Fortner                     2 weeks ago      45│
│Augustin Gottlieb                 2 weeks ago      18│
│Diego Molina                      3 weeks ago      10│
│Andrei Solntsev                   2 weeks ago       6│
│Alex Rodionov                     7 mon. ago        4│
│...13 more...                                        │
└─────────────────────────────────────────────────────┘


Top contributors for Rust in 2025:
┌─────────────────────────────────────────────────────┐
│Author                            Last Edit   Commits│
├─────────────────────────────────────────────────────┤
│Boni García                       2 mon. ago       21│
│Titus Fortner                     3 hr. ago         2│
│Nikolay Borisenko                 5 mon. ago        1│
│Diego Molina                      6 mon. ago        1│
│Simon Stewart                     9 mon. ago        1│
└─────────────────────────────────────────────────────┘


Top contributors for Shell in 2025:
┌─────────────────────────────────────────────────────┐
│Author                            Last Edit   Commits│
├─────────────────────────────────────────────────────┤
│Corey Goldberg                    3 mon. ago        6│
│Titus Fortner                     32 min. ago       5│
│Noritaka Kobayashi                5 mon. ago        1│
│Augustin Gottlieb                 6 mon. ago        1│
│Alex Rodionov                     7 mon. ago        1│
│...4 more...                                         │
└─────────────────────────────────────────────────────┘
```

GitHub Gist: [selenium-repo-stats.sh](https://gist.github.com/cgoldberg/501c40bf8e84838f04811ab5ab0da47a)
