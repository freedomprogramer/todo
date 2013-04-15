class TodoListsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @undo_things = current_user.tasks.where('status=?', 'undo')
    @done_things = current_user.tasks.today.order('updated_at DESC').where('status=?', 'done')
  end

  def create
    @task = current_user.tasks.build(params[:task])

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
