require 'spec_helper'

describe TodoListsController do
  before(:each) do
    @user = User.create(email: '894849464@qq.com',
                     password: 'jackielee',
                     username: 'lee')

    sign_in @user
  end

  describe "GET index" do
    it "assigns @todo_lists and @done_things" do
      todo_list = TodoList.create!(todo_name: 'learn jquery')
      done_thing = DoneThing.create!(done_name: 'rspec learning')
      get :index

      expect(assigns(:todo_lists)).to match_array([todo_list])
      expect(assigns(:done_things)).to match_array([done_thing])
    end

    it "renders the index template" do
      get :index
      response.should render_template("index")
    end
  end

  describe "POST create" do
    context "failure" do
      before(:each) do
        @attr = { :todo_name => ""}
      end

      it "should not create a todo" do
        expect{
          post :create, :todo_list => @attr
        }.not_to change(TodoList, :count)
      end
    end

    context "success" do
      before(:each) do
        @attr = { :todo_name => 'learn jquery'}
      end

      it "should create a todo" do
        expect{
          post :create, :todo_list => @attr
        }.to change(TodoList, :count).to(1)
      end

      it "should return a json" do
        post :create, :todo_list => @attr, :format => :json

        expect(response.body).to eq(TodoList.first.to_json)
      end
    end
  end

  describe "DELETE destroy" do
    before(:each) do
      TodoList.create(:todo_name => 'learn jquery')
    end

    context "failure" do
      it "raise a error with unkown id" do
        expect{
          delete :destroy, :id => 2
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context "success" do
      it "destroy a todo and create a done thing" do
        expect{
          p TodoList.all
          delete :destroy, :id => 1
        }.to change(TodoList, :count).to(0)

        expect( DoneThing.count ).to eq(1)
      end

      it "should return @done_thing json" do
        delete :destroy, :id => 1, :format => :json

        expect(response.body).to eq(DoneThing.first.to_json)
      end
    end
  end
end
