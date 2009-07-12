require File.join(File.dirname(__FILE__), "appsta", "heroku")
require File.join(File.dirname(__FILE__), "appsta", "github")
require File.join(File.dirname(__FILE__), "appsta", "git")

module Appsta
  VERSION = "0.0.1"
  
  include Appsta::Heroku
  include Appsta::GitHub
  include Appsta::Git

  class << self
    # This loads Appsta so that it's methods are available to the template runner
    def load
      Rails::TemplateRunner.send(:include, Appsta)
    end
    
    # This returns the template path for Appsta
    def template_path
      File.expand_path(File.join(File.dirname(__FILE__), "template.rb"))
    end
    
    # This returns the resources path for Appsta
    def resources_path
      File.expand_path(File.join(File.dirname(__FILE__), "..", "resources"))
    end
  end
end
