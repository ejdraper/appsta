require 'rubygems' unless ENV['NO_RUBYGEMS']
%w[rake rake/clean fileutils newgem rubigen hoe].each { |f| require f }
require File.dirname(__FILE__) + '/lib/appsta'

# Generate all the Rake tasks
# Run 'rake -T' to see list of generated tasks (from gem root directory)
$hoe = Hoe.new('appsta', Appsta::VERSION) do |p|
  p.developer('Elliott Draper', 'el@ejdraper.com')
  p.changes              = p.paragraphs_of("History.txt", 0..1).join("\n\n")
  p.post_install_message = 'PostInstall.txt'
  p.rubyforge_name       = p.name
  p.extra_deps           = [
    ['heroku'], ['rest-client']
  ]
  p.extra_dev_deps = [
    ['newgem', ">= #{::Newgem::VERSION}"]
                     ]
  p.summary = "Appsta is designed to make bootstrapping new Rails applications much easier."
  
  p.clean_globs |= %w[**/.DS_Store tmp *.log]
  path = (p.rubyforge_name == p.name) ? p.rubyforge_name : "\#{p.rubyforge_name}/\#{p.name}"
  p.remote_rdoc_dir = File.join(path.gsub(/^#{p.rubyforge_name}\/?/,''), 'rdoc')
  p.rsync_args = '-av --delete --ignore-errors'
end

require 'newgem/tasks'
Dir['tasks/**/*.rake'].each { |t| load t }

require 'rake/testtask'
