class TodoItemsController < ApplicationController
  before_action :set_todo_item, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, only: %i[ show edit update destroy ]

  def index
    @todo_items = TodoItem.all
  end

  def show
  end

  def new
    @todo_item = TodoItem.new
  end

  def edit
    @todo = @todo_item.todo
  end

  def create
    @todo_item = TodoItem.new(todo_item_params)

    respond_to do |format|
      if @todo_item.save
        format.turbo_stream
        format.html { redirect_to my_todo_items_path(@todo_item.todo), notice: "Todo Item was successfully created." }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace("#{helpers.dom_id(@todo_item)}_form", partial: "form", locals: { todo_item: @todo_item }) }
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @todo_item.update(todo_item_params)
        format.html { redirect_to my_todo_items_path(@todo_item.todo), notice: "Todo Item was successfully updated." }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace("#{helpers.dom_id(@todo_item)}_form", partial: "form", locals: { todo_item: @todo_item }) }
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @todo_item.destroy

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove("#{helpers.dom_id(@todo_item)}") }
      format.html { redirect_to my_todo_items_path(@todo_item.todo), notice: "Todo Item was successfully destroyed." }
    end
  end
    
  private
    def set_todo_item
      @todo_item = TodoItem.find(params[:id])
    end

    def todo_item_params
      params.require(:todo_item).permit(:name, :todo_id, :done)
    end
end