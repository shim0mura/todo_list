class Position < ActiveRecord::Base

  before_save do |record|
    record.position = JSON.generate(record.position)
  end

  def set(id, position_array = ["xx"])
    self.position = position_array.map do |task|
      task = id if task == "xx" 
      task
    end
  end

end
