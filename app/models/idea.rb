class Idea < ActiveRecord::Base
  belongs_to :author, :class_name => "User", :foreign_key => "user_id"

  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 140 }
  validates :content, presence: true
end
