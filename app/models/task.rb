class Task < ActiveRecord::Base
  attr_accessor :tmp_id
  validates :name, presence: true, :length => {:maximum => 30}

  default_scope {where(finished: false)}

  def self.sort_by_position(user_id)
    tasks = self.where(user_id: user_id)

    return tasks if tasks.empty?

    position = JSON.parse(Position.where(user_id: user_id).first.position)
    sorted_tasks = []
    position.each do |id|
      sorted_tasks.concat(tasks.select{|task| task.id == id.to_i })
    end
    sorted_tasks
  end

  def self.find_by_tmp_id(tasks, tmp_id)
    tasks.detect do |task|
      task.tmp_id == tmp_id
    end
  end

  # THINK: 引数tasksはtaskの配列
  #        task_relationみたいなの作るべき？
  def self.sort_by_tmp_id(tasks, tmp_ids)
    tmp_ids.map do |tmp_id|
      find_by_tmp_id(task, tmp_id)
    end
  end

end
