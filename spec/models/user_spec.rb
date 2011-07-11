require 'spec_helper'

describe User do

  before(:each) do
    @attr = { 
      :name => "Example User", 
      :email => "user@example.com",
      :password => "foobar",
      :password_confirmation => "foobar"
     }
  end

  # general test with valid attributes above 
  it "should create a new instance given valid attributes" do
    User.create!(@attr)
  end

  it "should require a name" do
    no_name_user = User.new(@attr.merge(:name => ""))
    no_name_user.should_not be_valid
  end

  it "should require a email address" do
    no_email_user = User.new(@attr.merge(:email => ""))
    no_email_user.should_not be_valid
  end

  it "should reject names that are too long" do
    long_name = "a" * 51
    long_name_user = User.new(@attr.merge(:name => long_name))
    long_name_user.should_not be_valid
  end

  it "should accept valid email addresses" do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      User.new(@attr.merge(:email => address)).should be_valid
    end
  end

  it "should reject invalid email addresses" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    addresses.each do |address|
      User.new(@attr.merge(:email => address)).should_not be_valid
    end
  end

  it "should reject duplicate email addresses" do
    User.create!(@attr)
    user_with_duplication = User.new(@attr)
    user_with_duplication.should_not be_valid
  end
  
  it "should reject email addresses identical up to case" do
    upcase_email = @attr[:email].upcase
    User.create!(@attr.merge(:email => upcase_email))
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end

  describe "password validations" do
    it "should require a password" do
      User.new(@attr.merge(:password => "", :password_confirmation => "")).should_not be_valid
    end

    it "should require a matching password confirmation" do
      User.new(@attr.merge(:password_confirmation => "invalid password confirmation")).should_not be_valid
    end

    it "should reject short passwords" do
      short = "a" * 5
      User.new(@attr.merge(:password => short, :password_confirmation => short)).should_not be_valid
    end

    it "should reject long passwords" do
      long = "a" * 41
      User.new(@attr.merge(:password => long, :password_confirmation => long)).should_not be_valid
    end
  end

  describe "password encryption" do
    before(:each) do
      @user = User.create!(@attr)
    end

    it "should have an encrypted password attribute" do
      @user.should respond_to(:encrypted_password)
    end

    it "should set the encrypted password" do
      @user.encrypted_password.should_not be_blank
    end

    describe "has_password? method" do
      it "should be true if the passwords match" do
        @user.has_password?(@attr[:password]).should be_true
      end

      it "should be false if the passwords don't match" do
        @user.has_password?("invalid").should be_false
      end

      describe "authenticate method" do
        
        it "should return nil on email/password missmatch" do
          wrong_password_user = User.authenticate(@attr[:email], "wrongpass")
          wrong_password_user.should be_nil
        end

        it "should return nil for an email address with no user" do
          nonexistent_user = User.authenticate("bar@foo.com", @attr[:password])
          nonexistent_user.should be_nil
        end

        it "should return user on email/password match" do
          matching_user = User.authenticate(@attr[:email], @attr[:password])
          matching_user.should == @user
        end
      end
    end
  end

  describe "admin attribute" do

    before(:each) do
      @user = User.create!(@attr)
    end

    it "should respond to admin" do
      @user.should respond_to(:admin)
    end

    it "should not be an admin by default" do
      @user.should_not be_admin
    end

    it "should be convertible to an admin" do
      @user.toggle!(:admin)
      @user.should be_admin
    end
  end

  describe "bot associations" do

    before(:each) do
      @user = User.create(@attr)
      @bot1 = Factory(:bot, :user => @user, :created_at => 1.day.ago)
      @bot2 = Factory(:bot, :user => @user, :created_at => 1.hour.ago)
    end

    it "should have a bots attribute" do
      @user.should respond_to(:bots)
    end

    it "should have the right bots in the right order" do
      @user.bots.should == [@bot2, @bot1]
    end

    it "should destroy associated bots" do
      @user.destroy
      [@bot1, @bot2].each do |bot|
        lambda do
          Bot.find(bot.id)
        end.should raise_error(ActiveRecord::RecordNotFound)
      end
    end
    
    describe "bot feed" do
      
      it "should have a feed" do
        @user.should respond_to(:feed)
      end

      it "should include the user's bots" do
        @user.feed.include?(@bot1).should be_true
        @user.feed.include?(@bot2).should be_true
      end

      it "should not include a different user's bots" do
        bot = Factory(:bot,
                      :user => Factory(:user, :email => Factory.next(:email)))
        @user.feed.include?(bot).should be_false
      end
    end
  end
end

# == Schema Information
#
# Table name: users
#
#  id                 :integer(4)      not null, primary key
#  name               :string(255)
#  email              :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  encrypted_password :string(255)
#  salt               :string(255)
#
