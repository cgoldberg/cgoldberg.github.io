#!/usr/bin/env ruby
#
# Check for changed posts

# Uncomment this to have the "Recently Updated" section in the
# right panel sorted by date/time of the last edited post

#Jekyll::Hooks.register :posts, :post_init do |post|
#
#  commit_num = `git rev-list --count HEAD "#{ post.path }"`
#
#  if commit_num.to_i > 1
#    lastmod_date = `git log -1 --pretty="%ad" --date=iso "#{ post.path }"`
#    post.data['last_modified_at'] = lastmod_date
#  end
#
#end
