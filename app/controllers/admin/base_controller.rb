module Admin
  class BaseController < ApplicationController
    layout "admin"

    before_action :authenticate_admin

    private

    def authenticate_admin
      authenticate_or_request_with_http_basic("Admin") do |username, password|
        expected_user = ENV["ADMIN_USERNAME"].to_s
        expected_pass = ENV["ADMIN_PASSWORD"].to_s

        # Reject when secrets aren't configured — we do not want a blank-credential
        # backdoor in prod or CI.
        next false if expected_user.empty? || expected_pass.empty?

        ActiveSupport::SecurityUtils.secure_compare(username, expected_user) &
          ActiveSupport::SecurityUtils.secure_compare(password, expected_pass)
      end
    end
  end
end
