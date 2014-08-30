class Letter
  include Mongoid::Document

  field :title
  field :text

  belongs_to :user
end
