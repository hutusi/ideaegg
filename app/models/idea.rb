# == Schema Information
#
# Table name: ideas
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  content    :text
#  public     :boolean          default(TRUE)
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Idea < ActiveRecord::Base
  # acts_as
  acts_as_votable
  acts_as_commentable
  acts_as_paranoid

  # paginates
  paginates_per 8

  # associations
  belongs_to :author, :class_name => "User", :foreign_key => "user_id",
                      :counter_cache => true

  # validations
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 140 }
  validates :content, presence: true

  def all_likers
    votes_for.up.by_type(User).voters
  end
end
