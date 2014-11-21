(2..10).each  do |i|
    User.seed(:id, [{
      id: i,
      username: Faker::Internet.user_name,
      fullname: Faker::Name.name,
      email: Faker::Internet.email
    }])
end
