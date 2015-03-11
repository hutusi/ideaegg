# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  username               :string(255)
#  fullname               :string(255)
#  ideas_count            :integer          default(0)
#  comments_count         :integer          default(0)
#  visits_count           :integer          default(0)
#  followees_count        :integer          default(0)
#  followers_count        :integer          default(0)
#  liked_ideas_count      :integer          default(0)
#

FactoryGirl.define do
  factory :user, aliases: [:author] do
    sequence(:username) {|n| "johndoe#{n}" }
    fullname 'John Doe'
    sequence(:email) {|n| "john#{n}@ideaegg.me" }
    password '12345678'
    password_confirmation { password }
    wechat_openid 'xxxxxxxxxx'
  end
end
