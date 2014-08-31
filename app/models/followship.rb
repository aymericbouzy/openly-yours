class Followship
  include Mongoid::Document

  belongs_to :user
  belongs_to :letter
end
