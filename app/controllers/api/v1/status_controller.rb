# frozen_string_literal: true

module Api
  module V1
    class StatusController < Api::V1::BaseController
      skip_before_action :authenticate

      def show
        render json: { message: 'Server is on' }, status: :ok
      end
    end
  end
end
