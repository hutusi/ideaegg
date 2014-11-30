module UsersMacros
  def follow_user(follower, followee)
    post :follow, id: followee, follower_id: follower
  end
end
