require 'rspec/expectations'

RSpec::Matchers.define :successfully_liked do |idea|
  match do |user|
    user.reload
    idea.reload
    expect(user.all_likes.include? idea).to be true
    expect(idea.all_likers.include? user).to be true
  end
end

RSpec::Matchers.define :successfully_unliked do |idea|
  match do |user|
    user.reload
    idea.reload
    expect(user.all_likes.include? idea).to be false
    expect(idea.all_likers.include? user).to be false
  end
end
