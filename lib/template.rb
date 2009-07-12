require "appsta"
Appsta.load

# This works out the name of the app
name = File.basename(Dir.pwd)

# Remove certain files
["README", "public/index.html", "public/favicon.ico", "public/javascripts/*"].each do |path|
  run "rm -f #{path}"
end

# Grab jQuery for use in the app
run "curl -s -L http://jqueryjs.googlecode.com/files/jquery-1.3.2.min.js > public/javascripts/jquery.js"

# Setup the gems we want, including the creation of the Heroku gem manifest
gems = [
        {:name => "thoughtbot-shoulda", :lib => "shoulda", :source => "http://gems.github.com"},
        {:name => "mocha"},
        {:name => "cucumber"},
        {:name => "hpricot"},
        {:name => "authlogic"}
       ]
heroku_gems gems

# Install all the gems we need
rake "gems:install", :sudo => true

# Setup the Git repo
git_setup

# Setup the app on Heroku
heroku_urls = []
[:production, :staging].each { |env| heroku_urls << heroku(env) }

# Setup the project repo on GitHub
github_url = github

# Setup the index.html and README files that Appsta auto-generates
file "README", ERB.new(File.read(File.join(Appsta.resources_path, "README.erb"))).result(binding)
file "public/index.html", ERB.new(File.read(File.join(Appsta.resources_path, "index.html.erb"))).result(binding)

# Update the git repo with our changes and push them
git :add => "."
git :commit => "-a -m 'added README and public/index.html'"
[:origin, :production, :staging].each { |remote| git(:push => "#{remote} master") }
