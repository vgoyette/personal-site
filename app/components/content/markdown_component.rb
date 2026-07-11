module Content
  class MarkdownComponent < ViewComponent::Base
    extend Dry::Initializer

    option :body, Dry::Types["strict.string"]
    option :class_name, Dry::Types["strict.string"], default: -> {
      "prose prose-invert max-w-none font-sans text-ink"
    }

    def rendered_html
      MarkdownRenderer.render(body)
    end
  end
end
