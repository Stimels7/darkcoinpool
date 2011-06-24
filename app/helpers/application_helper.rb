require 'json'

module ApplicationHelper
  

  def total_shares
    Share.count
  end
  
  def shares_per(unit = "hour")
    time = Time.now
    code = "Time.now-1.#{unit}"
    shares = Share.where("time > ?", eval(code)).size
    return shares
  end

  # Todo: Think thats not working yeat!
  def hashes_per_second
    time = Time.now
    # find all shares last 15 minutes
    recent_shares = Share.where("time > ?", Time.now-15.minutes).size
    hashes_per_second = (recent_shares / (60*15) * 2**32) /1024 / 1024
    return hashes_per_second.to_i
  end

  # get current difficulty fom local bitcoind instance
  def current_difficulty_local
    getinfo = JSON.parse(`bitcoind getinfo`)
    return getinfo["difficulty"].to_f
  end

  # get current difficulty from web
  def current_difficulty_online
    difficulty = `curl http://blockexplorer.com/q/getdifficulty`
    return difficulty.to_f
  end

  # hier legen wir fest ob wir den difficlt vom web oder local fetchen wollen
  # local ist glaub ich besser da ja eh der bitcoind läuft
  alias :current_difficulty :current_difficulty_online
  #alias :current_difficulty :current_difficulty_local

end
