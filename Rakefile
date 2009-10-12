require 'rake'
require 'yaml'
require 'curb'

PROJECT_PATH = File.dirname(__FILE__)
PUBLIC = File.join(PROJECT_PATH, "public")
EXPORT = File.join(PROJECT_PATH, "export")

desc "Set up the project before running the server"
task :setup => [:install_dependencies] do
  p %(Run "ruby server.rb" to start the server at localhost:4567)
end

desc "Installs the gems needed to run the project server script"
task :install_dependencies do
  system %(sudo gem install sinatra less sprockets haml datamapper data_objects do_sqlite3 json curb)
end

desc "Export dynamic files as static"
task :export do
  FileUtils.mkdir_p EXPORT
  manifest = YAML.load_file("export.yml")
  
  manifest["files"].each do |filename|
    output = File.join(EXPORT, filename)
    FileUtils.mkdir_p base_path(output)
    
    c = Curl::Easy.perform("http://localhost:4567/" + filename)
    File.open(output, "w") do |f|  
      f.write c.body_str
    end
  end
  
  copy_files([ "**/**" ], PUBLIC, EXPORT)
end

### Utility Functions

def base_path(file)
  file.sub(/#{File.basename(file)}$/, '')
end

def absolute_path_to_relative_path(abs, from, to)
  to + abs.sub(/^#{from}/, '')
end

def copy_files(list, from, to)
  list.each do |glob|
    filelist = FileList.new(File.join(from, glob))
    
    filelist.each do |file|
      new_file = absolute_path_to_relative_path(file, from, to)
      FileUtils.mkdir_p base_path(new_file)
      FileUtils.cp file, new_file unless File.directory?(file)
    end
  end
end