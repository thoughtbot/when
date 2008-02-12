require 'callbacks'
require 'validations'
require 'filters'

ActiveRecord::Base.send :include, ActiveRecordHook::Callbacks
ActiveRecord::Base.send :include, ActiveRecordHook::Validations

ActionController::Base.send :include, ActionControllerHook::Filters
