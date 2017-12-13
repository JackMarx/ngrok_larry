require 'dotenv/load'          #load ENV variables
require 'sinatra'              #Lightweight Framework
require 'sinatra/activerecord' #Active Record ORM
require 'slack-ruby-client'    #Slack gem
require "rake"                 #rake commands
require "sqlite3"              #database
require "pathname"             #facilitates path for directory
require "rack"                 #rackup for sinatra

# Autoloads all ruby classes named the same as the file they are in.
path_to_root_directory = File.expand_path('../../', __FILE__) 
APP_ROOT = Pathname.new(path_to_root_directory)
app_files = Dir[APP_ROOT.join('app', '**', '*.rb')]
app_files.each { |app_file| autoload ActiveSupport::Inflector.camelize(File.basename(app_file, ".*")), app_file }

#sets sqlite SQL database
set :database, "sqlite3:ngrok_larry.sqlite3"