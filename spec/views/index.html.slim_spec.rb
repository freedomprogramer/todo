require 'spec_helper'

describe "todo_lists/index" do
  before(:each) do
    view.stub(:current_user)
      .and_return(User.create(email: '894849464@qq.com',
                              password: 'jackielee',
                              username: 'jackie'))
  end

  context "with 2 todo and without done thing" do
    before(:each) do
      assign(:todo_lists, [
        stub_model(TodoList, :todo_name => 'learn jquery'),
        stub_model(TodoList, :todo_name => 'add rspec test')
      ])

      assign(:done_things, [])
    end

    it "display both todo thing" do
      render
      expect(rendered).to match /learn jquery/
      expect(rendered).to match /add rspec test/
    end
  end

  context "with 1 done thing and without todo" do
    before(:each) do
      assign(:done_things, [
        mock_model(DoneThing, :done_name => 'learn jquery')
      ])

      assign(:todo_lists, [])
    end

    it "display the one done thing" do
      render
      expect(rendered).to match /learn jquery/
    end
  end

  context "with 1 done thing and 1 todo" do
    before(:each) do
      assign(:done_things, [
        mock_model(DoneThing, :done_name => 'add rspec test')
      ])

      assign(:todo_lists, [
        mock_model(TodoList, todo_name: 'learn jquery')               ])
    end

    it "display all done thing and todo" do
      render
      expect(rendered).to match /learn jquery/
      expect(rendered).to match /add rspec test/
    end
  end
end
