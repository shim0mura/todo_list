class Position < ActiveRecord::Base

  before_save do |record|
    record.position = JSON.generate(record.position)
  end

  def set(id_map, position_array)
    self.position = position_array.map do |task_id|
      # tmp_idだったらtask.idに変換
      if task_id =~ /^xxx/
        id_map[task_id.slice(/\d+/)].to_i
      else
        task_id.to_i
      end
    end
  end

end
