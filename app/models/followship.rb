class Followship
  include Mongoid::Document

  belongs_to :user
  belongs_to :letter

  validates :letter_id, :uniqueness => {:scope => :user_id}
end
