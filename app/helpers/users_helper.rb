module UsersHelper
  def gravatar_for(user, options = { size: 50 })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.fullname, class: "gravatar")
  end

  alias_method :avatar_for, :gravatar_for

  def follow_button(user)
    if current_user.follows?(user)
    link_to fa_icon('male', text: 'Unfollow'),
            {:controller => "users", :action => "unfollow", :follower_id => current_user.id, :id => user.id },
            method: :post,
            class: 'btn btn-default btn-follow-unfollow'
    else
      link_to fa_icon('male', text: 'Follow'),
              {:controller => "users", :action => "follow", :follower_id => current_user.id, :id => user.id },
              method: :post,
              class: 'btn btn-default btn-follow-unfollow'
    end
  end
end
