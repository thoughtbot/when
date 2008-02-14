class CompaniesController < ActionController::Base

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

end
