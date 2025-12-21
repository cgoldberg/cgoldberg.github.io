# cgoldberg.github.io

This repo contains the code for Corey Goldberg's personal blog website,
located at: [https://cgoldberg.github.io][blog-home].

It's hosted on [GitHub Pages][gh-pages], made with
[Jekyll][jekyll] static site generator, using the [Chirpy theme][chirpy-theme].

----

## Usage

To setup a development environment and run locally:

1. Clone this repository to your local machine
2. Follow the [Jekyll installation guide][jekyll-install] to install Jekyll
3. Run `bundle` in the root of the repository to install the dependencies
4. Run `bundle exec jekyll s` in the root of the repository to start the Jekyll server

The local server will be available at: http://127.0.0.1:4000

This repo was generated from the [Chirpy Starter template][chirpy-starter].
To update/sync with the latest version:

1. `git remote add template git@github.com:cotes2020/chirpy-starter.git`
2. `git fetch template`
3. `git merge template/main --allow-unrelated-histories`
4. resolve all merge conflicts
5. `git restore --staged assets/lib`
6. `git add .`
7. check `git status` and remove unwanted new files
7. `git commit -m "Sync with upstream template"`
8. `git push`

## Deployment

The website is generated and deployed with every push to the `main` branch
of this repo using a [workflow][gh-workflow] on [GitHub Actions][gh-actions].

## License

This work is published under the [MIT License][mit-license].

----

[blog-home]: https://cgoldberg.github.io
[chirpy-theme]: https://github.com/cotes2020/jekyll-theme-chirpy
[chirpy-starter]: https://github.com/cotes2020/chirpy-starter
[gh-actions]: https://github.com/features/actions
[gh-pages]: https://pages.github.com
[gh-workflow]: https://github.com/cgoldberg/cgoldberg.github.io/actions
[jekyll]: https://jekyllrb.com
[jekyll-install]: https://jekyllrb.com/docs/installation
[mit-license]: https://github.com/cgoldberg/cgoldberg.github.io/blob/main/LICENSE
