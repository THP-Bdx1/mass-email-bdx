require 'bundler'
#Bundler.require
$:.unshift File.expand_path("./../lib/views", __FILE__)
require 'index.rb'
Dotenv.load


#Mailing.new.perform
Index.new.perform
