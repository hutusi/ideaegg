# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  commentable_id   :integer
#  commentable_type :string(255)
#  title            :string(255)
#  body             :text
#  subject          :string(255)
#  user_id          :integer          not null
#  parent_id        :integer
#  lft              :integer
#  rgt              :integer
#  created_at       :datetime
#  updated_at       :datetime
#

FactoryGirl.define do
  factory :comment do
    user
    body "Hello"
  end

  factory :idea_comment, class: "Comment" do
    user
    association :commentable, :factory => :idea
    body "Hello"
  end
end
