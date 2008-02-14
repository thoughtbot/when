require File.join(File.dirname(__FILE__), 'test_helper')

class FiltersTest < ActionController::TestCase

  def setup
    load File.join(File.dirname(__FILE__), 'fixtures', 'companies_controller.rb')

    CompaniesController.class_eval do
      def rescue_action(exception) 
        raise exception
      end 
    end

    @controller = CompaniesController.new
    @request = ActionController::TestRequest.new
    @response = ActionController::TestResponse.new
    ActionController::Routing::Routes.draw do |map|
      map.connect 'companies', :controller => 'companies'
      map.connect 'companies/show', :controller => 'companies', 
        :action => 'show'
    end
  end

  basic_filters = %w(before_filter)

  conditions = [lambda {|controller| controller.flag?}, :flag?, 'flag?']

  conditions.each do |condition|
    basic_filters.each do |filter|
      define_method "test_#{filter}_with_if_condition_#{condition.class}_which_returns_true_should_change_company_name" do
        CompaniesController.send filter.to_sym, :change_name, :if => condition

        @controller.name = 'thoughtbot'
        @controller.flag = true

        get :index
        assert_equal 'new name', @controller.name
      end
      
      define_method "test_#{filter}_with_if_condition_#{condition.class}_which_returns_false_should_not_change_company_name" do
        CompaniesController.send filter.to_sym, :change_name, :if => condition

        @controller.name = 'thoughtbot'
        @controller.flag = false

        get :index
        assert_equal 'thoughtbot', @controller.name
      end
      
      define_method "test_#{filter}_with_unless_condition_#{condition.class}_which_returns_true_should_not_change_company_name" do
        CompaniesController.send filter.to_sym, :change_name, :unless => condition

        @controller.name = 'thoughtbot'
        @controller.flag = true

        get :index
        assert_equal 'thoughtbot', @controller.name
      end
      
      define_method "test_#{filter}_with_unless_condition_#{condition.class}_which_returns_false_should_change_company_name" do
        CompaniesController.send filter.to_sym, :change_name, :unless => condition

        @controller.name = 'thoughtbot'
        @controller.flag = false

        get :index
        assert_equal 'new name', @controller.name
      end

      define_method "test_#{filter}_with_only_option_with_if_condition_#{condition.class}_which_returns_true_should_change_company_name" do
        CompaniesController.send filter.to_sym, :change_name, :only => :show, :if => condition

        @controller.name = 'thoughtbot'
        @controller.flag = true

        get :index
        assert_equal 'thoughtbot', @controller.name

        get :show
        assert_equal 'new name', @controller.name
      end
      
      define_method "test_#{filter}_with_only_option_if_condition_#{condition.class}_which_returns_false_should_not_change_company_name" do
        CompaniesController.send filter.to_sym, :change_name, :only => :show, :if => condition

        @controller.name = 'thoughtbot'
        @controller.flag = false

        get :index
        assert_equal 'thoughtbot', @controller.name

        get :show
        assert_equal 'thoughtbot', @controller.name
      end
      
      define_method "test_#{filter}_with_only_option_unless_condition_#{condition.class}_which_returns_true_should_not_change_company_name" do
        CompaniesController.send filter.to_sym, :change_name, :only => :show, :unless => condition

        @controller.name = 'thoughtbot'
        @controller.flag = true

        get :index
        assert_equal 'thoughtbot', @controller.name

        get :show
        assert_equal 'thoughtbot', @controller.name
      end
      
      define_method "test_#{filter}_with_only_option_unless_condition_#{condition.class}_which_returns_false_should_change_company_name" do
        CompaniesController.send filter.to_sym, :change_name, :only => :show, :unless => condition

        @controller.name = 'thoughtbot'
        @controller.flag = false

        get :index
        assert_equal 'thoughtbot', @controller.name

        get :show
        assert_equal 'new name', @controller.name
      end

      define_method "test_#{filter}_with_except_option_with_if_condition_#{condition.class}_which_returns_true_should_change_company_name" do
        CompaniesController.send filter.to_sym, :change_name, :except => :show, :if => condition

        @controller.name = 'thoughtbot'
        @controller.flag = true

        get :show
        assert_equal 'thoughtbot', @controller.name

        get :index
        assert_equal 'new name', @controller.name
      end
      
      define_method "test_#{filter}_with_except_option_if_condition_#{condition.class}_which_returns_false_should_not_change_company_name" do
        CompaniesController.send filter.to_sym, :change_name, :except => :show, :if => condition

        @controller.name = 'thoughtbot'
        @controller.flag = false

        get :show
        assert_equal 'thoughtbot', @controller.name

        get :index
        assert_equal 'thoughtbot', @controller.name
      end
      
      define_method "test_#{filter}_with_except_option_unless_condition_#{condition.class}_which_returns_true_should_not_change_company_name" do
        CompaniesController.send filter.to_sym, :change_name, :except => :show, :unless => condition

        @controller.name = 'thoughtbot'
        @controller.flag = true

        get :show
        assert_equal 'thoughtbot', @controller.name

        get :index
        assert_equal 'thoughtbot', @controller.name
      end
      
      define_method "test_#{filter}_with_except_option_unless_condition_#{condition.class}_which_returns_false_should_change_company_name" do
        CompaniesController.send filter.to_sym, :change_name, :except => :show, :unless => condition

        @controller.name = 'thoughtbot'
        @controller.flag = false

        get :show
        assert_equal 'thoughtbot', @controller.name

        get :index
        assert_equal 'new name', @controller.name
      end

      define_method "test_#{filter}_with_if_condition_#{condition.class}_which_returns_true_should_raise_an_exception_if_its_callback_is_not_a_symbol" do
        CompaniesController.send filter.to_sym, CompaniesController, :if => condition

        @controller.name = 'thoughtbot'
        @controller.flag = true

        assert_raises(ActionController::ActionControllerError) do
          get :index
        end
      end

      define_method "test_#{filter}_with_unless_condition_#{condition.class}_which_returns_true_should_raise_an_exception_if_its_callback_is_not_a_symbol" do
        CompaniesController.send filter.to_sym, CompaniesController, :unless => condition

        @controller.name = 'thoughtbot'
        @controller.flag = false

        assert_raises(ActionController::ActionControllerError) do
          get :index
        end
      end
    end
  end

  def teardown
    Object.class_eval do
      remove_const CompaniesController.to_s if const_defined? CompaniesController.to_s
    end
  end

end
