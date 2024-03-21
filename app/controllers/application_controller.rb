class ApplicationController < ActionController::Base
  include JwtHelper
  protect_from_forgery with: :null_session, if: -> { request.format.json? }
  def authenticate_user
    token = request.headers['token']&.split(' ')&.last
    if token
      begin
        payload = JwtHelper.decode(token)
        if payload
          @current_user = AccountBlock::Account.find(payload['user_id'])
        else
          render json: { error: 'Invalid token' }, status: :unauthorized
        end
      rescue JWT::DecodeError => e
        # Log the error for debugging purposes
        Rails.logger.error("JWT Decode Error: #{e.message}")
        render json: { error: 'Token decoding error' }, status: :unauthorized
      end
    else
      render json: { error: 'Token missing' }, status: :unauthorized
    end
  end
  def current_user
    @current_user
  end
end