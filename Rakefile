ENV["SINATRA_ENV"] ||= "development"

require_relative './config/environment'
require 'sinatra/activerecord/rake'
#require_relative "./db/seeds.rb"



task :console do
  ActiveRecord::Base.logger = Logger.new(STDOUT)
  Pry.start
end

task :seed do
  ruby "db/seeds.rb"
end