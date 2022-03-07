module Auth
  class AuthorizeUser < ApplicationService
    attr_accessor :request

    def initialize(request)
      @request = request
    end

    def call
      decode = JsonWebToken.decode(token)

      User.find(decode['sub']) if decode
    rescue ActiveRecord::RecordNotFound
      false
    end

    private

    def token
      request.headers.fetch('Authorization', ' ').split.last
    end
  end
end
