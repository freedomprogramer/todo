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
      if @todo_list.destroy
        format.json { render json: @done_thing }
      end
    end
  end

  def tracks
    start_date = params[:start_date].split('/')
      .unshift(params[:start_date].split('/').last)
      .join('-') + ' 00:00:00'

    end_date = params[:end_date].split('/')
      .unshift(params[:end_date].split('/').last)
      .join('-') + ' 00:00:00'

      @tracked_done_things = current_user.tasks.done_things.tracked_done_things(start_date, end_date)

    respond_to do |format|
      format.json { render json: @tracked_done_things }
    end
  end

end
