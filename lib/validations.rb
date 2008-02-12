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
          end
        end
 
      end
    end

  end 
end
