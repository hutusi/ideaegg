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
  belongs_to :author, :class_name => "User", :foreign_key => "user_id",
                      :counter_cache => true

  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 140 }
  validates :content, presence: true

  paginates_per 8

  acts_as_votable

  def all_likers
    get_likes
  end

  acts_as_commentable

end
