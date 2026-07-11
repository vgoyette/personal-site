# frozen_string_literal: true

class Site::NavComponent < ViewComponent::Base
  def initialize(brand: "Vincent", current: nil)
    @brand = brand
    @current = current.to_s
  end

  def links
    [
      { label: "Home",     href: helpers.root_path,     key: "home" },
      { label: "Projects", href: helpers.projects_path, key: "projects" },
      { label: "Writing",  href: helpers.posts_path,    key: "writing" }
    ]
  end

  def link_classes(key)
    base = "font-mono text-xs uppercase tracking-[0.22em] transition duration-200 hover:text-accent focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-accent"
    active = key == @current ? "text-accent" : "text-ink-muted"
    "#{base} #{active}"
  end

  attr_reader :brand
end
