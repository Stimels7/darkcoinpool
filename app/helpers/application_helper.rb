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

  def new_hashrate_pool
    # 1 minute timedelta  (60sec)
    # hashrate = (shares_per_timedelta * (2 ** 32)) / timedelta)
    # to Mhash/sec:
    # hashrate  / 1000000
    # ~71,5
    time = Time.now                                                         
    timedelta = 60 # second
    # find all shares last 15 minutes                                       
    shares_per_timedelta = Share.where("time > ?", Time.now-timedelta.second).size
    hash_per_second = shares_per_timedelta / timedelta
    ghash_per_second = (((hash_per_second / 1000) /1000) /1000)
  end
  
  # Giga Hash per second
  def old_hashrate_pool
    return 0.0379
  end

  # alias for switching between old/new_hashrate_pool
   alias :hashrate_pool :new_hashrate_pool
  #alias :hashrate_pool :old_hashrate_pool

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

  # average hours until next block
  # first parameter = difficulty
  # second param is the hashrate in Ghashes per second (e.g. 37.7)
  def average(difficulty=1.0, hashrate=1)
    difficulty = current_difficulty
    hashrate = hashrate_pool
    # Todo: find the current value for foo (seconds?)
    average_foo = eval("#{difficulty} * 2**32 / #{hashrate} / 60 / 60.0")
    # convert foo to hours
    return hours = average_foo / 1000000000
  end
    
  def average_hour(hours=average)
    return sprintf("%.2f hour", hours)
  end
  def average_day(hours=average)
    hours /= 24
    return sprintf("%.2f day", hours)
  end
  def average_year(hours=average)
    hours = (hours / 24) / 365
    return sprintf("%.2f year", hours)
  end
end
