module Appsta
  module JQuery
    # This removes existing built-in JS and switches to jQuery for your Rails app
    def use_jquery(version = "1.3.2")
      run "rm -f public/javascripts/*"
      run "curl -s -L http://jqueryjs.googlecode.com/files/jquery-#{version}.min.js > public/javascripts/jquery.js"
    end
  end
end
