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
                    controller.send filter
                  end
                end
              end
            end
            alias_method_chain :#{filter}, :conditions
          END
          class_eval src, __FILE__, __LINE__
        end

      end
    end

  end
end
