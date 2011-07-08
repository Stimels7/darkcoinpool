require 'test_helper'

class PoolWorkerTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
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

