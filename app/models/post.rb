class Post < ApplicationRecord
  include Publishable
  include Sluggable

  validates :title, presence: true
  validates :body_markdown, presence: true
end
