# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Custom domain", type: :request do
  around do |example|
    original = ENV["SITE_HOST"]
    ENV["SITE_HOST"] = "example.com"
    example.run
  ensure
    ENV["SITE_HOST"] = original
  end

  describe "www -> apex redirect" do
    it "301s www.SITE_HOST to https://SITE_HOST preserving path" do
      get "/writing", headers: { "HOST" => "www.example.com" }

      expect(response).to have_http_status(:moved_permanently)
      expect(response.headers["Location"]).to eq("https://example.com/writing")
    end

    it "preserves the query string" do
      get "/writing?tag=foo", headers: { "HOST" => "www.example.com" }

      expect(response).to have_http_status(:moved_permanently)
      expect(response.headers["Location"]).to eq("https://example.com/writing?tag=foo")
    end

    it "redirects the apex root as `/`" do
      get "/", headers: { "HOST" => "www.example.com" }

      expect(response).to have_http_status(:moved_permanently)
      expect(response.headers["Location"]).to eq("https://example.com/")
    end
  end

  describe "apex host" do
    it "serves the app normally" do
      get "/", headers: { "HOST" => "example.com" }
      expect(response).to have_http_status(:ok)
    end
  end

  describe "when SITE_HOST is unset" do
    before { ENV["SITE_HOST"] = nil }

    it "does not redirect www hosts (constraint no-ops)" do
      get "/", headers: { "HOST" => "www.example.com" }

      # Route falls through to the app; the request-spec host authorization
      # allowlist in test env is permissive.
      expect(response.status).not_to eq(301)
    end
  end
end
