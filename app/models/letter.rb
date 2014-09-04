class Letter
  include Mongoid::Document
  include Mongoid::Timestamps
  field :title
  field :text
  field :rough_draft, type: Boolean
  field :published_at, type: Date

  belongs_to :author, class_name: "User"
  has_many :followships, dependent: :destroy
  belongs_to :recipient

  def followers
    self.followships.collect do |f|
      f.user
    end
  end

  def published?
    !self.rough_draft
  end

  def valid_for_publishing?
    !(self.title.blank? || self.text.blank? || self.author.nil? || self.recipient.nil?)
  end
end
