require 'validations'
require 'filters'
require 'callbacks'

ActiveRecord::Base.send :include, ActiveRecordHook::Callbacks
ActiveRecord::Base.send :include, ActiveRecordHook::Validations
