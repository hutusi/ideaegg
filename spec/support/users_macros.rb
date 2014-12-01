module UsersMacros
  def follow_user(follower, followee)
    post :follow, id: followee, follower_id: follower
  end

  def unfollow_user(follower, followee)
    post :unfollow, id: followee, follower_id: follower
  end
end
