module Appsta
  module Git
    # This sets up the git repo, optionally with a custom message
    def git_setup(message = "initial commit by Appsta")
      git(:init)
      git(:add => ".")
      git(:commit => "-a -m '#{message}'")
    end
    
    # This pushes to the remotes specified
    def git_push(*remotes)
      remotes.each do |remote|
        git(:push => "#{remote} master")
      end
    end
  end
end
