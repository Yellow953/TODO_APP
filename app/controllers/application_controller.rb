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
        
        respond_to do |format|
            if @todo_item1.save
                format.turbo_stream { render turbo_stream: turbo_stream.replace("bar", partial: "layouts/bar", locals: { x: @todo_item1.todo.todo_items.where(done: 1).count, y: @todo_item1.todo.todo_items.count }) }
                format.html { redirect_to my_todo_items_path(@todo_item1.todo), success: "Done." }
            end
        end
    end
    
    def unmark
        @todo_item1 = TodoItem.find(params[:id])
        @todo_item1.done = 0
        respond_to do |format|
            if @todo_item1.save
                format.turbo_stream { render turbo_stream: turbo_stream.replace("bar", partial: "layouts/bar", locals: { x: @todo_item1.todo.todo_items.where(done: 1).count, y: @todo_item1.todo.todo_items.count }) }
                format.html { redirect_to my_todo_items_path(@todo_item1.todo), success: "Undone." }
            end
        end
    end

end