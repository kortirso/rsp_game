# frozen_string_literal: true

module Authentication
  extend ActiveSupport::Concern

  included do
    before_action :current_user
  end

  private

  def current_user
    Current.user ||= User.find_by(uuid: extract_uuid.fetch('user_uuid', '')) if token
  end

  def token
    @token ||= session[Rails.configuration.session_name]
  end

  def extract_uuid
    JwtService.decode(token)
  rescue JWT::DecodeError
    nil
  end

  def authenticate
    return if Current.user

    redirect_to users_login_path, alert: t('controllers.authentication.permission')
  end
end
