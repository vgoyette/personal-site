# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Admin", type: :request do
  around do |example|
    original_user = ENV["ADMIN_USERNAME"]
    original_pass = ENV["ADMIN_PASSWORD"]
    ENV["ADMIN_USERNAME"] = "test-admin"
    ENV["ADMIN_PASSWORD"] = "test-pass"
    example.run
  ensure
    ENV["ADMIN_USERNAME"] = original_user
    ENV["ADMIN_PASSWORD"] = original_pass
  end

  def auth_headers(user: "test-admin", pass: "test-pass")
    { "HTTP_AUTHORIZATION" => ActionController::HttpAuthentication::Basic.encode_credentials(user, pass) }
  end

  describe "GET /admin/projects" do
    it "returns 401 without credentials" do
      get admin_projects_path
      expect(response).to have_http_status(:unauthorized)
    end

    it "returns 401 with wrong credentials" do
      get admin_projects_path, headers: auth_headers(user: "wrong", pass: "wrong")
      expect(response).to have_http_status(:unauthorized)
    end

    it "renders the admin index with correct credentials" do
      Project.create!(title: "Sample", body_markdown: "hi", published_at: 1.day.ago)

      get admin_projects_path, headers: auth_headers
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Sample")
    end
  end

  describe "GET /admin/posts" do
    it "returns 401 without credentials" do
      get admin_posts_path
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "credentials not configured" do
    it "rejects even when correct blank credentials are supplied" do
      ENV["ADMIN_USERNAME"] = nil
      ENV["ADMIN_PASSWORD"] = nil

      get admin_projects_path, headers: auth_headers(user: "", pass: "")
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "POST /admin/projects" do
    it "creates a project and redirects" do
      post admin_projects_path,
           params: { project: { title: "New Thing", body_markdown: "**hi**" } },
           headers: auth_headers

      expect(response).to redirect_to(admin_project_path(Project.last))
      expect(Project.last.slug).to eq("new-thing")
    end
  end
end
