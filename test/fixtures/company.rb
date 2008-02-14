class Company < ActiveRecord::Base

  attr_accessor :callback_flag

  def change_name
    self.name = 'new name'
  end
  
  def flag?
    callback_flag == true
  end

  def toggle_callback_flag
    self.callback_flag = ! callback_flag
    return true
  end

end
