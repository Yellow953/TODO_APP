class CreateTodoItems < ActiveRecord::Migration[7.0]
  def change
    create_table :todo_items do |t|
      t.string :name
      t.belongs_to :todo, :default => 0
      t.integer :done

      t.timestamps
    end
  end
end
