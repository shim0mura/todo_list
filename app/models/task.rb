class Task < ActiveRecord::Base
  validates :name, presence: true, :length => {:maximum => 30}

  default_scope where(finished: false)

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

end
