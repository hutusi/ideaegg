# == Schema Information
#
# Table name: stars
#
#  id             :integer          not null, primary key
#  starrable_id   :integer
#  starrable_type :string(255)
#  user_id        :integer
#  created_at     :datetime
#  updated_at     :datetime
#

class Star < ActiveRecord::Base
  belongs_to :user
  belongs_to :starrable, polymorphic: true

  validates :user, presence: true
  validates :starrable_type, presence: true
  validates :starrable, presence: true
end
