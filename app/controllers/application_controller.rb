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
        @x = @todo.todo_items.where(done: 1).count
        @y = @todo.todo_items.count
    end

    def mark
        @todo_item1 = TodoItem.find(params[:id])
        @todo_item1.done = 1
        if @todo_item1.save
            flash[:success] = "Todo Item Done"
        end
        @todo = @todo_item1.todo
        @x = @todo.todo_items.where(done: 1).count
        @y = @todo.todo_items.count
        redirect_to my_todo_items_path(@todo.id)
    end
    
    def unmark
        @todo_item1 = TodoItem.find(params[:id])
        @todo_item1.done = 0
        if @todo_item1.save
            flash[:success] = "Todo Item Undone"
        end
        @todo = @todo_item1.todo
        @x = @todo.todo_items.where(done: 1).count
        @y = @todo.todo_items.count
        redirect_to my_todo_items_path(@todo.id)
    end

end