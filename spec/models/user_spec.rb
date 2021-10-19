require 'rails_helper'

RSpec.describe User, type: :model do
  
  describe 'Validations' do
    before do 
      @test_user = User.new(:email => "foo@bar.com", :name => "foo bar", :password => "foobar", :password_confirmation => "foobar")
    end
    it "passes when all fields are set" do
      expect(@test_user.valid?).to eq(true)
    end

    it "fails when name is nil" do
      @test_user.name = nil
      expect(@test_user.valid?).to eq(false)
    end

    it "fails when password is nil" do
      @test_user.password = nil
      @test_user.valid?
      expect(@test_user.errors.full_messages).to include "Password can't be blank"
    end

    it "fails when password_confirmation is nil" do
      @test_user.password_confirmation = nil
      expect(@test_user.valid?).to eq(false)
    end

    it "fails when password and password_confirmation does not match" do
      @test_user.password_confirmation = "barfoo"
      expect(@test_user.valid?).to eq(false)
    end

    it "fails when email address is not unique" do
      User.create(:email => "foo@bar.com", :name => "foo bar", :password => "foobar", :password_confirmation => "foobar")
      expect(@test_user.valid?).to eq(false)
    end

    it "fails when password length is less than 4" do
      @test_user.password = "123"
      @test_user.password_confirmation = "123"
      expect(@test_user.valid?).to eq(false)
    end
  end

  describe '.authenticate_with_credentials' do
    it "returns user when successfully authenticate" do
      user = User.authenticate_with_credentials("foo@bar.com", "foobar")
      expect(user).to be == @test_user
    end

    it "returns nil when authentication fails" do
      user = User.authenticate_with_credentials("foo@bar.com", "barfoo")
      expect(user).to be == nil
    end

    it "passes user auth" do
      user = User.authenticate_with_credentials("  foo@bar.com  ", "foobar")
      expect(user).to be == @test_user
    end

    it "successfully auths wrong lettercase" do
      user = User.authenticate_with_credentials("FOO@BAR.COM", "foobar")
      expect(user).to be == @test_user
    end
  end

end
