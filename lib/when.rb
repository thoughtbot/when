require File.join(File.dirname(__FILE__), 'callbacks')
require File.join(File.dirname(__FILE__), 'filters')

ActiveRecord::Base.send :include, ActiveRecordHook::Callbacks
ActionController::Base.send :include, ActionControllerHook::Filters

# module When

#   def 
#   end

# end
