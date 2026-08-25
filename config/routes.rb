Rails.application.routes.draw do
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # `www.SITE_HOST` -> `https://SITE_HOST/...` 301 with path + query preserved.
  # ENV is read at request time so the route stays inert when SITE_HOST is
  # unset (i.e. all `*.fly.dev` traffic today) — no reboot needed to toggle.
  match "(*path)",
    constraints: ->(req) {
      host = ENV["SITE_HOST"]
      host.present? && req.host.casecmp?("www.#{host}")
    },
    to: redirect(status: 301) { |params, req|
      site_host = ENV["SITE_HOST"]
      target = "https://#{site_host}/#{params[:path]}"
      target += "?#{req.query_string}" if req.query_string.present?
      target
    },
    via: :all

  resources :projects, only: %i[index show], param: :slug
  resources :posts, only: %i[index show], path: "writing", param: :slug

  namespace :admin do
    root to: redirect("/admin/projects")
    resources :projects
    resources :posts
  end

  root "pages#home"
end
