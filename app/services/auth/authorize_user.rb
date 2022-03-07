module Auth
  class AuthorizeUser < ApplicationService
    attr_accessor :request

    def initialize(request)
      @request = request
    end

    def call
      decode = JsonWebToken.decode(token)

      User.find(decode['sub'])
    rescue ActiveRecord::NotFound
      false
    end

    private

    def token
      puts request.headers.fetch('Authorization', ' ')
      request.headers.fetch('Authorization', ' ').split.last
    end
  end
end
