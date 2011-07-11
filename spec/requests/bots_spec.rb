require 'spec_helper'

describe "Bots" do
  
  before(:each) do
    user = Factory(:user)
    visit signin_path
    fill_in :email, :with => user.email
    fill_in :password, :with => user.password
    click_button
  end

  describe "creation" do
    
    describe "failure" do
      
      it "should not make a new bot" do
        lambda do
          visit root_path
          fill_in :bot_ip_address, :with => ""
          click_button
          response.should render_template('pages/home')
          response.should have_selector('div#error_explanation')
        end.should_not change(Bot, :count)
      end
    end

    describe "success" do

      it "should make a new bot" do
        ip_address = "1.1.1.1"
        lambda do
          visit root_path
          fill_in :bot_ip_address, :with => ip_address
          click_button
          response.should have_selector("p.ip_address", :content => ip_address)
        end.should change(Bot, :count).by(1)
      end
    end
  end
end
