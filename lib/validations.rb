module ActiveRecordHook
  module Validations
 
    def self.included(klass)
      class << klass

        validations = ActiveRecord::Validations::VALIDATIONS
      
        validations.each do |validation|
          src = <<-END;
            def #{validation}_with_conditions (*validations, &block)
              options = validations.extract_options!
              if block_given?
                validations << block
              end
              validations.each do |validation|
                #{validation}_without_conditions do |record|
                  unless (! options[:if].nil? && ! evaluate_condition(options[:if], record)) ||
                      (! options[:unless].nil? && evaluate_condition(options[:unless], record))
                    execute_validation validation, record, :#{validation}
                  end
                end
              end
            end
            alias_method_chain :#{validation}, :conditions
          END
          class_eval src, __FILE__, __LINE__
        end
 
        def execute_validation(validation, record, method)
          if validation.class == Symbol
            record.send validation
#           elsif callback.class == String
#             eval callback, record.send(:binding)
#           elsif callback.class == Proc || callback.class == Method
#             callback.call record
#           else
#             if callback.respond_to?(method)
#               callback.send method, record
#             else
#               raise ActiveRecordError, 'Callbacks must be a symbol denoting the message to send, 
#                                         a string to be evaluated, a block to be invoked or a 
#                                         class object responding to the callback message 
#                                         (#before_create, #after_create, etc).'
#             end

          end
        end
 
      end
    end

  end 
end
