require File.join(File.dirname(__FILE__), 'test_helper') 

class CallbacksTest < Test::Unit::TestCase
  
  def setup
    load File.join(File.dirname(__FILE__), 'fixtures', 'company.rb')
  end
  
  basic_callbacks   = ['before_create', 'after_create', 
                       'before_validation_on_create', 'before_validation',
                       'after_validation_on_create', 'after_validation',  
                       'before_save', 'after_save' ]
  update_callbacks  = ['before_update', 'after_update', 
                       'before_validation_on_update', 'after_validation_on_update']
  destroy_callbacks = ['before_destroy', 'after_destroy']
  unique_callbacks  = ['after_find', 'after_initialize']
  
  conditions = [ lambda {|company| company.callback_flag == true}, :flag? ]

  conditions.each do |condition|
    basic_callbacks.each do |callback| 
      define_method "test_#{callback}_with_if_condition_which_returns_true_should_change_company_name" do
        Company.send(callback.to_sym, :change_name, { :if => condition })
        company = Company.new :name => 'thoughtbot', :callback_flag => true
        assert company.save
        assert_equal 'new name', company.name
      end
      
      define_method "test_#{callback}_with_if_condition_which_returns_false_should_not_change_company_name" do
        Company.send(callback.to_sym, :change_name, { :if => condition })
        company = Company.new :name => 'thoughtbot', :callback_flag => false
        assert company.save
        assert_equal 'thoughtbot', company.name
      end
      
      define_method "test_#{callback}_with_unlesss_condition_which_returns_true_should_not_change_company_name" do
        Company.send(callback.to_sym, :change_name, { :unless => condition })
        company = Company.new :name => 'thoughtbot', :callback_flag => true
        assert company.save
        assert_equal 'thoughtbot', company.name
      end
      
      define_method "test_#{callback}_with_unless_condition_which_returns_false_should_change_company_name" do
        Company.send(callback.to_sym, :change_name, { :unless => condition })
        company = Company.new :name => 'thoughtbot', :callback_flag => false
        assert company.save
        assert_equal 'new name', company.name
      end
    end
    
    update_callbacks.each do |callback| 
      define_method "test_#{callback}_with_if_condition_which_returns_true_should_change_company_name" do
        Company.send(callback.to_sym, :change_name, { :if => condition })
        company = Company.create :name => 'thoughtbot', :callback_flag => true
        assert company.save
        assert_equal 'new name', company.name
      end
      
      define_method "test_#{callback}_with_if_condition_which_returns_false_should_not_change_company_name" do
        Company.send(callback.to_sym, :change_name, { :if => condition })
        company = Company.create :name => 'thoughtbot', :callback_flag => false
        assert company.save
        assert_equal 'thoughtbot', company.name
      end
      
      define_method "test_#{callback}_with_unless_condition_which_returns_true_should_not_change_company_name" do
        Company.send(callback.to_sym, :change_name, { :unless => condition })
        company = Company.create :name => 'thoughtbot', :callback_flag => true
        assert company.save
        assert_equal 'thoughtbot', company.name
      end
      
      define_method "test_#{callback}_with_unless_condition_which_returns_false_should_change_company_name" do
        Company.send(callback.to_sym, :change_name, { :unless => condition })
        company = Company.create :name => 'thoughtbot', :callback_flag => false
        assert company.save
        assert_equal 'new name', company.name
      end
    end
    
    destroy_callbacks.each do |callback|
      define_method "test_#{callback}_with_if_condition_which_returns_true_should_change_company_name" do
        Company.send(callback.to_sym, :change_name, { :if => condition })
        company = Company.new :name => 'thoughtbot', :callback_flag => true
        assert company.save
        assert company.destroy
        assert_equal 'new name', company.name unless company.frozen?
      end
      
      define_method "test_#{callback}_with_if_condition_which_returns_false_should_not_change_company_name" do
        Company.send(callback.to_sym, :change_name, { :if => condition })
        company = Company.new :name => 'thoughtbot', :callback_flag => false
        assert company.save
        assert company.destroy
        assert_equal 'thoughtbot', company.name
      end
      
      define_method "test_#{callback}_with_unless_condition_which_returns_true_should_not_change_company_name" do
        Company.send(callback.to_sym, :change_name, { :unless => condition })
        company = Company.new :name => 'thoughtbot', :callback_flag => true
        assert company.save
        assert company.destroy
        assert_equal 'thoughtbot', company.name
      end
      
      define_method "test_#{callback}_with_unless_condition_which_returns_false_should_change_company_name" do
        Company.send(callback.to_sym, :change_name, { :unless => condition })
        company = Company.new :name => 'thoughtbot', :callback_flag => false
        assert company.save
        assert company.destroy
        assert_equal 'new name', company.name unless company.frozen?
      end
    end
  
    define_method "test_after_find_with_if_condition_which_returns_true_should_change_company_name" do
      Company.send(:after_find, :change_name, { :if => condition })
      company = Company.new :name => 'thoughtbot', :callback_flag => true
      assert company.save
      company = Company.find company.id
      assert_equal 'new name', company.name
    end

    define_method "test_after_find_with_if_condition_which_returns_false_should_not_change_company_name" do
      Company.send(:after_find, :change_name, { :if => condition })
      company = Company.new :name => 'thoughtbot', :callback_flag => false
      assert company.save
      company = Company.find company.id
      assert_equal 'thoughtbot', company.name
    end

    define_method "test_after_find_with_unless_condition_which_returns_true_should_not_change_company_name" do
      Company.send(:after_find, :change_name, { :unless => condition })
      company = Company.new :name => 'thoughtbot', :callback_flag => true
      assert company.save
      company = Company.find company.id
      assert_equal 'thoughtbot', company.name
    end

    define_method "test_after_find_with_unless_condition_which_returns_false_should_change_company_name" do
      Company.send(:after_find, :change_name, { :unless => condition })
      company = Company.new :name => 'thoughtbot', :callback_flag => false
      assert company.save
      company = Company.find company.id
      assert_equal 'new name', company.name
    end
  
    define_method "test_after_initialize_with_if_condition_which_returns_true_should_change_company_name" do
      Company.send(:after_initialize, :change_name, { :if => condition })
      company = Company.new :name => 'thoughtbot', :callback_flag => true
      assert company.save
      company = Company.find company.id
      assert_equal 'new name', company.name
    end

    define_method "test_after_initialize_with_if_condition_which_returns_false_should_not_change_company_name" do
      Company.send(:after_initialize, :change_name, { :if => condition })
      company = Company.new :name => 'thoughtbot', :callback_flag => false
      assert_equal 'thoughtbot', company.name
    end

    define_method "test_after_initialize_with_unless_condition_which_returns_true_should_not_change_company_name" do
      Company.send(:after_initialize, :change_name, { :unless => condition })
      company = Company.new :name => 'thoughtbot', :callback_flag => true
      assert_equal 'thoughtbot', company.name
    end

    define_method "test_after_initialize_with_unless_condition_which_returns_false_should_change_company_name" do
      Company.send(:after_initialize, :change_name, { :unless => condition })
      company = Company.new :name => 'thoughtbot', :callback_flag => false
      assert_equal 'new name', company.name
    end
  end
  
  def teardown
    Object.class_eval do
      remove_const Company.to_s if const_defined? Company.to_s
    end
  end
  
end
