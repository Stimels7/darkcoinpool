require 'spec_helper'

describe "users/edit.html.erb" do
  
  before(:each) do
    @user = Factory(:user)
  end
  
  it "should open gravatar edit links in new window" do
    render
    rendered.should have_selector("a", :content => "change", :target => '_blank')
  end
end
