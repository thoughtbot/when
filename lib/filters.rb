module ActionControllerHook
  module Filters
 
    def self.included(klass)
      class << klass

        filters = %w(append_before_filter prepend_before_filter before_filter 
                     append_after_filter prepend_after_filter after_filter)
        
        filters.each do |filter|
          src = <<-END;
            def #{filter}_with_conditions (*filters, &block)
              options = filters.extract_options!
              if block_given?
                filters << block
              end
              filters.each do |filter|
                #{filter}_without_conditions do |controller|
                  unless (! options[:if].nil? && ! ActiveRecord::Base.evaluate_condition(options[:if], controller)) ||
                      (! options[:unless].nil? && ActiveRecord::Base.evaluate_condition(options[:unless], controller))
                    execute_filter filter, controller, :#{filter}
                  end
                end
              end
            end
            alias_method_chain :#{filter}, :conditions
          END
          class_eval src, __FILE__, __LINE__
        end

        def execute_filter(filter, controller, method)
          if filter.class == Symbol
            controller.send filter
#           elsif callback.class == Proc || callback.class == Method
#             callback.call controller
#           else
#             if callback.respond_to?(method)
#               callback.send method, controller
#             else
#            raise ActionControllerError, 'A filter must be a Symbol, Proc, Method, or object 
#                                          responding to filter, after or before.'
#             end

          end
        end

      end
    end

  end
end
