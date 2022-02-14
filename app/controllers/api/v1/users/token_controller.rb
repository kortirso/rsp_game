# frozen_string_literal: true

module Api
  module V1
    module Users
      class TokenController < Api::V1::BaseController
        skip_before_action :authenticate

        def create
          user = auto_auth
          render json: { token: JwtService.encode(user_uuid: user.uuid) }, status: :ok
        rescue AuthFailure => e
          render json: { errors: e.message }, status: :unauthorized
        end

        private

        def auto_auth
          raise AuthFailure, 'No auth strategy found' unless params.key?(:username)

          database_auth
        end

        def database_auth
          username, password = params.require(%i[username password])
          user = User.find_by(username: username)
          if user.nil? || !user.authenticate(password)
            raise AuthFailure, 'Authorization error'
          end

          user
        end
      end
    end
  end
end
