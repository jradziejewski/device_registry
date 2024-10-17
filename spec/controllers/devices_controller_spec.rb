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
    subject(:unassign) do
      post :unassign,
           params: { serial_number: '123456', target_user_id: assigned_user_id },
           session: { token: user.api_keys.first.token }
    end

    context 'when the user is authenticated' do
      context 'when user tries to unassign a device that belongs to another user' do
        let(:assigned_user) { create(:user, email: 'other_user@example.com') }
        let(:assigned_user_id) { assigned_user.id }

        before do
          AssignDeviceToUser.new(
            requesting_user: assigned_user,
            serial_number: '123456',
            new_device_owner_id: assigned_user_id
          ).call
        end

        it 'returns an unauthorized response' do
          unassign
          expect(response.code.to_i).to eq(401)
          expect(JSON.parse(response.body)).to eq({ 'error' => ReturnError::Unauthorized.new.message })
        end
      end

      context 'when user tries to unassign a device that belongs to self' do
        let(:assigned_user_id) { user.id }

        before do
          AssignDeviceToUser.new(
            requesting_user: user,
            serial_number: '123456',
            new_device_owner_id: assigned_user_id
          ).call
        end

        it 'returns a success response' do
          unassign
          expect(response).to be_successful
        end
      end
    end
  end
end
