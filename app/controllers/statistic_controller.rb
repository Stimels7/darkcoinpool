class StatisticController < ApplicationController

  def hash_per_second
    render :text => Statistic.hash_per_second
  end

end
