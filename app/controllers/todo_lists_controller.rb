class TodoListsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @undo_things = Task.where('status=?', 'undo')
    @done_things = Task.where('status=?', 'done')
  end

  def create
    @task = Task.new(params[:task])

    respond_to do |format|
      if @task.save
        format.json { render json: @task }
      end
    end
  end

  def update
    @task = Task.find(params[:id])

    respond_to do |format|
      if @task.update_attributes(status: 'done')
        format.json { render json: @task }
      end
    end
  end

  def destroy
    @task = Task.find(params[:id])
    respond_to do |format|
      if @todo_list.destroy
        format.json { render json: @done_thing }
      end
    end
  end
end
