User.find_by_username('215dachui').update!(:username => 'dachui')

User.all.each do |user|
  user.username.delete!("_")
  user.ensure_authentication_token
  user.save!
end
