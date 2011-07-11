class CreateBots < ActiveRecord::Migration
  def self.up
    create_table :bots do |t|
      t.integer :user_id
      t.string :ip_address
      t.text :desc

      t.timestamps
    end
    add_index :bots, :user_id
    add_index :bots, :created_at
  end

  def self.down
    drop_table :bots
  end
end
