# frozen_string_literal: true

module JwtService
  module_function

  HMAC_SECRET = 'secret'

  def encode(payload)
    JWT.encode(payload, HMAC_SECRET)
  end

  def decode(token)
    JWT.decode(token, HMAC_SECRET).first
  end
end
