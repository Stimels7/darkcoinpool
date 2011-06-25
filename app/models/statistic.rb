# http://stackoverflow.com/questions/4997762/ruby-on-rails-fully-functional-tableless-model
# http://railscasts.com/episodes/219-active-model
class Statistic
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  # attr_accessor :name, :email, :content

  # validates_presence_of :name
  # validates_format_of :email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i
  # validates_length_of :content, :maximum => 500

  class << self
    def all
      return []
    end
    
    def shares
      Share.count
    end
  end

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end

end

