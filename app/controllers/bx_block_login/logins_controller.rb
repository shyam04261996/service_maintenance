module BxBlockLogin
 class LoginsController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [:login]

    def login
      user = AccountBlock::Account.find_by(email: params[:email])
      if user  && user.authenticate(login_params[:password])
        payload = { user_id: user.id }
         token = JwtHelper.encode(payload)
         render json: { user: AccountBlock::AccountSerializer.new(user), token: token }, status: :created
      else
        render json: { error: 'Invalid email or password' }, status: :unauthorized
      end
    end

    private

    def login_params
      params.permit(:email, :password)
    end
 end
end

