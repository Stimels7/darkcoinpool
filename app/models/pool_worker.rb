class PoolWorker < ActiveRecord::Base
  set_table_name "pool_worker"
end

# == Schema Information
#
# Table name: pool_worker
#
#  id               :integer(4)      not null, primary key
#  associatedUserId :integer(4)      not null
#  username         :string(50)
#  password         :string(255)
#

