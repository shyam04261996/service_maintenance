require 'rails_helper'

RSpec.describe BxBlockService::ServicesController, type: :controller do
  
  before(:each) do 
    @current_user = FactoryBot.create(:accounts)   
    payload = { user_id: @current_user.id }
    @user_token = JsonWebToken.encode(payload)
    @service = FactoryBot.create(:service)
    request.headers['token'] = @user_token
    @booking = FactoryBot.create(:booking)
  end

  let(:valid_params_data) do
    {"service": {"account_id": @current_user.id, "service_department": "bathroom_renovation","description": "bathroom_renovation service","start_time": "2024-04-15T12:00:00.000Z",
        "end_time": "2024-04-15T14:00:00.000Z","status": "un_assigned","full_name": "dummy","address": "Indore","price": "20000.0","discount_percentage": 15
      }}
  end

  let(:invalid_params_data) do
    {"service": { "description": "bathroom renovation service"}}
  end

  describe 'POST #create_service' do
    context 'when creating a service' do
      
      it 'creates a service successfully with valid params' do
        post :create_service, params: valid_params_data
        expect(response).to have_http_status(:created)
      end

      it 'returns unprocessable entity with invalid params' do
        post :create_service, params: invalid_params_data
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'update service information' do
      it 'update service information' do
        put :update_service, params: { id: @service.id, service: valid_params_data }
        expect(response).to have_http_status(200)
      end

      # it 'invalid data service information' do
      #   put :update_service, params: { id: @service.id, service: invalid_params_data }
      #   expect(response).to have_http_status(:unprocessable_entity)
      # end

      it 'update service information failed' do
        @service = FactoryBot.create(:service)
        put :update_service, params: { id: 234 , service: invalid_params_data }
        expect(response).to have_http_status(404)
      end
    end

    context 'delete service' do
      it 'delete service information' do
        delete :delete_service, params: { id: @service.id }
        expect(response).to have_http_status(200)
      end

      it 'delete service record not found' do
        delete :delete_service, params: { id: @service.id }
        expect(response).to have_http_status(200)
      end
    end

    context 'show service service' do
      it 'show service service information' do
        delete :show_service, params: { id: @service.id }
        expect(response).to have_http_status(200)
      end

      it 'delete service record not found' do
        delete :delete_service, params: { id: @service.id }
        expect(response).to have_http_status(200)
      end
    end

    context 'service request status' do
      it 'service request status' do
        @service = FactoryBot.create(:service)
        @booking = FactoryBot.create(:booking, service_id: @service.id)
        put :service_request, params: { service_id: @service.id, booking_id: @booking.id, status: "Confirmed"}
        expect(response).to have_http_status(200)
      end

      it 'service request not status update' do
        @service = FactoryBot.create(:service)
        @booking = FactoryBot.create(:booking, service_id: @service.id)
        put :service_request, params: { service_id: @service.id, booking_id: 123, status: "Confirmed"}
        expect(response).to have_http_status(404)
      end

      it 'listing service' do
        get :listing_service, params: { search: "xyz", account_id:@current_user.id}
        expect(response).to have_http_status(200)
      end
    end
  end
end
