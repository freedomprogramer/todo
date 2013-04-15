require 'spec_helper'

describe Task do
  context 'failure' do
    before(:each) do
        @attr = { task_name: "", status: "" }
    end

    it "when task_name and status is empty" do
      expect{
        Task.create(@attr)
      }.not_to change(Task, :count)
    end

    it "when task_name is empty" do
      @attr[:status] = 'undo'

      expect{
        Task.create(@attr)
      }.not_to change(Task, :count)
    end

    it "when  status is empty" do
      @attr[:task_name] = 'rails learning'

      expect{
        Task.create(@attr)
      }.not_to change(Task, :count)
    end

    it "when  status is one of [undo, done]" do
      @attr[:task_name] = 'rails learning'
      @attr[:status] = 'ok'

      expect{
        Task.create(@attr)
      }.not_to change(Task, :count)
    end
  end

  context 'success' do
    before(:each) do
      @attr = { task_name: 'learn jquery', status: 'undo' }
    end

    it "should create a todo" do
      expect{
        Task.create(@attr)
      }.to change(Task, :count).to(1)
    end
  end
end
