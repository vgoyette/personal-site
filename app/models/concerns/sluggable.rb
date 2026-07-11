module Sluggable
  extend ActiveSupport::Concern

  included do
    validates :slug, presence: true, uniqueness: true,
              format: { with: /\A[a-z0-9]+(?:-[a-z0-9]+)*\z/,
                        message: "must be lowercase kebab-case" }

    before_validation :generate_slug
  end

  def to_param
    slug
  end

  private

  def generate_slug
    return if slug.present?
    return if title.blank?

    self.slug = title.parameterize
  end
end
