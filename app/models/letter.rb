class Letter
  include Mongoid::Document

  field :title
  field :text
  field :rough_draft, type: Boolean

  belongs_to :author, class_name: "User"
  has_many :followships, dependent: :destroy
  has_one :recipient

  def followers
    self.followships.collect do |f|
      f.user
    end
  end
end
