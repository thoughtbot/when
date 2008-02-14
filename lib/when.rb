require File.join(File.dirname(__FILE__), 'callbacks')
require File.join(File.dirname(__FILE__), 'filters')

ActiveRecord::Base.send :include, When::Callbacks
ActionController::Base.send :include, When::Filters
