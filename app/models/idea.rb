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

class Idea < ActiveRecord::Base
  # acts_as
  acts_as_votable
  acts_as_commentable
  acts_as_paranoid
  acts_as_taggable

  include ActsAsStarrable
  acts_as_starrable

  # paginates
  paginates_per 8

  # associations
  belongs_to :author, :class_name => "User", :foreign_key => "user_id",
                      :counter_cache => true

  # validations
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 140 }
  validates :content, presence: true
  
  # Scopes
  default_scope { order(created_at: :desc, id: :desc) }
  
  scope :order_created_desc, -> { reorder(created_at: :desc, id: :desc) }
  scope :order_created_asc, -> { reorder(created_at: :asc, id: :asc) }
  scope :order_updated_desc, -> { reorder(updated_at: :desc, id: :desc) }
  scope :order_updated_asc, -> { reorder(updated_at: :asc, id: :asc) }
  
  scope :sorted_by_stars, -> { reorder('ideas.stars_count DESC') }
  scope :sorted_by_comments, -> { reorder('ideas.comments_count DESC') }
  scope :sorted_by_likes, -> { reorder('ideas.cached_votes_up DESC') }
  
  scope :all_public, -> { where(public: true) }
  scope :visible_to, ->(user) { where('level <= ?', user.level) }
  
  # class << self
  #   def visible_to_current_user
  #     Idea.all_public.visible_to(current_user)
  #   end
  # end
  
  def all_likers
    votes_for.up.by_type(User).voters
  end
  
  def tag_names
    tags.order('name ASC').pluck(:name)
  end
end
