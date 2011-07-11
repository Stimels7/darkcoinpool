require 'faker'

class Fakeout
  
  # fake ip_V4 address
  # stolen by Faker
  def self.ip_v4_address
    ary = (2..255).to_a
    [ary.rand,
    ary.rand,
    ary.rand,
    ary.rand].join('.')
  end

  # fake ip_v6 address
  # stolen by Faker
  def self.ip_v6_address
    @@ip_v6_space ||= (0..65535).to_a
    container = (1..8).map{ |_| @@ip_v6_space.rand }
    container.map{ |n| n.to_s(16) }.join(':')
  end

  # fake time 
  # time_rand
  #  => 1977-11-02 04:42:02 0100 
  # time_rand Time.local(2010, 1, 1)
  # => 2010-07-17 00:22:42 0200 
  #
  def self.time_rand from = 0.0, to = Time.now
    Time.at(from + rand * (to.to_f - from.to_f))
  end

end


namespace :db do

  desc "Fill development database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    # Create users
    admin = User.create(:name => "zzeroo systems",
                :email => "pulp@zzeroo.com",
                :password => "asrael",
                :password_confirmation => "asrael")
    admin.toggle!(:admin)

    99.times do |n|
      name = Faker::Name.name
      email = "example-#{n+1}@zzeroo.org"
      password = "password"
      User.create!(:name => name,
                  :email => email,
                  :password => password,
                  :password_confirmation => password)
    end

    User.all(:limit => 6).each do |user|
      50.times do
        user.bots.create!(:ip_address => Fakeout.ip_v4_address)
      end
    end
    
    # Create pool-worker
    99.times do |n|
      associatedUserId = 1
      name = Faker::Name.name
      password = "password"
      PoolWorker.create!(:associatedUserId => associatedUserId,
                         :username => name,
                         :password => password)
    end

    # Create shares
    99.times do |n|
      month = rand(12).to_s.rjust(2,"0")
      day = rand(28).to_s.rjust(2,"0")
      timedate = Fakeout.time_rand Time.local(2011, 1, 1)
      remhost = Fakeout.ip_v6_address
      username = "smueller"
      solution = "000000019658c13480fbf44fdc726b3a375542e97c17c0300f3a8bd100000a010000000032931910a794b7b5696b276a5658dff0c8f14c10aa7047cf3b51827636d6bf614dffb45a1a132185e079a0be000000800000000000000000000000000000000000000000000000000000000000000000000000000000000080020000"
      Share.create!(:time => timedate,
                    :rem_host => remhost,
                    :username => username,
                    :our_result => "Y",
                    :upstream_result => nil,
                    :reason => nil,
                    :solution => solution)
    end
  end
end
