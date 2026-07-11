# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Posts", type: :request do
  let!(:published) do
    Post.create!(
      title: "On Documenting Why",
      body_markdown: "The **why** is the artifact worth keeping.",
      summary: "A short note on decision hygiene.",
      published_at: 2.days.ago
    )
  end

  let!(:draft) do
    Post.create!(
      title: "Half-Baked Idea",
      body_markdown: "TBD.",
      published_at: nil
    )
  end

  describe "GET /writing" do
    it "lists only published posts" do
      get posts_path

      expect(response).to have_http_status(:ok)
      expect(response.body).to include("On Documenting Why")
      expect(response.body).not_to include("Half-Baked Idea")
    end
  end

  describe "GET /writing/:slug" do
    it "renders the rendered markdown body" do
      get post_path(published)

      expect(response).to have_http_status(:ok)
      expect(response.body).to include("On Documenting Why")
      expect(response.body).to include("<strong>why</strong>")
    end

    it "returns 404 for draft posts" do
      get post_path(draft)
      expect(response).to have_http_status(:not_found)
    end
  end
end
