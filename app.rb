#require 'bundler'
#Bundler.require
$:.unshift File.expand_path("./../lib/views", __FILE__)
require 'index.rb'
#$:.unshift File.expand_path("./../lib/app", __FILE__)
#require "townhalls_mailer.rb"
#require_relative 'lib/views/index.rb'

#Mailing.new.perform
Index.new.perform
