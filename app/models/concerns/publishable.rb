module Publishable
  extend ActiveSupport::Concern

  included do
    scope :published, -> {
      where.not(published_at: nil)
        .where(arel_table[:published_at].lteq(Time.current))
        .order(published_at: :desc)
    }
  end

  def published?
    published_at.present? && published_at <= Time.current
  end

  def draft?
    !published?
  end
end
