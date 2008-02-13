require File.join(File.dirname(__FILE__), 'callbacks')
require File.join(File.dirname(__FILE__), 'validations')

ActiveRecord::Base.send :include, ActiveRecordHook::Callbacks
ActiveRecord::Base.send :include, ActiveRecordHook::Validations
