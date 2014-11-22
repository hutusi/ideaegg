module UsersHelper
  def follow_button(user)
    if current_user.follows?(user)
    link_to fa_icon('male', text: 'Unfollow'),
            {:controller => "users", :action => "unfollow", :follower_id => current_user.id, :id => user.id },
            method: :post,
            class: 'btn btn-default'
    else
      link_to fa_icon('male', text: 'Follow'),
              {:controller => "users", :action => "follow", :follower_id => current_user.id, :id => user.id },
              method: :post,
              class: 'btn btn-default'
    end
  end
end
