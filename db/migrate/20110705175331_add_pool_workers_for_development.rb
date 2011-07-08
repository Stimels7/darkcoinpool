class AddPoolWorkersForDevelopment < ActiveRecord::Migration
  def self.up
    if RAILS_ENV == 'development'
      create_table "pool_worker", :force => true do |t|
        t.integer "associatedUserId",               :null => false
        t.string  "username",         :limit => 50
        t.string  "password"
      end
    end
  end

  def self.down
    if RAILS_ENV == 'development'
      drop_table "pool_worker"
    end
  end
end
