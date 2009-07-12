gem "heroku"
require "heroku"

module Appsta
  module Heroku
    # This creates a Heroku app for the application, with the specified environment
    def heroku(environment = :production)
      # This builds the Heroku app name, based on the app name and the environment
      name = "#{File.basename(Dir.pwd)}-#{environment}".gsub("_", "-").gsub("-production", "")
      # Ask the user for the Heroku username and password
      @@heroku_username ||= ask("Heroku Username:")
      @@heroku_password ||= ask("Heroku Password:")
      # Create the Heroku client object
      client = ::Heroku::Client.new(@@heroku_username, @@heroku_password)
      # Create the app on Heroku
      client.create(name, {})
      # Add the git remote for the app
      git(:remote => "add #{environment} git@heroku.com:#{name}.git")
      # Push the code up to Heroku for the initial deploy
      git(:push => "#{environment} master")
      # Return the Heroku information for this app
      "http://#{name}.heroku.com - git@heroku.com:#{name}.git"
    end
    
    # This creates the gems manifest for Heroku based on a hash of gem
    # information, and adds the gem to the project
    def heroku_gems(gems)
      # This will hold the manifest
      gem_manifest = ""
      # Loop through all supplied gems
      gems.each do |g|
        # Remove the name from the hash and use that to start the line
        name = g.delete :name
        gem_line = name.dup
        # Then add the source and version from the hash to the gems manifest (if present)
        g.each_pair do |key, value|
          # Ignore anything other than source or version
          next unless key == :source || key == :version
          # Add the value to the line
          gem_line << " --#{key} #{value}"
        end
        # Add the line to the manifest
        gem_manifest << "#{gem_line}\n"
        # Install the gem
        gem name, g
      end
      # Write the manifest to file
      file ".gems", gem_manifest
    end
  end
end
