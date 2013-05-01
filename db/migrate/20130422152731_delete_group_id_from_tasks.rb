class DeleteGroupIdFromTasks < ActiveRecord::Migration
  def change
    remove_column :tasks, :group_id
  end
end
