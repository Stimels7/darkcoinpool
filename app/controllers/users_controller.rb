class UsersController < ApplicationController
  
  def show
    @title = "User profile"
    @user = User.find(params[:id])
  end

  def new
    @title = "Sign up"
  end

end
