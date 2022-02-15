# frozen_string_literal: true

module Authentication
  extend ActiveSupport::Concern

  included do
    before_action :current_user
  end

  private

  def current_user
    Current.user ||= Users::Session.find_by(uuid: user_session_uuid)&.user if token
  end

  def token
    @token ||= session[Rails.configuration.session_name]
  end

  def user_session_uuid
    JwtService.decode(token).fetch('user_session_uuid', '')
  rescue JWT::DecodeError
    nil
  end

  def authenticate
    return if Current.user

    redirect_to users_login_path, alert: t('controllers.authentication.permission')
  end
end
