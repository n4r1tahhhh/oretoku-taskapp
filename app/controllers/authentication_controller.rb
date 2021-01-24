# frozen_string_literal: true

class AuthenticationController < ApplicationController
  include JwtAuthenticator

  def create
    @current_user = User.find_by(email: params[:email])
    if @current_user&.authenticate(params[:password])
      jwt_token = encode(@current_user.email)
      response.headers['X-Authentication-Token'] = jwt_token
      render json: @current_user
    else
      render json: { "message": 'wrong email or password' }, status: :unauthorized
    end
  end
end
