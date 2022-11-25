class ApplicationController < ActionController::Base
    before_action :authenticate_user!, only: %i[ my_todos my_todo_items mark unmark ]

    def index
    end
   
    def my_todos
        @todo = Todo.new
    end
    
    def my_todo_items
        @todo = Todo.find(params[:id])
        @todo_item = TodoItem.new
    end

    def mark
        @todo_item1 = TodoItem.find(params[:id])
        @todo_item1.done = 1
        if @todo_item1.save
            flash[:success] = "Todo Item Done"
        end
        redirect_to my_todo_items_url(id: @todo_item1.todo_id)
    end
    
    def unmark
        @todo_item1 = TodoItem.find(params[:id])
        @todo_item1.done = 0
        if @todo_item1.save
            flash[:success] = "Todo Item Undone"
        end
        redirect_to my_todo_items_url(id: @todo_item1.todo_id)
    end

end