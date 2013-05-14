class AddParentIdToTask < ActiveRecord::Migration
  def change
    add_column :tasks, :parent_id, :string
    add_column :tasks, :integer, :string
  end
end
