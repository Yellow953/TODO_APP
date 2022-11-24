class TodoItem < ApplicationRecord

    validates :name, presence: true

    belongs_to :todo

    after_create_commit { broadcast_prepend_to "todo_items" }
    after_update_commit { broadcast_replace_to "todo_items" }
    after_destroy_commit { broadcast_remove_to "todo_items" }

end