---
title: When Reviewing Selenium Code
description: Making the simple unnecessarily complicated
date: 2026-10-22
tags: [programming, selenium, python]
---

You see this during code review:

```python
# Locate the login button by traversing positional ancestors,
# evaluating descendant relationships, normalizing whitespace,
# and performing case-insensitive text comparisons through
# translate(). Validate class-token membership using concat()
# and normalize-space(), while excluding disabled or aria-hidden
# elements through nested predicates. Count eligible descendants,
# inspect sibling relationships, and resolve positional ambiguity
# through explicit indexing.

driver.find_element(By.XPATH,
    "((//div[@id='app']/div)[3]//section[2]"
    "/div[4]//div[position()=1]"
    "//div[contains(concat(' ', normalize-space(@class), ' '), ' card ')]"
    "[.//input[@type='password']"
    " and count(.//button[not(@disabled)]) >= 1]"
    "//div[normalize-space(translate(@class,"
    "'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'))='actions']"
    "/descendant::button["
    "contains(translate(normalize-space(.),"
    "'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),'login')"
    " and not(@disabled)"
    " and not(ancestor-or-self::*[@aria-hidden='true'])"
    "][position()=1])[1]"
)
```

Me: Have you considered...?

```python
driver.find_element(By.ID, "login-btn")
```

💀
