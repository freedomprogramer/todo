require 'spec_helper'

describe User do
  context "failure" do
    before(:each) do
      @user_attribute = {
        email: 'user@example.com',
        username: 'jackie',
        password: 'jackielee'
      }

      @registed_user = {
        email: 'jackielee@gmail.com',
        password: 'jackielee',
        username: 'lee'
      }

      User.create(@registed_user)
    end

    it "when username is not fill in" do
      @user_attribute[:username] = ''

      expect{
        User.create(@user_attribute)
      }.not_to change(User, :count)
    end

    it "when email is not fill in" do
      @user_attribute[:email] = ''

      expect{
        User.create(@user_attribute)
      }.not_to change(User, :count)
    end

    it "when password is not fill in" do
      @user_attribute[:password] = ''

      expect{
        User.create(@user_attribute)
      }.not_to change(User, :count)
    end

    it "when email is invalide" do
      @user_attribute[:email] = 'fjwoe'

      expect{
        User.create(@user_attribute)
      }.not_to change(User, :count)
    end

    it "when password is to short" do
      @user_attribute[:password] = '123'

      expect{
        User.create(@user_attribute)
      }.not_to change(User, :count)
    end

    it "when email is same with other people" do
      @registed_user[:username] = 'jackie'

      expect{
        User.create(@registed_user)
      }.not_to change(User, :count)
    end

    it "when username is same with other people" do
      @registed_user[:email] = 'example@gmail.com'

      expect{
        User.create(@registed_user)
      }.not_to change(User, :count)
    end
  end

  context "success" do
    it "create user with valid arguments" do
      expect{
        User.create(email: 'user@example.com',
                    username: 'jackie',
                    password: 'jackielee')
      }.to change(User, :count).to(1)
    end
  end
end
