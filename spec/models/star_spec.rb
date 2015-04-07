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

require 'rails_helper'

RSpec.describe Star, :type => :model do
  
end
