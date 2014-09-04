require 'devise'

class User
  include Mongoid::Document
  include Mongoid::Timestamps
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ## Database authenticatable
  field :email,              type: String, default: ""
  field :encrypted_password, type: String, default: ""

  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time

  ## Trackable
  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String

  ## Confirmable
  # field :confirmation_token,   type: String
  # field :confirmed_at,         type: Time
  # field :confirmation_sent_at, type: Time
  # field :unconfirmed_email,    type: String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, type: Integer, default: 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    type: String # Only if unlock strategy is :email or :both
  # field :locked_at,       type: Time

  field :first_name
  field :last_name

  has_many :followships, dependent: :destroy
  has_many :letters

  def identity
    if self.first_name.blank? && self.last_name.blank?
      self.email
    elsif self.first_name.blank? || self.last_name.blank?
      self.first_name.capitalize + self.last_name.capitalize
    else
      self.first_name.capitalize + " " + self.last_name.capitalize
    end
  end

  def is_admin?
    false
  end

  def rough_drafts
    self.letters.where(rough_draft: true)
  end

  def published_letters
    self.letters.where(rough_draft: false)
  end

  def followed_letters
    self.followships.collect do |f|
      f.letter
    end
  end

  def follow(letter)
    self != letter.author && self.followships.create(letter_id: letter.id.to_s)
  end

  def followed?(letter)
    self.followed_letters.find(letter.id).present?
  end
end
