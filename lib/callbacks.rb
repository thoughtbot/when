module ActiveRecordHook
  module Callbacks
 
    def self.included(klass)
      class << klass
 
        callbacks = ActiveRecord::Callbacks::CALLBACKS
      
        callbacks.each do |callback|
          src = <<-END;
            def #{callback}_with_conditions (*callbacks, &block)
              options = callbacks.extract_options!
              if block_given?
                callbacks << block
              end
              callbacks.each do |callback|
                #{callback}_without_conditions do |record|
                  unless (! options[:if].nil? && ! evaluate_condition(options[:if], record)) ||
                      (! options[:unless].nil? && evaluate_condition(options[:unless], record))
                    execute_callback callback, record, :#{callback}
                  end
                end
              end
            end
            alias_method_chain :#{callback}, :conditions
          END
          class_eval src, __FILE__, __LINE__
        end
 
        def execute_callback(callback, record, method)
          if callback.class == Symbol
            record.send callback
          # elsif callback.class == String
          #   eval callback, record.send(:binding)
          # elsif callback.class == Proc ||
          #     callback.class == Method
          #   callback.call record
          # else
          #   if callback.respond_to?(method)
          #     callback.send method, record
          #   else
          #     raise ActiveRecordError, 
          #     'Callbacks must be a symbol denoting the message to send, a string to be evaluated, a block to be invoked or a class object responding to the callback message (#before_create, #after_create, etc).'
          #   end
          end
        end
 
      end
    end
 
  end
end
