# How To Add a New Post

Instructions:

- clone the repo:
  - `$ git clone git@github.com:cgoldberg/cgoldberg.github.io`
- change directory to base of repo:
  - `$ cd cgoldberg.github.io`
- add new markdown file to `./_posts/` with name format `YYYY-MM-DD-post-title.md`
- stage new file:
  - `$ git add ./_posts/YYYY-MM-DD-post-title.md"`
- commit changes:
  - `$ git commit -m "New post"`
- push changes to GitHub:
  - `$ git push`

That's it! The GitHub actions workflow job will publish it to GitGHub Pages.

View the post at: https://coreygoldberg.com
