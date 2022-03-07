module Api
  class AuthController < ApplicationController
    def authenticate
      auth_token = Auth::AuthenticateUser.call(auth_params)

      return render json: 'unauthorized', status: :unauthorized unless auth_token

      render json: { auth_token: }, status: :ok
    end

    def authorize
      user = Auth::AuthorizeUser.call(request)

      return render json: 'unauthorized', status: :unauthorized unless user

      render json: UserBlueprint.render(user), status: :ok
    end

    private

    def auth_params
      params.require(:user).permit(:username, :password)
    end
  end
end
