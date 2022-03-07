require 'rails_helper'

RSpec.describe Auth::JsonWebToken do
  let(:user) { create(:user) }
  let(:jwt) { described_class.encode(sub: user.id) }

  describe '#encode' do
    it 'creates a token' do
      jwt_pattern = /(^[A-Za-z0-9\-_]*\.[A-Za-z0-9\-_]*\.[A-Za-z0-9\-_]*$)/

      expect(jwt).to match(jwt_pattern)
    end
  end

  describe '#decode' do
    it 'checks if the token is valid' do
      expect(described_class.decode(jwt)&.dig('sub')).to eq(user.id)
    end
  end
end
