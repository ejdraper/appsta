module Appsta
  module DefaultFiles
    # This removes some of the default files that we don't really need for a fresh Rails app
    def remove_default_files
      ["README", "public/index.html", "public/favicon.ico"].each do |path|
        run "rm -f #{path}"
      end
    end
  end
end
