# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DevicesController, type: :controller do
  let(:api_key) { create(:api_key) }
  let(:user) { api_key.bearer }

  describe 'POST #assign' do
    subject(:assign) do
      post :assign,
           params: { serial_number: '123456', target_user_id: new_owner_id },
           session: { token: user.api_keys.first.token }
    end
    context 'when the user is authenticated' do
      context 'when user assigns a device to another user' do
        let(:new_owner_id) { create(:user, email: 'other_user@example.com').id }

        it 'returns an unauthorized response' do
          assign
          expect(response.code.to_i).to eq(401)
          expect(JSON.parse(response.body)).to eq({ 'error' => RegistrationError::Unauthorized.new.message })
        end
      end

      context 'when user assigns a device to self' do
        let(:new_owner_id) { user.id }
        it 'returns a success response' do
          assign
          expect(response).to be_successful
        end
      end
    end

    context 'when the user is not authenticated' do
      it 'returns an unauthorized response' do
        post :assign
        expect(response).to be_unauthorized
      end
    end
  end

  describe 'POST #unassign' do
    # TODO: implement the tests for the unassign action
  end
end
