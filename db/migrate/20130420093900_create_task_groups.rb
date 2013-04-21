class CreateTaskGroups < ActiveRecord::Migration
  def change
    create_table :task_groups do |t|
      t.string :name, :null => false, :limit => 30
      t.text :detail, :null => false

      t.timestamps
    end
  end
end
