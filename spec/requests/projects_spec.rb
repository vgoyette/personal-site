# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Projects", type: :request do
  let!(:published) do
    Project.create!(
      title: "Second Brain",
      body_markdown: "A **portable** knowledge base for engineering decisions.",
      summary: "How I keep the why.",
      published_at: 1.day.ago
    )
  end

  let!(:draft) do
    Project.create!(
      title: "Secret Sauce",
      body_markdown: "Not ready yet.",
      published_at: nil
    )
  end

  let!(:future) do
    Project.create!(
      title: "Ships Next Week",
      body_markdown: "Scheduled release.",
      published_at: 1.week.from_now
    )
  end

  describe "GET /projects" do
    it "lists only published projects with published_at in the past" do
      get projects_path

      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Second Brain")
      expect(response.body).not_to include("Secret Sauce")
      expect(response.body).not_to include("Ships Next Week")
    end
  end

  describe "GET /projects/:slug" do
    it "renders the rendered markdown body" do
      get project_path(published)

      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Second Brain")
      expect(response.body).to include("<strong>portable</strong>")
    end

    it "returns 404 for draft projects" do
      get project_path(draft)
      expect(response).to have_http_status(:not_found)
    end

    it "returns 404 for scheduled/future projects" do
      get project_path(future)
      expect(response).to have_http_status(:not_found)
    end
  end
end
