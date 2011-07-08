class ChangeColumnOnShare < ActiveRecord::Migration
  def self.up
    if RAILS_ENV == 'development'
      remove_column :shares, :our_result
      remove_column :shares, :upstream_result
      # change_table :shares do |t|
      #   t.column :our_result, "ENUM('Y', 'N')"
      #   t.column :upstream_result, "ENUM('Y', 'N')"
      # end
      add_column :shares,  "our_result",      :string, :limit => 1,   :null => false             
      add_column :shares,  "upstream_result", :string, :limit => 1
    end
  end

  def self.down
    if RAILS_ENV == 'development'
      remove_column :shares, :our_result
      remove_column :shares, :upstream_result
      add_column :shares,  "our_result",      :string, :limit => 0,   :null => false             
      add_column :shares,  "upstream_result", :string, :limit => 0
    end
  end
end
