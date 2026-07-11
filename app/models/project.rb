class Project < ApplicationRecord
  include Publishable
  include Sluggable

  validates :title, presence: true
  validates :body_markdown, presence: true
  validates :url, format: { with: URI::DEFAULT_PARSER.make_regexp(%w[http https]),
                            allow_blank: true }
end
