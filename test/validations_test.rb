require File.join(File.dirname(__FILE__), 'test_helper') 

class ValidationsTest < Test::Unit::TestCase
  
  def setup
    load File.join(File.dirname(__FILE__), 'fixtures', 'company.rb')
  end
  
  validations = ['validate', 'validate_on_create']
  conditions = ['lambda {|company| company.callback_flag == true}']
  src = ''
  
  conditions.each do |condition|
    validations.each do |validation| 
      src << <<-END;
        def test_#{validation}_with_if_condition_which_returns_true_should_change_company_name
          Company.class_eval do
            #{validation} :change_name, :if => #{condition}
          end
          company = Company.new :name => 'thoughtbot', :callback_flag => true
          assert company.save
          assert_equal 'new name', company.name
        end
      
        def test_#{validation}_with_if_condition_which_returns_false_should_not_change_company_name
          Company.class_eval do
            #{validation} :change_name, :if => #{condition}
          end
          company = Company.new :name => 'thoughtbot', :callback_flag => false
          assert company.save
          assert_equal 'thoughtbot', company.name
        end
      
        def test_#{validation}_with_unless_condition_which_returns_true_should_not_change_company_name
          Company.class_eval do
            #{validation} :change_name, :unless => #{condition}
          end
          company = Company.new :name => 'thoughtbot', :callback_flag => true
          assert company.save
          assert_equal 'thoughtbot', company.name
        end

        def test_#{validation}_with_unless_condition_which_returns_false_should_change_company_name
          Company.class_eval do
            #{validation} :change_name, :unless => #{condition}
          end
          company = Company.new :name => 'thoughtbot', :callback_flag => false
          assert company.save
          assert_equal 'new name', company.name
        end
      END
    end
    
    src << <<-END;
      def test_validate_on_update_with_if_condition_which_returns_true_should_change_company_name
        Company.class_eval do
          validate_on_update :change_name, :if => #{condition}
        end
        company = Company.create :name => 'thoughtbot', :callback_flag => true
        assert company.save
        assert_equal 'new name', company.name
      end
    
      def test_validate_on_update_with_if_condition_which_returns_false_should_not_change_company_name
        Company.class_eval do
          validate_on_update :change_name, :if => #{condition}
        end
        company = Company.create :name => 'thoughtbot', :callback_flag => false
        assert company.save
        assert_equal 'thoughtbot', company.name
      end
    
      def test_validate_on_update_with_unless_condition_which_returns_true_should_not_change_company_name
        Company.class_eval do
          validate_on_update :change_name, :unless => #{condition}
        end
        company = Company.create :name => 'thoughtbot', :callback_flag => true
        assert company.save
        assert_equal 'thoughtbot', company.name
      end

      def test_validate_on_update_with_unless_condition_which_returns_false_should_change_company_name
        Company.class_eval do
          validate_on_update :change_name, :unless => #{condition}
        end
        company = Company.create :name => 'thoughtbot', :callback_flag => false
        assert company.save
        assert_equal 'new name', company.name
      end
    END
  end
  
  class_eval src, __FILE__, __LINE__

  def teardown
    Object.class_eval do
      remove_const Company.to_s if const_defined? Company.to_s
    end
  end

end
