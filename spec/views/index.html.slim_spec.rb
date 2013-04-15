require 'spec_helper'

describe "todo_lists/index" do
  before(:each) do
    view.stub(:current_user)
      .and_return(User.create(email: '894849464@qq.com',
                              password: 'jackielee',
                              username: 'jackie'))
  end

  context "with 1 todo and without done thing" do
    before(:each) do
      assign(:undo_things, [
        stub_model(Task, task_name: 'learn jquery', status: 'undo')
      ])

      assign(:done_things, [])
    end

    it "display both todo thing" do
      render
      expect(rendered).to match /learn jquery/
    end
  end

  context "with 1 done thing and without todo" do
    before(:each) do
      assign(:done_things, [
        mock_model(Task, task_name: 'learn jquery', status: 'done')
      ])

      assign(:undo_things, [])
    end

    it "display the one done thing" do
      render
      expect(rendered).to match /learn jquery/
    end
  end

  context "with 1 done thing and 1 todo" do
    before(:each) do
      assign(:done_things, [
        mock_model(Task, task_name: 'add rspec test', status: 'done')
      ])

      assign(:undo_things, [
        mock_model(Task, task_name: 'learn jquery', :status => 'undo')
      ])
    end

    it "display all done thing and todo" do
      render
      expect(rendered).to match /learn jquery/
      expect(rendered).to match /add rspec test/
    end
  end
end
