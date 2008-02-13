class CompaniesController < ActionController::Base

  attr_accessor :name, 
    :filter_flag

  def change_name
    self.name = 'new name'
  end
  
  def flag?
    filter_flag == true
  end

  def index
    render :nothing => true
  end

end
