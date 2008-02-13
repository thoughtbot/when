class Company < ActiveRecord::Base

  attr_accessor :callback_flag

  def change_name
    self.name = 'new name' unless frozen?
  end
  
  def flag?
    callback_flag == true
  end
  
end
