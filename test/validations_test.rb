require File.join(File.dirname(__FILE__), 'test_helper') 

class ValidationsTest < Test::Unit::TestCase
  
  def setup
    load File.join(File.dirname(__FILE__), 'fixtures', 'company.rb')
  end
  
  basic_validations = %w(validate validate_on_create)
  update_validations = %w(validate_on_update)

  conditions = [lambda {|company| company.flag?}, :flag?, 'flag?']

  conditions.each do |condition|
    basic_validations.each do |validation| 
      define_method "test_#{validation}_with_if_condition_#{condition.class}_which_returns_true_should_change_company_name" do
        Company.send validation.to_sym, :change_name, :if => condition

        company = Company.new :name => 'thoughtbot', :callback_flag => true
        assert company.save
        assert_equal 'new name', company.name
      end
      
      define_method "test_#{validation}_with_if_condition_#{condition.class}_which_returns_false_should_not_change_company_name" do
        Company.send validation.to_sym, :change_name, :if => condition

        company = Company.new :name => 'thoughtbot', :callback_flag => false
        assert company.save
        assert_equal 'thoughtbot', company.name
      end
      
      define_method "test_#{validation}_with_unless_condition_#{condition.class}_which_returns_true_should_not_change_company_name" do
        Company.send validation.to_sym, :change_name, :unless => condition

        company = Company.new :name => 'thoughtbot', :callback_flag => true
        assert company.save
        assert_equal 'thoughtbot', company.name
      end

      define_method "test_#{validation}_with_unless_condition_#{condition.class}_which_returns_false_should_change_company_name" do
        Company.send validation.to_sym, :change_name, :unless => condition

        company = Company.new :name => 'thoughtbot', :callback_flag => false
        assert company.save
        assert_equal 'new name', company.name
      end
    end
    
    update_validations.each do |validation|
      define_method "test_#{validation}_with_if_condition_#{condition.class}_which_returns_true_should_change_company_name" do
        Company.send validation.to_sym, :change_name, :if => condition

        company = Company.create :name => 'thoughtbot', :callback_flag => true
        assert company.save
        assert_equal 'new name', company.name
      end
    
      define_method "test_#{validation}_with_if_condition_#{condition.class}_which_returns_false_should_not_change_company_name" do
        Company.send validation.to_sym, :change_name, :if => condition

        company = Company.create :name => 'thoughtbot', :callback_flag => false
        assert company.save
        assert_equal 'thoughtbot', company.name
      end
    
      define_method "test_#{validation}_with_unless_condition_#{condition.class}_which_returns_true_should_not_change_company_name" do
        Company.send validation.to_sym, :change_name, :unless => condition

        company = Company.create :name => 'thoughtbot', :callback_flag => true
        assert company.save
        assert_equal 'thoughtbot', company.name
      end

      define_method "test_#{validation}_with_unless_condition_#{condition.class}_which_returns_false_should_change_company_name" do
        Company.send validation.to_sym, :change_name, :unless => condition

        company = Company.create :name => 'thoughtbot', :callback_flag => false
        assert company.save
        assert_equal 'new name', company.name
      end
    end
  end
  
  def teardown
    Object.class_eval do
      remove_const Company.to_s if const_defined? Company.to_s
    end
  end

end
