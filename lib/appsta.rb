require File.join(File.dirname(__FILE__), "appsta", "heroku")
require File.join(File.dirname(__FILE__), "appsta", "github")
require File.join(File.dirname(__FILE__), "appsta", "git")

module Appsta
  VERSION = "0.0.1"
  
  include Appsta::Heroku
  include Appsta::GitHub
  include Appsta::Git
end
