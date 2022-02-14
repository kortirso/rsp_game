# frozen_string_literal: true

module Api
  module V1
    class BaseController < ApplicationController
      class AuthFailure < StandardError; end

      protect_from_forgery with: :null_session

      skip_before_action :current_user

      private

      def authenticate
        auto_auth
      rescue AuthFailure => e
        Current.user = nil
        render json: { errors: e.message }, status: :unauthorized
      end

      def auto_auth
        return user_auth_with_header if request.headers['Authorization']
        return user_auth_with_params if params.key?(:access_token)

        raise AuthFailure, 'There is no authorization token'
      end

      def user_auth_with_header
        user_auth(request.headers['Authorization'].split[-1])
      end

      def user_auth_with_params
        user_auth(params[:access_token])
      end

      def user_auth(access_token)
        check_token(access_token)
        find_user
        Current.user = @user
      end

      def check_token(access_token)
        @user_uuid = JwtService.decode(access_token).fetch('user_uuid', '')
      rescue StandardError
        raise AuthFailure, 'Signature verification error'
      end

      def find_user
        @user = User.find_by(uuid: @user_uuid)
        raise AuthFailure, 'Authorization error' if @user.nil?
      end
    end
  end
end
