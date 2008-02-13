require 'rubygems'
require 'test/unit'
require 'active_record'
require File.join(File.dirname(__FILE__), '..', 'init')

config = YAML::load File.read(File.join(File.dirname(__FILE__), 'database.yml'))
ActiveRecord::Base.establish_connection config['test']
load File.join(File.dirname(__FILE__), 'schema.rb')

