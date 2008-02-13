require File.join(File.dirname(__FILE__), 'callbacks')

ActiveRecord::Base.send :include, ActiveRecordHook::Callbacks
