# frozen_string_literal: true

class Ui::ButtonComponent < ViewComponent::Base
  def initialize(href:, label:, variant: :primary, **html_options)
    @href = href
    @label = label
    @variant = variant.to_sym
    @html_options = html_options
  end

  private

  attr_reader :href, :label, :variant, :html_options

  def classes
    [
      "inline-flex cursor-pointer items-center justify-center rounded-full px-6 py-3 text-sm font-medium tracking-wide transition duration-200 ease-out focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-accent focus-visible:ring-offset-2 focus-visible:ring-offset-canvas",
      variant_classes
    ].join(" ")
  end

  def variant_classes
    case variant
    when :secondary
      "border border-line bg-transparent text-ink hover:border-accent hover:text-accent"
    else
      "bg-accent text-white shadow-[0_10px_30px_-12px_var(--accent)] hover:brightness-110 dark:text-zinc-950"
    end
  end
end
