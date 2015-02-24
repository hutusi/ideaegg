class Star < ActiveRecord::Base
  belongs_to :user
  belongs_to :starrable, polymorphic: true

  validates :user, presence: true
  validates :starrable_type, presence: true
  validates :starrable, presence: true
end
