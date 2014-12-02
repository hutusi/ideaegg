require 'rspec/expectations'

RSpec::Matchers.define :successfully_followed do |followee|
  match do |follower|
    follower.reload
    followee.reload
    expect(followee.all_followers.include? follower).to be true
    expect(follower.all_followees.include? followee).to be true
  end
end

RSpec::Matchers.define :successfully_unfollowed do |followee|
  match do |follower|
    follower.reload
    followee.reload
    expect(followee.all_followers.include? follower).to be false
    expect(follower.all_followees.include? followee).to be false
  end
end
