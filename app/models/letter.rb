class Letter
  include Mongoid::Document

  field :title
  field :text
  field :recipient
  field :recipient_user_id
  field :rough_draft, type: Boolean

  belongs_to :user
end
