class Recipient
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name
  field :category

  has_many :letters
  has_one :user

  def self.categories
    ["person", "organization", "group"]
  end

  validates :category, inclusion: { in: categories, message: "%{value} is not a valid categorie" }
  validates :name, presence: true, uniqueness: true
end
