module Auth
  class JsonWebToken
    def self.encode(payload)
      expiration = 5.minutes.from_now.to_i
      JWT.encode(
        payload.merge(exp: expiration),
        ENV['DEVICE_JWT_SECRET_KEY']
      )
    end

    def self.decode(token)
      JWT.decode(
        token,
        ENV['DEVICE_JWT_SECRET_KEY']
      ).first
    end
  end
end
