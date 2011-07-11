require 'spec_helper'

describe Bot do
  
  before(:each) do
    @user = Factory(:user)
    @attr = { :ip_address => "192.168.0.1" }
  end

  it "should create a instance given valid attributes" do
    @user.bots.create!(@attr)
  end

  describe "user association" do
    
    before(:each) do
      @bot = @user.bots.create(@attr)
    end

    it "should have a user" do
      @bot.should respond_to(:user)
    end

    it "should have the right associated user" do
      @bot.user_id.should == @user.id
      @bot.user.should == @user
    end
  end

  describe "validations" do
    
    it "should require a user id" do
      Bot.new(@attr).should_not be_valid
    end

    it "should require nonblank ip address" do
      @user.bots.build(:ip_address => " ").should_not be_valid
    end

    it "should require a valid ip address" do
      ip_addresses = ["192.168.0.1", "8.8.8.8", "10.10.10.10"]
      ip_addresses.each do |ip|
        @user.bots.build(@attr.merge(:ip_address => ip)).should be_valid
      end
    end

    it "should reject invalid ip addresses" do
      invalid_ips = ["foobar", "10.0.0.", "888.100.0.0"]
      invalid_ips.each do |ip|
        @user.bots.build(@attr.merge(:ip_address => ip)).should_not be_valid
      end
    end
  end
end
