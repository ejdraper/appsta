gem "appsta"
require "appsta"
Appsta.load

# Remove certain files
["README", "public/index.html", "public/favicon.ico", "public/javascripts/*"].each do |path|
  run "rm -f #{path}"
end

# Grab jQuery for use in the app
run "curl -s -L http://jqueryjs.googlecode.com/files/jquery-1.3.2.min.js > public/javascripts/jquery.js"

# Setup the Git repo
git_setup

# Setup the app on Heroku
[:production, :staging].each { |env| heroku(env) }

# Setup the project repo on GitHub
github
