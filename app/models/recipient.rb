class Recipient
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name
  field :categorie

  has_many :letters
  has_one :user

  def self.categories
    [:person, :organization, :group]
  end

  validate :categorie, inclusion: { in: categories, message: "%{value} is not a valid categorie" }
end
