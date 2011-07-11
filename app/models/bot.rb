class Bot < ActiveRecord::Base
  attr_accessible :ip_address

  belongs_to :user

  # validation
  @ip_regex = /^([1-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])(\.([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])){3}$/

  validates :ip_address, 
            :presence => true,
            :format => { :with => @ip_regex }

  validates :user_id, :presence => true

  default_scope :order => 'bots.created_at DESC'
end
