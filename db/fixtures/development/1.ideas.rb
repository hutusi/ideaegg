(0..100).each  do |i|
    Idea.seed(:id, [{
      id: i,
      title: Faker::Lorem.sentence,
      content: Faker::Lorem.paragraphs.join('\n\n'),
      user_id: rand(2..10)
    }])
end
