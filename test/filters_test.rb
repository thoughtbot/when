require File.join(File.dirname(__FILE__), 'test_helper')

class FiltersTest < ActionController::TestCase

  def setup
    load File.join(File.dirname(__FILE__), 'fixtures', 'companies_controller.rb')

    @controller = CompaniesController.new
    @request = ActionController::TestRequest.new
    @response = ActionController::TestResponse.new
    ActionController::Routing::Routes.draw do |map|
      map.connect 'companies', :controller => 'companies'
    end
  end

  basic_filters = %w(before_filter)

  conditions = [lambda {|controller| controller.flag?}, :flag?, 'flag?']

  conditions.each do |condition|
    basic_filters.each do |filter|
      define_method "test_#{filter}_with_if_condition_#{condition.class}_which_returns_true_should_change_company_name" do
        CompaniesController.send filter.to_sym, :change_name, :if => condition

        @controller.name = 'thoughtbot'
        @controller.filter_flag = true

        get :index
        assert_equal 'new name', @controller.name
      end
      
      define_method "test_#{filter}_with_if_condition_#{condition.class}_which_returns_false_should_not_change_company_name" do
        CompaniesController.send filter.to_sym, :change_name, :if => condition

        @controller.name = 'thoughtbot'
        @controller.filter_flag = false

        get :index
        assert_equal 'thoughtbot', @controller.name
      end
      
      define_method "test_#{filter}_with_unless_condition_#{condition.class}_which_returns_true_should_not_change_company_name" do
        CompaniesController.send filter.to_sym, :change_name, :unless => condition

        @controller.name = 'thoughtbot'
        @controller.filter_flag = true

        get :index
        assert_equal 'thoughtbot', @controller.name
      end
      
      define_method "test_#{filter}_with_unless_condition_#{condition.class}_which_returns_false_should_change_company_name" do
        CompaniesController.send filter.to_sym, :change_name, :unless => condition

        @controller.name = 'thoughtbot'
        @controller.filter_flag = false

        get :index
        assert_equal 'new name', @controller.name
      end
    end
  end

  def teardown
    Object.class_eval do
      remove_const CompaniesController.to_s if const_defined? CompaniesController.to_s
    end
  end

end
