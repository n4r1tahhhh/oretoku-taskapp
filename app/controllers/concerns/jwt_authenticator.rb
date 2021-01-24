# frozen_string_literal: true

module JwtAuthenticator
  require 'jwt'

  SECRET_KEY = Rails.application.secrets.secret_key_base

  def jwt_authenticate
    render json: { "message": 'please log in' }, status: :forbidden if request.headers['Authorization'].blank?
    encoded_token = request.headers['Authorization'].split('Bearer ').last
    # 有効期限切れの場合も例外が発生する
    payload = decode(encoded_token)
    @current_user = User.find_by(email: payload[:email])
    render json: { "message": 'session expired ! please log in again' }, status: :forbidden if @current_user.blank?
    @current_user
  end

  def encode(email)
    # とりあえず3日で切れるようにする。最終的にはもっと伸ばす。
    expires_in = 3.day.from_now.to_i
    payload = { email: email, exp: expires_in }
    JWT.encode(payload, SECRET_KEY_BASE, 'HS256')
  end

  def decode(encoded_token)
    # 第3引数をtrueにしないとdecodeが行われない
    decoded_token = JWT.decode(encoded_token, SECRET_KEY_BASE, true, algorithm: 'HS256')
    # firstはpayloadを表す
    decoded_token.first
  end
end
