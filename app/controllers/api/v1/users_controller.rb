# frozen_string_literal: true

module Api
  module V1
    class UsersController < Api::V1::BaseController
      skip_before_action :authenticate

      def create
        service_call = ::Users::CreateService.call(params: user_params)
        if service_call.success?
          render json: {
            message: 'User is created',
            token:   JwtService.encode(user_session_uuid: service_call.result.sessions.create.uuid)
          }, status: :created
        else
          render json: { errors: service_call.errors }, status: :unprocessable_entity
        end
      end

      private

      def user_params
        params.require(:user).permit(:username, :password, :password_confirmation)
      end
    end
  end
end
