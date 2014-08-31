class Recipient
  include Mongoid::Document
  field :name
  field :categorie

  has_many :letters

  valitdate :categorie, inclusion: { in categories,
    message: "%{value} is not a valid categorie" }

  def self.categories
    [:person, :organization, :group]
  end
end
