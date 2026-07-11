require "commonmarker"

class MarkdownRenderer
  ALLOWED_TAGS = %w[
    h1 h2 h3 h4 h5 h6
    p br hr
    strong em code pre blockquote
    ul ol li
    a img
    table thead tbody tr th td
    figure figcaption
  ].freeze

  ALLOWED_ATTRIBUTES = %w[href title alt src].freeze

  OPTIONS = {
    parse: { smart: true },
    render: { unsafe: false, hardbreaks: false },
    extension: {
      strikethrough: true,
      tagfilter: true,
      table: true,
      autolink: true
    }
  }.freeze

  def self.render(markdown)
    new(markdown).render
  end

  def initialize(markdown)
    @markdown = markdown.to_s
  end

  def render
    html = Commonmarker.to_html(@markdown, options: OPTIONS)
    sanitized = ActionController::Base.helpers.sanitize(
      html,
      tags: ALLOWED_TAGS,
      attributes: ALLOWED_ATTRIBUTES
    )
    sanitized.html_safe
  end
end
