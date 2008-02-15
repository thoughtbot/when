module When
  module Callbacks
 
    def self.included(klass)
      class << klass
        callbacks = ActiveRecord::Callbacks::CALLBACKS +
          ActiveRecord::Validations::VALIDATIONS - 
          %w(after_find after_initialize)
      
        callbacks.each do |callback|
          src = <<-END
            def #{callback}_with_conditions(*callbacks, &block)
              options = callbacks.extract_options!
              if block_given?
                callbacks << block
              end
              callbacks.each do |callback|
                #{callback}_without_conditions do |record|
                  unless (! options[:if].nil? && ! evaluate_condition(options[:if], record)) ||
                      (! options[:unless].nil? && evaluate_condition(options[:unless], record))
                    if callback.class == Symbol
                      record.send callback
                    elsif callback.class == String
                      eval(callback, record.send(:binding))
                    elsif callback.class == Proc || callback.class == Method
                      callback.call(record)
                    else
                      raise ActiveRecord::ActiveRecordError, 
                        'Callbacks must be a symbol denoting the method to call, a string to be evaluated or a block to be invoked.'
                    end
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
