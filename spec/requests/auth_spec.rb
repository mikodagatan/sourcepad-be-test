require 'rails_helper'
RSpec.describe 'Api::AuthController' do
  let(:user) { create(:user) }

  describe 'POST /api/authenticate' do
    let(:url) { '/api/authenticate' }

    context 'with wrong username' do
      it 'has status :unauthorized' do
        post url, params: {
          user: {
            username: 'user0',
            password: 'password1'
          }
        }

        expect(response.status).to eq(401)
      end
    end

    context 'with wrong password' do
      it 'has status :unauthorized' do
        post url, params: {
          user: {
            username: 'user1',
            password: 'password1'
          }
        }

        expect(response.status).to eq(401)
      end
    end

    context 'with correct credentials' do
      let(:params) do
        {
          user: {
            username: user.username,
            password: 'password123'
          }
        }
      end

      it 'has status :ok' do
        post url, params: params
        expect(response.status).to eq(200)
      end

      it 'returns a JWT' do
        jwt_pattern = /(^[A-Za-z0-9\-_]*\.[A-Za-z0-9\-_]*\.[A-Za-z0-9\-_]*$)/

        post url, params: params

        expect(JSON.parse(response.body)['auth_token']).to match(jwt_pattern)
      end
    end
  end

  describe 'POST /api/authorize' do
    let(:url) { '/api/authorize' }

    context 'with authorization' do
      let(:auth_token) do
        Auth::AuthenticateUser.call({
                                      username: user.username,
                                      password: 'password123'
                                    })
      end

      it 'has status :ok' do
        post url, headers: { 'Authorization' => "Bearer #{auth_token}" }

        expect(response.status).to eq(200)
      end

      it 'returns first_name, last_name, and email' do
        post url, headers: { 'Authorization' => "Bearer #{auth_token}" }

        expect(JSON.parse(response.body)).to eq({
          id: user.id,
          email: user.email,
          first_name: 'firstname',
          last_name: 'lastname'
        }.stringify_keys)
      end
    end
  end
end
