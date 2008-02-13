module ActiveRecordHook
  module Callbacks
 
    def self.included(klass)
      class << klass
        callbacks = ActiveRecord::Callbacks::CALLBACKS +
          ActiveRecord::Validations::VALIDATIONS - 
          %w(after_find after_initialize)
      
        callbacks.each do |callback|
          src = <<-END
            def #{callback}_with_conditions(*callbacks)
              options = callbacks.extract_options!
              callbacks.each do |callback|
                #{callback}_without_conditions do |record|
                  unless (! options[:if].nil? && ! evaluate_condition(options[:if], record)) ||
                      (! options[:unless].nil? && evaluate_condition(options[:unless], record))
                    record.send callback
                  end
                end
              end
            end
            alias_method_chain :#{callback}, :conditions
          END
          class_eval src, __FILE__, __LINE__
        end
      end
    end

  end
end
