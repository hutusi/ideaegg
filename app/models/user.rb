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
#  comments_count         :integer          default(0)
#  visits_count           :integer          default(0)
#  followees_count        :integer          default(0)
#  followers_count        :integer          default(0)
#  liked_ideas_count      :integer          default(0)
#  authentication_token   :string(255)
#  wechat_openid          :string(255)
#  phone_number           :string(255)
#  level                  :integer          default(0)
#  money                  :integer          default(0)
#  avatar                 :string(255)
#  sign_up_type           :string(255)      default("web")
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
  alias_attribute :private_token, :authentication_token

  # associations
  has_many :ideas, dependent: :destroy
  has_many :stars

  # validations
  validates :username,
    :presence => true,
    :uniqueness => {
      :case_sensitive => false
    },
    :format => { with: /\A[a-zA-Z]+[a-zA-Z0-9]+\z/,
    message: "begin with letters and only allows letters or digits"  },
    :length => { minimum: 2, maximum: 30 }
  validates :fullname, :length => { maximum: 120 }
  validates :fullname, :presence => true, :on => :update

  #
  # Callbacks
  #
  before_save :autofill_fullname, :downcase_username, :ensure_authentication_token

  #
  # Class methods
  #
  class << self
    def by_login(login)
      where('lower(username) = :value OR lower(email) = :value',
            value: login.to_s.downcase).first
    end

    def find_for_database_authentication(warden_conditions)
      conditions = warden_conditions.dup
      if login = conditions.delete(:login)
        where(conditions).where(["lower(username) = :value OR lower(email) = :value",
                                 { :value => login.downcase }]).first
      else
        where(conditions).first
      end
    end
  end

  #
  # Instance methods
  #
  def login=(login)
    @login = login
  end

  def login
    @login || self.username || self.email
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

  def ensure_authentication_token
    self.authentication_token ||= generate_authentication_token
  end

  def starred?(starrable)
    Star.exists?({ :starrable_id => starrable.id, :starrable_type => starrable.class.name, :user_id => self.id })
  end

  private
    def autofill_fullname
      self.fullname = self.username if self.fullname.blank?
    end

    def downcase_username
      self.username && self.username.downcase!
    end

    def generate_authentication_token
      loop do
        token = Devise.friendly_token
        break token unless User.where(authentication_token: token).first
      end
    end
end
