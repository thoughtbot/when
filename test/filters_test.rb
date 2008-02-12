require File.join(File.dirname(__FILE__), 'test_helper')
require File.join(File.dirname(__FILE__), 'fixtures', 'companies_controller')

class FiltersTest < ActionController::TestCase

  tests CompaniesController

  def setup
    @controller = CompaniesController.new
    @request = ActionController::TestRequest.new
    @response = ActionController::TestResponse.new
    ActionController::Routing::Routes.draw do |map|
      map.connect 'companies', :controller => 'companies'
    end
  end

  def test_before_filter_if
    get :index, :q => 'before_filter_if'

    assert_equal 'before_filter_if', @controller.attribute1
  end

  def test_before_filter_unless
    get :index, :q => 'before_filter_unless'

    assert_nil @controller.attribute2
  end

  def test_after_filter_if
    get :index, :q => 'after_filter_if'

    assert_equal 'after_filter_if', @controller.attribute3
  end

  def test_after_filter_unless
    get :index, :q => 'after_filter_unless'

    assert_nil @controller.attribute4
  end

end
