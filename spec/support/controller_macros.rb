# frozen_string_literal: true

module ControllerMacros
  def sign_in_user
    before do
      @current_user = create :user
      @request.session[Rails.configuration.session_name] = JwtService.encode(user_uuid: @current_user.uuid)
    end
  end
end
