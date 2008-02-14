require File.join(File.dirname(__FILE__), 'test_helper') 

class CallbacksTest < Test::Unit::TestCase
  
  def setup
    load File.join(File.dirname(__FILE__), 'fixtures', 'company.rb')
  end
  
  basic_callbacks   = %w(before_create after_create
                         before_validation_on_create before_validation
                         after_validation_on_create after_validation  
                         before_save after_save)
  update_callbacks  = %w(before_update after_update
                         before_validation_on_update after_validation_on_update)
  destroy_callbacks = %w(before_destroy after_destroy)

  conditions = [lambda {|company| company.flag?}, :flag?, 'flag?']

  conditions.each do |condition|
    basic_callbacks.each do |callback| 
      define_method "test_#{callback}_with_if_condition_#{condition.class}_which_returns_true_should_change_company_name" do
        Company.send callback.to_sym, :change_name, :if => condition

        company = Company.new :name => 'thoughtbot', :callback_flag => true
        assert company.save
        assert_equal 'new name', company.name
      end
      
      define_method "test_#{callback}_with_if_condition_#{condition.class}_which_returns_false_should_not_change_company_name" do
        Company.send callback.to_sym, :change_name, :if => condition

        company = Company.new :name => 'thoughtbot', :callback_flag => false
        assert company.save
        assert_equal 'thoughtbot', company.name
      end
      
      define_method "test_#{callback}_with_unless_condition_#{condition.class}_which_returns_true_should_not_change_company_name" do
        Company.send callback.to_sym, :change_name, :unless => condition

        company = Company.new :name => 'thoughtbot', :callback_flag => true
        assert company.save
        assert_equal 'thoughtbot', company.name
      end
      
      define_method "test_#{callback}_with_unless_condition_#{condition.class}_which_returns_false_should_change_company_name" do
        Company.send callback.to_sym, :change_name, :unless => condition

        company = Company.new :name => 'thoughtbot', :callback_flag => false
        assert company.save
        assert_equal 'new name', company.name
      end
    end
    
    update_callbacks.each do |callback| 
      define_method "test_#{callback}_with_if_condition_#{condition.class}_which_returns_true_should_change_company_name" do
        Company.send callback.to_sym, :change_name, :if => condition

        company = Company.create :name => 'thoughtbot', :callback_flag => true
        assert company.save
        assert_equal 'new name', company.name
      end
      
      define_method "test_#{callback}_with_if_condition_#{condition.class}_which_returns_false_should_not_change_company_name" do
        Company.send callback.to_sym, :change_name, :if => condition

        company = Company.create :name => 'thoughtbot', :callback_flag => false
        assert company.save
        assert_equal 'thoughtbot', company.name
      end
      
      define_method "test_#{callback}_with_unless_condition_#{condition.class}_which_returns_true_should_not_change_company_name" do
        Company.send callback.to_sym, :change_name, :unless => condition

        company = Company.create :name => 'thoughtbot', :callback_flag => true
        assert company.save
        assert_equal 'thoughtbot', company.name
      end
      
      define_method "test_#{callback}_with_unless_condition_#{condition.class}_which_returns_false_should_change_company_name" do
        Company.send callback.to_sym, :change_name, :unless => condition

        company = Company.create :name => 'thoughtbot', :callback_flag => false
        assert company.save
        assert_equal 'new name', company.name
      end
    end
    
    destroy_callbacks.each do |callback|
      define_method "test_#{callback}_with_if_condition_#{condition.class}_which_returns_true_should_toggle_callback_flag" do
        Company.send callback.to_sym, :toggle_callback_flag, :if => condition

        company = Company.new :name => 'thoughtbot', :callback_flag => true
        assert company.save
        assert company.destroy
        assert ! company.callback_flag
      end
      
      define_method "test_#{callback}_with_if_condition_#{condition.class}_which_returns_false_should_not_toggle_callback_flag" do
        Company.send callback.to_sym, :toggle_callback_flag, :if => condition

        company = Company.new :name => 'thoughtbot', :callback_flag => false
        assert company.save
        assert company.destroy
        assert ! company.callback_flag
      end
      
      define_method "test_#{callback}_with_unless_condition_#{condition.class}_which_returns_true_should_not_toggle_callback_flag" do
        Company.send callback.to_sym, :toggle_callback_flag, :unless => condition

        company = Company.new :name => 'thoughtbot', :callback_flag => true
        assert company.save
        assert company.destroy
        assert company.callback_flag
      end
      
      define_method "test_#{callback}_with_unless_condition_#{condition.class}_which_returns_false_should_toggle_callback_flag" do
        Company.send callback.to_sym, :toggle_callback_flag, :unless => condition

        company = Company.new :name => 'thoughtbot', :callback_flag => false
        assert company.save
        assert company.destroy
        assert company.callback_flag
      end
    end
  end
  
  def teardown
    Object.class_eval do
      remove_const Company.to_s if const_defined? Company.to_s
    end
  end
  
end
