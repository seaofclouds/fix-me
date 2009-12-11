require 'rubygems'
require 'sinatra'
require 'haml'
require 'sass'

# == setup ====================================================

set :app_file, __FILE__
set :root, File.dirname(__FILE__)
set :sass, {:style => :compact, :load_paths => [File.join(Sinatra::Application.views, 'stylesheets')]}

not_found do
  headers["Status"] = "301 Moved Permanently"
  redirect("/")
end

helpers do
  def partial(page, options={})
    haml "_#{page}".to_sym, options.merge!(:layout => false)
  end
end

# == views =====================================================

get '/' do
  haml :index
end

# == stylesheets ===============================================

get '/stylesheets/:name.css' do
  content_type 'text/css', :charset => 'utf-8'
  sass :"stylesheets/#{params[:name]}"
end
