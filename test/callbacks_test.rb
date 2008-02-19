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

        company = Company.new :name => 'thoughtbot', :flag => true
        assert company.save
        assert_equal 'new name', company.name
      end
      
      define_method "test_#{callback}_with_if_condition_#{condition.class}_which_returns_false_should_not_change_company_name" do
        Company.send callback.to_sym, :change_name, :if => condition

        company = Company.new :name => 'thoughtbot', :flag => false
        assert company.save
        assert_equal 'thoughtbot', company.name
      end
      
      define_method "test_#{callback}_with_unless_condition_#{condition.class}_which_returns_true_should_not_change_company_name" do
        Company.send callback.to_sym, :change_name, :unless => condition

        company = Company.new :name => 'thoughtbot', :flag => true
        assert company.save
        assert_equal 'thoughtbot', company.name
      end
      
      define_method "test_#{callback}_with_unless_condition_#{condition.class}_which_returns_false_should_change_company_name" do
        Company.send callback.to_sym, :change_name, :unless => condition

        company = Company.new :name => 'thoughtbot', :flag => false
        assert company.save
        assert_equal 'new name', company.name
      end

      define_method "test_#{callback}_with_if_condition_#{condition.class}_which_returns_true_should_raise_an_exception_if_its_callback_is_not_a_supported_type" do
        Company.send callback.to_sym, [], :if => condition

        company = Company.new :name => 'thoughtbot', :flag => true
        assert_raises(ActiveRecord::ActiveRecordError) do 
          assert company.save
        end
      end

      define_method "test_#{callback}_with_unless_condition_#{condition.class}_which_returns_false_should_raise_an_exception_if_its_callback_is_not_a_supported_type" do
        Company.send callback.to_sym, [], :unless => condition

        company = Company.new :name => 'thoughtbot', :flag => false
        assert_raises(ActiveRecord::ActiveRecordError) do 
          assert company.save
        end
      end
    end
    
    update_callbacks.each do |callback| 
      define_method "test_#{callback}_with_if_condition_#{condition.class}_which_returns_true_should_change_company_name" do
        Company.send callback.to_sym, :change_name, :if => condition

        company = Company.create :name => 'thoughtbot', :flag => true
        assert company.save
        assert_equal 'new name', company.name
      end
      
      define_method "test_#{callback}_with_if_condition_#{condition.class}_which_returns_false_should_not_change_company_name" do
        Company.send callback.to_sym, :change_name, :if => condition

        company = Company.create :name => 'thoughtbot', :flag => false
        assert company.save
        assert_equal 'thoughtbot', company.name
      end
      
      define_method "test_#{callback}_with_unless_condition_#{condition.class}_which_returns_true_should_not_change_company_name" do
        Company.send callback.to_sym, :change_name, :unless => condition

        company = Company.create :name => 'thoughtbot', :flag => true
        assert company.save
        assert_equal 'thoughtbot', company.name
      end
      
      define_method "test_#{callback}_with_unless_condition_#{condition.class}_which_returns_false_should_change_company_name" do
        Company.send callback.to_sym, :change_name, :unless => condition

        company = Company.create :name => 'thoughtbot', :flag => false
        assert company.save
        assert_equal 'new name', company.name
      end

      define_method "test_#{callback}_with_if_condition_#{condition.class}_which_returns_true_should_raise_an_exception_if_its_callback_is_not_a_supported_type" do
        Company.send callback.to_sym, [], :if => condition

        company = Company.create :name => 'thoughtbot', :flag => true
        assert_raises(ActiveRecord::ActiveRecordError) do 
          assert company.save
        end
      end

      define_method "test_#{callback}_with_unless_condition_#{condition.class}_which_returns_false_should_raise_an_exception_if_its_callback_is_not_a_supported_type" do
        Company.send callback.to_sym, [], :unless => condition

        company = Company.create :name => 'thoughtbot', :flag => false
        assert_raises(ActiveRecord::ActiveRecordError) do 
          assert company.save
        end
      end
    end
    
    destroy_callbacks.each do |callback|
      define_method "test_#{callback}_with_if_condition_#{condition.class}_which_returns_true_should_toggle_flag" do
        Company.send callback.to_sym, :toggle_flag, :if => condition

        company = Company.new :name => 'thoughtbot', :flag => true
        assert company.save
        assert company.destroy
        assert ! company.flag
      end
      
      define_method "test_#{callback}_with_if_condition_#{condition.class}_which_returns_false_should_not_toggle_flag" do
        Company.send callback.to_sym, :toggle_flag, :if => condition

        company = Company.new :name => 'thoughtbot', :flag => false
        assert company.save
        assert company.destroy
        assert ! company.flag
      end
      
      define_method "test_#{callback}_with_unless_condition_#{condition.class}_which_returns_true_should_not_toggle_flag" do
        Company.send callback.to_sym, :toggle_flag, :unless => condition

        company = Company.new :name => 'thoughtbot', :flag => true
        assert company.save
        assert company.destroy
        assert company.flag
      end
      
      define_method "test_#{callback}_with_unless_condition_#{condition.class}_which_returns_false_should_toggle_flag" do
        Company.send callback.to_sym, :toggle_flag, :unless => condition

        company = Company.new :name => 'thoughtbot', :flag => false
        assert company.save
        assert company.destroy
        assert company.flag
      end

      define_method "test_#{callback}_with_if_condition_#{condition.class}_which_returns_true_should_raise_an_exception_if_its_callback_is_not_a_supported_type" do
        Company.send callback.to_sym, [], :if => condition

        company = Company.new :name => 'thoughtbot', :flag => true
        assert company.save
        assert_raises(ActiveRecord::ActiveRecordError) do 
          assert company.destroy
        end
      end

      define_method "test_#{callback}_with_unless_condition_#{condition.class}_which_returns_false_should_raise_an_exception_if_its_callback_is_not_a_supported_type" do
        Company.send callback.to_sym, [], :unless => condition

        company = Company.new :name => 'thoughtbot', :flag => false
        assert company.save
        assert_raises(ActiveRecord::ActiveRecordError) do 
          assert company.destroy
        end
      end
    end
  end

  conditions.each do |condition|
    basic_callbacks.each do |callback| 
      define_method "test_#{callback}_with_string_callback_with_if_condition_#{condition.class}_which_returns_true_should_change_company_name" do
        Company.send callback.to_sym, 'change_name', :if => condition

        company = Company.new :name => 'thoughtbot', :flag => true
        assert company.save
        assert_equal 'new name', company.name
      end
      
      define_method "test_#{callback}_with_string_callback_with_if_condition_#{condition.class}_which_returns_false_should_not_change_company_name" do
        Company.send callback.to_sym, 'change_name', :if => condition

        company = Company.new :name => 'thoughtbot', :flag => false
        assert company.save
        assert_equal 'thoughtbot', company.name
      end
      
      define_method "test_#{callback}_with_string_callback_with_unless_condition_#{condition.class}_which_returns_true_should_not_change_company_name" do
        Company.send callback.to_sym, 'change_name', :unless => condition

        company = Company.new :name => 'thoughtbot', :flag => true
        assert company.save
        assert_equal 'thoughtbot', company.name
      end
      
      define_method "test_#{callback}_with_string_callback_with_unless_condition_#{condition.class}_which_returns_false_should_change_company_name" do
        Company.send callback.to_sym, 'change_name', :unless => condition

        company = Company.new :name => 'thoughtbot', :flag => false
        assert company.save
        assert_equal 'new name', company.name
      end
    end
    
    update_callbacks.each do |callback| 
      define_method "test_#{callback}_with_string_callback_with_if_condition_#{condition.class}_which_returns_true_should_change_company_name" do
        Company.send callback.to_sym, 'change_name', :if => condition

        company = Company.create :flag => true
        assert company.save
        assert_equal 'new name', company.name
      end
      
      define_method "test_#{callback}_with_string_callback_with_if_condition_#{condition.class}_which_returns_false_should_not_change_company_name" do
        Company.send callback.to_sym, 'change_name', :if => condition

        company = Company.create :name => 'thoughtbot', :flag => false
        assert company.save
        assert_equal 'thoughtbot', company.name
      end
      
      define_method "test_#{callback}_with_string_callback_with_unless_condition_#{condition.class}_which_returns_true_should_not_change_company_name" do
        Company.send callback.to_sym, 'change_name', :unless => condition

        company = Company.create :name => 'thoughtbot', :flag => true
        assert company.save
        assert_equal 'thoughtbot', company.name
      end
      
      define_method "test_#{callback}_with_string_callback_with_unless_condition_#{condition.class}_which_returns_false_should_change_company_name" do
        Company.send callback.to_sym, 'change_name', :unless => condition

        company = Company.create :name => 'thoughtbot', :flag => false
        assert company.save
        assert_equal 'new name', company.name
      end
    end
    
    destroy_callbacks.each do |callback|
      define_method "test_#{callback}_with_string_callback_with_if_condition_#{condition.class}_which_returns_true_should_toggle_flag" do
        Company.send callback.to_sym, 'toggle_flag; true', :if => condition

        company = Company.new :flag => true
        assert company.save
        assert company.destroy
        assert ! company.flag
      end
      
      define_method "test_#{callback}_with_string_callback_with_if_condition_#{condition.class}_which_returns_false_should_not_toggle_flag" do
        Company.send callback.to_sym, 'toggle_flag', :if => condition

        company = Company.new :flag => false
        assert company.save
        assert company.destroy
        assert ! company.flag
      end
      
      define_method "test_#{callback}_with_string_callback_with_unless_condition_#{condition.class}_which_returns_true_should_not_toggle_flag" do
        Company.send callback.to_sym, 'toggle_flag', :unless => condition

        company = Company.new :flag => true
        assert company.save
        assert company.destroy
        assert company.flag
      end
      
      define_method "test_#{callback}_with_string_callback_unless_condition_#{condition.class}_which_returns_false_should_toggle_flag" do
        Company.send callback.to_sym, 'toggle_flag', :unless => condition

        company = Company.new :flag => false
        assert company.save
        assert company.destroy
        assert company.flag
      end
    end
  end

  conditions.each do |condition|
    basic_callbacks.each do |callback| 
      define_method "test_#{callback}_with_block_callback_with_if_condition_#{condition.class}_which_returns_true_should_change_company_name" do
        Company.send callback.to_sym, :if => condition do |record|
          record.change_name
        end

        company = Company.new :name => 'thoughtbot', :flag => true
        assert company.save
        assert_equal 'new name', company.name
      end
      
      define_method "test_#{callback}_with_block_callback_with_if_condition_#{condition.class}_which_returns_false_should_not_change_company_name" do
        Company.send callback.to_sym, :if => condition do |record|
          record.change_name
        end

        company = Company.new :name => 'thoughtbot', :flag => false
        assert company.save
        assert_equal 'thoughtbot', company.name
      end
      
      define_method "test_#{callback}_with_block_callback_with_unless_condition_#{condition.class}_which_returns_true_should_not_change_company_name" do
        Company.send callback.to_sym, :unless => condition do |record|
          record.change_name
        end

        company = Company.new :name => 'thoughtbot', :flag => true
        assert company.save
        assert_equal 'thoughtbot', company.name
      end
      
      define_method "test_#{callback}_with_block_callback_with_unless_condition_#{condition.class}_which_returns_false_should_change_company_name" do
        Company.send callback.to_sym, :unless => condition do |record|
          record.change_name
        end

        company = Company.new :name => 'thoughtbot', :flag => false
        assert company.save
        assert_equal 'new name', company.name
      end
    end
    
    update_callbacks.each do |callback| 
      define_method "test_#{callback}_with_block_callback_with_if_condition_#{condition.class}_which_returns_true_should_change_company_name" do
        Company.send callback.to_sym, :if => condition do |record|
          record.change_name
        end

        company = Company.create :name => 'thoughtbot', :flag => true
        assert company.save
        assert_equal 'new name', company.name
      end
      
      define_method "test_#{callback}_with_block_callback_with_if_condition_#{condition.class}_which_returns_false_should_not_change_company_name" do
        Company.send callback.to_sym, :if => condition do |record|
          record.change_name
        end

        company = Company.create :name => 'thoughtbot', :flag => false
        assert company.save
        assert_equal 'thoughtbot', company.name
      end
      
      define_method "test_#{callback}_with_block_callback_with_unless_condition_#{condition.class}_which_returns_true_should_not_change_company_name" do
        Company.send callback.to_sym, :unless => condition do |record|
          record.change_name
        end

        company = Company.create :name => 'thoughtbot', :flag => true
        assert company.save
        assert_equal 'thoughtbot', company.name
      end
      
      define_method "test_#{callback}_with_block_callback_with_unless_condition_#{condition.class}_which_returns_false_should_change_company_name" do
        Company.send callback.to_sym, :unless => condition do |record|
          record.change_name
        end

        company = Company.create :name => 'thoughtbot', :flag => false
        assert company.save
        assert_equal 'new name', company.name
      end
    end
    
    destroy_callbacks.each do |callback|
      define_method "test_#{callback}_with_block_callback_with_if_condition_#{condition.class}_which_returns_true_should_toggle_flag" do
        Company.send callback.to_sym, :if => condition do |record|
          record.toggle_flag
        end

        company = Company.new :name => 'thoughtbot', :flag => true
        assert company.save
        assert company.destroy
        assert ! company.flag
      end
      
      define_method "test_#{callback}_with_block_callback_with_if_condition_#{condition.class}_which_returns_false_should_not_toggle_flag" do
        Company.send callback.to_sym, :if => condition do |record|
          record.toggle_flag
        end

        company = Company.new :name => 'thoughtbot', :flag => false
        assert company.save
        assert company.destroy
        assert ! company.flag
      end
      
      define_method "test_#{callback}_with_block_callback_with_unless_condition_#{condition.class}_which_returns_true_should_not_toggle_flag" do
        Company.send callback.to_sym, :unless => condition do |record|
          record.toggle_flag
        end

        company = Company.new :name => 'thoughtbot', :flag => true
        assert company.save
        assert company.destroy
        assert company.flag
      end
      
      define_method "test_#{callback}_with_block_callback_with_unless_condition_#{condition.class}_which_returns_false_should_toggle_flag" do
        Company.send callback.to_sym, :unless => condition do |record|
          record.toggle_flag
        end

        company = Company.new :name => 'thoughtbot', :flag => false
        assert company.save
        assert company.destroy
        assert company.flag
      end
    end
  end

  def teardown
    Object.class_eval do
      remove_const "Company" if const_defined? "Company"
    end
  end
  
end
