require 'sinatra/base'
require "./config/environment.rb"

#run rackup for all controller files
controllers = Dir.foreach("./app/controllers").select{ |raw_file| raw_file =~ /.+(?=.rb)/ }.map{|file_name| ActiveSupport::Inflector.camelize(File.basename(file_name, ".*")).constantize }
run Rack::Cascade.new controllers 