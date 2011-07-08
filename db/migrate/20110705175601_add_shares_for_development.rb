class AddSharesForDevelopment < ActiveRecord::Migration
  def self.up
    if RAILS_ENV == 'development'
      create_table "shares", :force => true do |t|
        t.datetime "time",                           :null => false
        t.string   "rem_host",                       :null => false
        t.string   "username",        :limit => 120, :null => false
        t.string   "our_result",      :limit => 0,   :null => false
        t.string   "upstream_result", :limit => 0
        t.string   "reason",          :limit => 50
        t.string   "solution",        :limit => 257, :null => false
      end
    end
  end

  def self.down
    if RAILS_ENV == 'development'
      drop_table "shares"
    end
  end
end
