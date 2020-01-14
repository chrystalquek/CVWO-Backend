class AddAdminToTodos < ActiveRecord::Migration[6.0]
  def change
    add_column :todos, :admin, :boolean
  end
end
