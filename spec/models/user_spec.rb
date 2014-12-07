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
#

require 'rails_helper'

describe User do
  describe 'Associations' do
    it { should have_many :ideas }
  end

  describe 'Validations' do
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_uniqueness_of(:username).case_insensitive }

    it { should validate_presence_of :email }
    it { should validate_presence_of :username }
    # it { should validate_presence_of :fullname }

    it { should ensure_length_of(:username).is_at_least(5).is_at_most(30) }
    it { should ensure_length_of(:fullname).is_at_most(120) }
  end

  describe 'Autofill fullname' do
    user = FactoryGirl.create(:user, fullname: '')
    it { expect(user.fullname).to eq user.username }
  end

  describe 'Auto downcase email' do
    user = FactoryGirl.create(:user, email: 'RanDom@example.com')
    it { expect(user.email).to eq user.email.downcase }
  end

  describe 'Auto downcase username' do
    user = FactoryGirl.create(:user, username: 'RanDom')
    it { expect(user.username).to eq user.username.downcase }
  end
end
