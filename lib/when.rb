require File.join(File.dirname(__FILE__), 'validations')
require File.join(File.dirname(__FILE__), 'filters')
require File.join(File.dirname(__FILE__), 'callbacks')

ActiveRecord::Base.send :include, ActiveRecordHook::Callbacks
ActiveRecord::Base.send :include, ActiveRecordHook::Validations
ActionController::Base.send :include, ActionControllerHook::Filters
