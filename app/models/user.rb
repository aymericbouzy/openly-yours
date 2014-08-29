class User

  field :email
  field :first_name
  field :last_name

  field :followed_letters, type: Array, default: []

  has_many :letters #??
end
