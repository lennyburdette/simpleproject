%w(rubygems less sprockets erb sinatra).each { |lib| require lib }

get '/' do
  erb :index
end

get '/:filename.html' do
  erb params[:filename].to_sym
end

get '/css/:filename.css' do
  content_type "text/css; charset=utf-8"
  engine = File.open(File.join("stylesheets", params[:filename] + ".less")) { |f| Less::Engine.new(f) }
  engine.to_css
end

get '/js/:filename.js' do
  content_type "text/javascript; charset=utf-8"
  Sprockets::Secretary.new({
    :load_path => %w(javascripts javascripts/lib javascripts/src),
    :source_files => %w(javascripts/src/#{params[:filename]}.js)
  }).concatenation.to_s
end