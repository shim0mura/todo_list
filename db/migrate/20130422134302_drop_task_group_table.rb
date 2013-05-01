class DropTaskGroupTable < ActiveRecord::Migration
  def change
    drop_table :task_groups
  end
end
