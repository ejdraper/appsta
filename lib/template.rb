gem "appsta"
require "appsta"

# Remove certain files
["README", "public/index.html", "public/favicon.ico", "public/javascripts/*"].each do |path|
  run "rm -f #{path}"
end

# Grab jQuery for use in the app
run "curl -s -L http://jqueryjs.googlecode.com/files/jquery-1.3.2.min.js > public/javascripts/jquery.js"
