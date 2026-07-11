# Idempotent seeds. Safe to re-run in any environment.
# Content is intentionally minimal — enough to prove the surfaces render,
# not enough to be treated as canonical.

Project.find_or_initialize_by(slug: "personal-site-brain").tap do |p|
  p.title = "personal-site-brain"
  p.summary = "A markdown vault that captures the why behind this site."
  p.url = "https://github.com/vgoyette/personal-site-brain"
  p.body_markdown = <<~MD
    A private Obsidian vault sitting next to this Rails app. Every architectural
    decision (Rails stack, Fly deploy, content surfaces) lives there as an ADR or
    plan note. The app is the artifact; the brain remembers why.

    - ADRs for locked decisions
    - Plans for in-flight work
    - Runbooks and questions for the loose ends
  MD
  p.published_at ||= 3.days.ago
  p.save!
end

Project.find_or_initialize_by(slug: "personal-site").tap do |p|
  p.title = "personal-site"
  p.summary = "The Rails 8 app you are looking at."
  p.url = "https://github.com/vgoyette/personal-site"
  p.body_markdown = <<~MD
    Rails 8 + Hotwire + Tailwind + Slim + ViewComponent. Running on Fly.io in
    Toronto (yyz) with a single Postgres. Draft-in-progress — see the vault
    for what's coming next.
  MD
  p.published_at ||= 2.days.ago
  p.save!
end

# One draft to prove filtering works.
Project.find_or_initialize_by(slug: "in-flight-experiment").tap do |p|
  p.title = "In-flight experiment"
  p.summary = "Something I'm still shaping."
  p.body_markdown = "Not ready to show yet."
  p.published_at = nil
  p.save!
end

Post.find_or_initialize_by(slug: "why-a-second-brain").tap do |p|
  p.title = "Why a second brain"
  p.summary = "Notes on keeping decisions durable when the codebase forgets them."
  p.body_markdown = <<~MD
    Code answers *what* and *how*. It rarely answers *why*.

    I keep a small Obsidian vault beside this repo. Each meaningful decision
    lands as an ADR — a page or two, dated, linked to the plan that produced it.
    When I come back six months later, I don't have to reverse-engineer intent
    from a diff.

    The rule I try to follow: **if we discussed a trade-off, the loser deserves
    a paragraph**. Otherwise, the next me (or the next agent) will burn the same
    tokens to rediscover it.
  MD
  p.published_at ||= 2.days.ago
  p.save!
end

Post.find_or_initialize_by(slug: "thin-on-purpose").tap do |p|
  p.title = "Thin on purpose"
  p.summary = "Why v1 of this site skips search, tags, RSS, and comments."
  p.body_markdown = <<~MD
    Every feature is a decision to maintain something. The v1 scope for this
    site is deliberately narrow:

    - Two surfaces: `/projects` and `/writing`
    - Postgres-backed models with Markdown bodies
    - HTTP Basic admin, no user model
    - One nav, one hero, one voice

    If I don't miss a thing after a month, it doesn't ship in v2 either.
  MD
  p.published_at ||= 1.day.ago
  p.save!
end

Post.find_or_initialize_by(slug: "draft-notebook").tap do |p|
  p.title = "Draft notebook"
  p.summary = "Working through an idea in public — not yet."
  p.body_markdown = "Still thinking."
  p.published_at = nil
  p.save!
end

puts "Seeded: #{Project.count} projects, #{Post.count} posts (#{Project.published.count} + #{Post.published.count} published)."
