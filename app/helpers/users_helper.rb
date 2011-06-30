module UsersHelper

  
  def gravatar_for(user, options = { :default => 'http://github.com/images/gravatars/gravatar-80.png', :size => 50})
    gravatar_image_tag(user.email.downcase, :alt => user.name,
                                            :class => 'gravatar',
                                            :gravatar => options)
  end

end
