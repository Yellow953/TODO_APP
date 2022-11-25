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
        format.html { redirect_to my_todo_items_url(id: @todo_item.todo_id), notice: "Todo item was successfully created." }
        format.json { render :show, status: :created, location: @todo_item }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace(@todo_item, partial:"todo_items/form", locals: { todo_item: @todo_item }) }
        flash[:danger] = "something went wrong"
        redirect_to my_todo_items_url(@todo_item.todo_id)
      end
    end
  end

  def update
    respond_to do |format|
      if @todo_item.update(todo_item_params)
        format.html { redirect_to my_todo_items_url(id: @todo_item.todo_id), notice: "Todo item was successfully updated." }
        format.json { render :show, status: :ok, location: @todo_item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @todo_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @tmp = @todo_item.todo_id
    @todo_item.destroy

    respond_to do |format|
      format.html { redirect_to my_todo_items_url(id: @tmp), notice: "Todo item was successfully destroyed." }
      format.json { head :no_content }
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
