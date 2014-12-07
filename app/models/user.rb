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

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # acts_as
  acts_as_follower
  acts_as_followable
  acts_as_voter

  # paginates
  paginates_per 8

  # accessors
  attr_accessor :login

  # associations
  has_many :ideas, dependent: :destroy

  # validations
  validates :username,
    :presence => true,
    :uniqueness => {
      :case_sensitive => false
    },
    :format => { with: /\A[a-zA-Z]+[a-zA-Z0-9]+\z/,
    message: "begin with letters and only allows letters or digits"  },
    :length => { minimum: 5, maximum: 30 }
  validates :fullname, :length => { maximum: 120 }
  validates :fullname, :presence => true, :on => :update

  # callbacks
  before_save :autofill_fullname, :downcase_username

  def login=(login)
    @login = login
  end

  def login
    @login || self.username || self.email
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

  def all_followers
    followers
  end

  def all_followees
    all_following
  end

  def all_likes
    get_up_voted(Idea)
  end

  private
    def autofill_fullname
      self.fullname = self.username if self.fullname.blank?
    end

    def downcase_username
      self.username && self.username.downcase!
    end
end
