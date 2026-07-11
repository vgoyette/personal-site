# frozen_string_literal: true

class Site::FooterComponent < ViewComponent::Base
  def initialize(email:)
    @email = email
  end

  private

  attr_reader :email
end
