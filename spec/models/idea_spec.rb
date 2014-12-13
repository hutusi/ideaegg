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
#  cached_votes_up :integer          default(0)
#

require 'rails_helper'

describe Idea do
  describe 'Associations' do
    it { should belong_to :author }
  end

  describe 'Validations' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :content }

    it { should ensure_length_of(:title).is_at_most(140) }
  end
end
