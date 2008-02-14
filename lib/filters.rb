module When
  module Filters
 
    def self.included(klass)
      class << klass
        filters = %w(before_filter)

        filters.each do |filter|
          src = <<-END
            def #{filter}_with_conditions(*filters)
              options = filters.extract_options!
              filters.each do |filter|
                #{filter}_without_conditions(options) do |controller|
                  unless (! options[:if].nil? && ! ActiveRecord::Base.evaluate_condition(options[:if], controller)) ||
                      (! options[:unless].nil? && ActiveRecord::Base.evaluate_condition(options[:unless], controller))
                    if filter.class == Symbol
                      controller.send filter
                    else
                      raise ActionController::ActionControllerError, 
                        'When only supports Symbol filters, refactor to use a Symbol or remove When'
                    end
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
