class BotsController < ApplicationController
  before_filter :authenticate, :only => [:create, :destroy]
  before_filter :authorized_user, :only => :destroy

  def create
    @bot = current_user.bots.build(params[:bot])
    if @bot.save
      redirect_to(root_path)
      flash[:success] = "Bot created!"
    else
      @feed_items = []
      render('pages/home')
    end
  end

  def destroy
    @bot.destroy
    redirect_back_or root_path
  end

  private
    
    def authorized_user
      @bot = current_user.bots.find_by_id(params[:id])
      redirect_to root_path if @bot.nil?
    end
end
