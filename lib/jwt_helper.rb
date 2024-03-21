module JwtHelper
  SECRET_KEY = Rails.application.secrets.secret_key_base
  BLACKLIST = Set.new
  def self.encode(payload, expiration = 24.hours.from_now)
    payload[:exp] = expiration.to_i
    JWT.encode(payload, SECRET_KEY, 'HS256')
  end
  def self.encode_token(payload, expiration)
    payload[:exp] = expiration.to_i
    JWT.encode(payload, SECRET_KEY, 'HS256')
  end
  def self.decode(token)
    decoded = JWT.decode(token, SECRET_KEY, true, algorithm: 'HS256')
    decoded[0] if decoded
  rescue JWT::DecodeError
    nil
  end
  def self.invalidate_token(token)
    p token
    BLACKLIST.add(token)
  end
end