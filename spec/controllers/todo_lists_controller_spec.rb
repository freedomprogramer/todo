require 'spec_helper'

describe TodoListsController do
  before(:each) do
    @user = User.create(email: '894849464@qq.com',
                        password: 'jackielee/1991',
                        username: 'lee')

    sign_in @user
  end

  describe "GET index" do
    it "assigns @undo_things and @done_things" do
      undo_thing = @user.tasks.create!(task_name: 'learn jquery', status: 'undo')
      done_thing = @user.tasks.create!(task_name: 'rspec learning', status: 'done')
      get :index

      expect(assigns(:undo_things)).to match_array([undo_thing])
      expect(assigns(:done_things)).to match_array([done_thing])
    end

    it "renders the index template" do
      get :index
      response.should render_template("index")
    end
  end

  describe "POST create" do
    before(:each) do
      @attr = { task_name: 'learn jquery', status: 'undo' }
    end

    it "should return a json" do
      post :create, task: @attr, :format => :json

      expect(response.body).to eq(Task.first.to_json)
    end
  end

  describe "PUT update" do
    before(:each) do
      @task = @user.tasks.create!(task_name: 'learn jquery', status: 'undo')
    end

    it "should return @task's json to client" do
      put :update, id: @task.id, task: {status: 'done'}, :format => :json

      expect(response.body).to eq(Task.first.to_json)
    end
  end
end
