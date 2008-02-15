class CompaniesController < ActionController::Base

  @@bio = nil
  class << self
    def bio
      @@bio
    end
    def bio=(bio)
      @@bio = bio
    end
  end

  attr_accessor :flag,
    :name

  def change_name
    self.name = 'new name'
  end
  
  def flag?
    flag
  end

  def index
    render :nothing => true
  end

  def show
    render :nothing => true
  end

end
