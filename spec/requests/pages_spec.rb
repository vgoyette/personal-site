# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Home page", type: :request do
  it "renders the thin homepage" do
    get root_path

    expect(response).to have_http_status(:ok)
    expect(response.body).to include("Vincent")
    expect(response.body).to include("Building systems that remember why.")
    expect(response.body).to include("Toggle color theme")
    expect(response.body).to include("vgoyette22@gmail.com")
  end
end
