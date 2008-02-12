class CompaniesController < ActionController::Base

  (1..4).each do |each| 
    attr_accessor :"attribute#{each}"
  end

  before_filter :before_filter_if,
   :only => :index,
   :if => :before_filter_if?

  before_filter :before_filter_unless,
   :only => :index,
   :unless => :before_filter_unless?

  after_filter :after_filter_if,
   :only => :index,
   :if => :after_filter_if?

  after_filter :after_filter_unless,
   :only => :index,
   :unless => :after_filter_unless?

  def index
    render :nothing => true
  end

  def before_filter_if?
    params[:q] == 'before_filter_if'
  end

  def before_filter_if
    self.attribute1 = 'before_filter_if'
  end

  def before_filter_unless?
    params[:q] == 'before_filter_unless'
  end

  def before_filter_unless
    self.attribute2 = 'before_filter_unless'
  end

  def after_filter_if?
    params[:q] == 'after_filter_if'
  end

  def after_filter_if
    self.attribute3 = 'after_filter_if'
  end

  def after_filter_unless?
    params[:q] == 'after_filter_unless'
  end

  def after_filter_unless
    self.attribute4 = 'after_filter_unless'
  end

end
