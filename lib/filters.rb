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
