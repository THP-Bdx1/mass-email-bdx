$:.unshift File.expand_path("./../lib/views", __FILE__)
require 'index.rb'
Dotenv.load

Index.new.perform
