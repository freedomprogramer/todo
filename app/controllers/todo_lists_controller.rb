class TodoListsController < ApplicationController
  # GET /todo_lists
  # GET /todo_lists.json
  def index
    @todo_lists = TodoList.all
    @done_things = DoneThing.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @todo_lists }
    end
  end


  def create
    @todo_list = TodoList.new(params[:todo_list])

    respond_to do |format|
      if @todo_list.save
        format.json { render json: @todo_list }
      end
    end
  end

  def destroy
    @todo_list = TodoList.find(params[:id])
    @done_thing = DoneThing.create(done_name: @todo_list.todo_name)
    respond_to do |format|
      if @todo_list.destroy
        format.json { render json: @done_thing }
      end
    end
  end
end
