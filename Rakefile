require 'rake'

desc "Set up the project before running the server"
task :setup => [:install_dependencies] do
  p %(Run "ruby server.rb" to start the server at localhost:4567)
end

desc "Installs the gems needed to run the project server script"
task :install_dependencies do
  system %(sudo gem install sinatra less sprockets haml datamapper data_objects do_sqlite3 json)
end