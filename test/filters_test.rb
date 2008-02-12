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
    assert_equal 'before_filter_unless', @controller.attribute2
  end

  def test_before_filter_unless
    get :index, :q => 'before_filter_unless'

    assert_nil @controller.attribute2
  end

  def test_after_filter_if
    get :index, :q => 'after_filter_if'

    assert_equal 'after_filter_if', @controller.attribute3
    assert_equal 'after_filter_unless', @controller.attribute4
  end

  def test_after_filter_unless
    get :index, :q => 'after_filter_unless'

    assert_nil @controller.attribute4
  end

  def test_append_before_filter_if
    get :index, :q => 'append_before_filter_if'

    assert_equal 'append_before_filter_if', @controller.attribute5
    assert_equal 'append_before_filter_unless', @controller.attribute6
  end

  def test_append_before_filter_unless
    get :index, :q => 'append_before_filter_unless'

    assert_nil @controller.attribute6
  end

  def test_append_after_filter_if
    get :index, :q => 'append_after_filter_if'

    assert_equal 'append_after_filter_if', @controller.attribute7
    assert_equal 'append_after_filter_unless', @controller.attribute8
  end

  def test_append_after_filter_unless
    get :index, :q => 'append_after_filter_unless'

    assert_nil @controller.attribute8
  end

  def test_prepend_before_filter_if
    get :index, :q => 'prepend_before_filter_if'

    assert_equal 'prepend_before_filter_if', @controller.attribute9
    assert_equal 'prepend_before_filter_unless', @controller.attribute10
  end

  def test_prepend_before_filter_unless
    get :index, :q => 'prepend_before_filter_unless'

    assert_nil @controller.attribute10
  end

  def test_prepend_after_filter_if
    get :index, :q => 'prepend_after_filter_if'

    assert_equal 'prepend_after_filter_if', @controller.attribute11
    assert_equal 'prepend_after_filter_unless', @controller.attribute12
  end

  def test_prepend_after_filter_unless
    get :index, :q => 'prepend_after_filter_unless'

    assert_nil @controller.attribute12
  end

end
