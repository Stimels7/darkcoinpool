require 'test_helper'

class ShareTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end

# == Schema Information
#
# Table name: shares
#
#  id              :integer(4)      not null, primary key
#  time            :datetime        not null
#  rem_host        :string(255)     not null
#  username        :string(120)     not null
#  our_result      :string(0)       not null
#  upstream_result :string(0)
#  reason          :string(50)
#  solution        :string(257)     not null
#

