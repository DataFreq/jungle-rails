require 'rails_helper'

RSpec.describe User, type: :model do
  
  describe 'Validations' do
    before do 
      @user = User.new(:email => "foo@bar.com", :name => "foo bar", :password => "foobar", :password_confirmation => "foobar")
    end
    it "passes when all fields are set" do
      @user.valid?
      expect(@user.errors.full_messages).to be_empty
    end

    it "fails when name is nil" do
      @user.name = nil
      @user.valid?
      expect(@user.errors.full_messages).to eq([])
    end

    it "fails when password is nil" do
      @user.password = nil
      @user.valid?
      expect(@user.errors.full_messages).to include "Password can't be blank"
    end

    it "fails when password_confirmation is nil" do
      @user.password_confirmation = nil
      @user.valid?
      
      expect(@user.errors.full_messages).to eq([])
    end

    it "fails when password and password_confirmation does not match" do
      @user.password_confirmation = "barfoo"
      @user.valid?
      expect(@user.errors.full_messages).not_to be_empty
    end

    it "fails when email address is not unique" do
      User.create(:email => "foo@bar.com", :name => "foo bar", :password => "foobar", :password_confirmation => "foobar")
      @user.valid?
      expect(@user.errors.full_messages).to eq([])
    end

    it "fails when password length is less than 4" do
      @user.password = "123"
      @user.password_confirmation = "123"
      @user.valid?
      expect(@user.errors.full_messages).to eq([])
    end
  end

  describe '.authenticate_with_credentials' do
    it "returns user when successfully authenticate" do
      @user.save
      user = User.authenticate_with_credentials("foo@bar.com", "foobar")
      expect(user).to be == @user
    end

    it "returns nil when authentication fails" do
      @user.save
      user = User.authenticate_with_credentials("foo@bar.com", "barfoo")
      expect(user).to be == nil
    end

    it "passes user auth" do
      @user.save
      user = User.authenticate_with_credentials("  foo@bar.com  ", "foobar")
      expect(user).to be == @user
    end

    it "successfully auths wrong lettercase" do
      @user.save
      user = User.authenticate_with_credentials("FOO@BAR.COM", "foobar")
      expect(user).to be == @user
    end
  end

end
