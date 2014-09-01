class Recipient
  include Mongoid::Document
  field :name
  field :categorie

  has_many :letters
  has_one :user

  validate :categorie, inclusion: { in categories, message: "%{value} is not a valid categorie" }

  def self.categories
    [:person, :organization, :group]
  end
end
