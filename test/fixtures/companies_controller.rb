class CompaniesController < ActionController::Base

  (1..14).each do |each| 
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

  append_before_filter :append_before_filter_if,
   :only => :index,
   :if => :append_before_filter_if?

  append_before_filter :append_before_filter_unless,
   :only => :index,
   :unless => :append_before_filter_unless?

  append_after_filter :append_after_filter_if,
   :only => :index,
   :if => :append_after_filter_if?

  append_after_filter :append_after_filter_unless,
   :only => :index,
   :unless => :append_after_filter_unless?

  prepend_before_filter :prepend_before_filter_if,
   :only => :index,
   :if => :prepend_before_filter_if?

  prepend_before_filter :prepend_before_filter_unless,
   :only => :index,
   :unless => :prepend_before_filter_unless?

  prepend_after_filter :prepend_after_filter_if,
   :only => :index,
   :if => :prepend_after_filter_if?

  prepend_after_filter :prepend_after_filter_unless,
   :only => :index,
   :unless => :prepend_after_filter_unless?

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

  def append_before_filter_if?
    params[:q] == 'append_before_filter_if'
  end

  def append_before_filter_if
    self.attribute5 = 'append_before_filter_if'
  end

  def append_before_filter_unless?
    params[:q] == 'append_before_filter_unless'
  end

  def append_before_filter_unless
    self.attribute6 = 'append_before_filter_unless'
  end

  def append_after_filter_if?
    params[:q] == 'append_after_filter_if'
  end

  def append_after_filter_if
    self.attribute7 = 'append_after_filter_if'
  end

  def append_after_filter_unless?
    params[:q] == 'append_after_filter_unless'
  end

  def append_after_filter_unless
    self.attribute8 = 'append_after_filter_unless'
  end

  def prepend_before_filter_if?
    params[:q] == 'prepend_before_filter_if'
  end

  def prepend_before_filter_if
    self.attribute9 = 'prepend_before_filter_if'
  end

  def prepend_before_filter_unless?
    params[:q] == 'prepend_before_filter_unless'
  end

  def prepend_before_filter_unless
    self.attribute10 = 'prepend_before_filter_unless'
  end

  def prepend_after_filter_if?
    params[:q] == 'prepend_after_filter_if'
  end

  def prepend_after_filter_if
    self.attribute11 = 'prepend_after_filter_if'
  end

  def prepend_after_filter_unless?
    params[:q] == 'prepend_after_filter_unless'
  end

  def prepend_after_filter_unless
    self.attribute12 = 'prepend_after_filter_unless'
  end

end
