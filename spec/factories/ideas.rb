# == Schema Information
#
# Table name: ideas
#
#  id              :integer          not null, primary key
#  title           :string(255)
#  content         :text
#  public          :boolean          default(TRUE)
#  user_id         :integer
#  created_at      :datetime
#  updated_at      :datetime
#  deleted_at      :datetime
#  comments_count  :integer          default(0)
#  visits_count    :integer          default(0)
#  cached_votes_up :integer          default(0)
#  stars_count     :integer          default(0)
#  level           :integer          default(0)
#

FactoryGirl.define do
  factory :idea do
    author
    title "Hello"
    content "World"
  end
end
