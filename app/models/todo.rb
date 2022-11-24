class Todo < ApplicationRecord

    validates :name, presence: true

    belongs_to :user
    has_many :todo_items

end