class Letter
  include Mongoid::Document

  field :title
  field :text
  field :to
  field :rough_draft, type: Boolean

  belongs_to :user
end
