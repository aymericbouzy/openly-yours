class User
  devise

  field :email
  field :first_name
  field :last_name

  has_many :letters #??
end
