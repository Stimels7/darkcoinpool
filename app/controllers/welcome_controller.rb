class WelcomeController < ApplicationController

  def index
    shares = Share.new

    respond_to do |format|
      format.html
      format.js
    end 
  end


  def current_difficulty
    render :text => "OK"
  end

end
