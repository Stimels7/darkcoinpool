# http://stackoverflow.com/questions/4997762/ruby-on-rails-fully-functional-tableless-model
# http://railscasts.com/episodes/219-active-model
class Statistic
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  # attr_accessor :name, :email, :content

  # validates_presence_of :name
  # validates_format_of :email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i
  # validates_length_of :content, :maximum => 500

  class << self
    def all
      return []
    end
    
    def hash_per_second
      # 1 minute timedelta  (60sec)                                               
      # hashrate = (shares_per_timedelta * (2 ** 32)) / timedelta                 
      # to Mhash/sec:                                                             
      # hashrate  / 1000000                                                       
      # ~71,5                                                                     
      time = Time.now                                                             
      timedelta = 60 # second                                                     
      # find all shares last 15 minutes                                       
      shares_per_timedelta = Share.where("time >= ?", Time.now-timedelta.second).size
      hash_per_second = (shares_per_timedelta * 2**32) / timedelta.to_f 
      return sprintf("%.2f Mhash/s", hash_per_second / 100000000)
    end
    
    def shares
      Share.count
    end
  end

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end

end

