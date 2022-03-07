module Auth
  class AuthenticateUser < ApplicationService
    attr_accessor :username, :password

    def initialize(params)
      @username = params[:username]
      @password = params[:password]
      @user = user
    end

    def call
      return false unless @user.valid_password?(password)

      update_jwt
    rescue StandardError
      false
    end

    private

    def user
      User.find_by(username:) || User.find_by(email: username)
    end

    def update_jwt
      JsonWebToken.encode(sub: @user.id)
    end
  end
end
