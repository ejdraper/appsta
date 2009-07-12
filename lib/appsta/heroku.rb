gem "heroku"
require "heroku"

module Appsta
  module Heroku
    # This creates a Heroku app for the application, with the specified environment
    def heroku(environment = :production)
      # This builds the Heroku app name, based on the app name and the environment
      name = "#{File.basename(Dir.pwd)}-#{environment}".gsub("_", "-").gsub("-production", "")
      # Ask the user for the Heroku username and password
      heroku_username = ask("Heroku Username:")
      heroku_password = ask("Heroku Password:")
      # Create the Heroku client object
      client = ::Heroku::Client.new(heroku_username, heroku_password)
      # Create the app on Heroku
      client.create(name, {})
      # Add the git remote for the app
      Kernel.system "git remote add #{environment} git@heroku.com:#{name}.git"
    end
  end
end
