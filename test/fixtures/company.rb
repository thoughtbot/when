class Company < ActiveRecord::Base

  @@bio = nil
  class << self
    def bio
      @@bio
    end
    def bio=(bio)
      @@bio = bio
    end
  end

  @@flag = nil
  class << self
    def flag
      @@flag
    end
    def flag=(flag)
      @@flag = flag
    end
  end
    
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
