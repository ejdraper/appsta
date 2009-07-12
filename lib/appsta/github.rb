gem "rest-client"
require "rest_client"

module Appsta
  module GitHub
    # This creates a repository on GitHub for the project
    def github
      # This grabs the app name
      name = File.basename(Dir.pwd)
      # Ask the user for the GitHub username and password
      github_username = ask("GitHub Username:")
      github_password = ask("GitHub Password:")
      # Create the GitHub client object
      client = RestClient::Resource.new("http://github.com", github_username, github_password)["/api/v2/yaml/repos/create"]
      # Post to GitHub, and examine the response for any error
      response = YAML::load(client.post(:name => name, :public => false))
      raise response["error"].first["error"] if response.keys.include?("error")
      # Add the git remote for GitHub
      git(:remote => "add origin git@github.com:#{github_username}/#{name}.git")
      # Push the code up to GitHub
      git(:push => "origin master")
      # Return the information for the GitHub repo
      "http://github.com/#{github_username}/#{name} - git@github.com:#{github_username}/#{name}.git"
    end
  end
end
