# frozen_string_literal: true

class Home::HeroComponent < ViewComponent::Base
  def initialize(brand:, headline:, lede:, primary_cta:, secondary_cta: nil)
    @brand = brand
    @headline = headline
    @lede = lede
    @primary_cta = primary_cta
    @secondary_cta = secondary_cta
  end

  private

  attr_reader :brand, :headline, :lede, :primary_cta, :secondary_cta
end
