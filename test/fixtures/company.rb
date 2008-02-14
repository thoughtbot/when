class Company < ActiveRecord::Base

  attr_accessor :flag

  def change_name
    self.name = 'new name'
  end
  
  def flag?
    flag
  end

  def toggle_flag
    self.flag = ! flag
    return true
  end

end
