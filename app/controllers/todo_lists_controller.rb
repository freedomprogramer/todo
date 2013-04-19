class TodoListsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @undo_things = current_user.tasks.undo_things
    @done_things = current_user.tasks.today.done_things
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
      if @task.destroy
        format.json { render json: {status: 'success'} }
      end
    end
  end

  def tracks
    @tracked_done_things = current_user.tasks.done_things
      .tracked_done_things(params[:start_date], params[:end_date])

    respond_to do |format|
      format.json { render json: @tracked_done_things }
    end
  end

end
