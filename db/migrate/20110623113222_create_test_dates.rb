class CreateTestDates < ActiveRecord::Migration
  def self.up
    create_table :test_dates do |t|
      t.text :name

      t.timestamps
    end
  end

  def self.down
    drop_table :test_dates
  end
end
