class Todo < ApplicationRecord

    validates :name, presence: true

    belongs_to :user
    has_many :todo_items

    after_create_commit { broadcast_prepend_to "todos" }
    after_update_commit { broadcast_replace_to "todos" }
    after_destroy_commit { broadcast_remove_to "todos" }

end