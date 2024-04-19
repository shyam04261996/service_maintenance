require 'rails_helper'

RSpec.describe BxBlockBooking::BookingsController, type: :controller do
  before(:all) do 
    @client = FactoryBot.create(:accounts, role: 'Client')
    @employee = FactoryBot.create(:accounts, role: "Employee")      
    payload = { user_id: @client.id }
    @user_token = JsonWebToken.encode(payload)
    payload2 = { user_id: @employee.id }
    @user_token2 = JsonWebToken.encode(payload2)
    @service = FactoryBot.create(:service, account_id: @employee.id)
    @booking = FactoryBot.create(:booking, client_account_id: @client.id, service_id: @service.id)
  end

  let(:valid_params_data) do
    {
      "booking": {
        "service_id": @service.id,
        "full_name": "Vinay",
        "mobile_number": "+91-9876500000",
        "start_time": "2023-04-17T10:00:00Z",
        "end_time": "2023-04-17T09:00:00Z",
        "address": "DNS Hospital Indore",
        "service_department": "bathroom_renovation",
        "description": "vishes Hospital door exchange and window"
      }
    }
  end

  let(:invalid_params_data) do
    {
      "booking": {
        # "service_id": @service.id,
        "full_name": "Vinay",
        "mobile_number": "+91-9876500000"
      }
    }
  end

  describe 'POST #create_booking' do
    context 'when creating a booking' do
      it 'creates a booking successfully with valid params' do
        request.headers['token'] = "token #{@user_token}"
        post :create_booking, params: valid_params_data
        expect(response).to have_http_status(:created)
      end

      it 'client user not found' do
        request.headers['token'] = "token #{@user_token2}"
        post :create_booking, params: valid_params_data
        expect(response).to have_http_status(:unauthorized)
      end
      it 'booking unprocessable entity' do
        request.headers['token'] = "token #{@user_token}"
        post :create_booking, params: invalid_params_data
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT #update_booking' do
    before(:all) do 
      @client = FactoryBot.create(:accounts, role: 'Client')
      @service = FactoryBot.create(:service, account_id: @employee.id)
      @booking = FactoryBot.create(:booking, client_account_id: @client.id, service_id: @service.id)
      payload = { user_id: @client.id }
      @user_token = JsonWebToken.encode(payload)
    end
    context 'when updating a booking' do
      it 'updates a booking successfully with valid params' do
        request.headers['token'] = "token #{@user_token}"
        valid_params = {"booking": {"full_name": "Mohit Sharma"}}
        put :update_booking, params: valid_params
        expect(response).to have_http_status(200)
      end

      it 'when booking not found' do
        request.headers['token'] = "token #{@user_token2}"
        valid_params = {"booking": {"full_name": "Rohit Sharma"}}
        put :update_booking, params: valid_params
        expect(response).to have_http_status(:not_found)
      end

      it 'when booking unprocessable entity' do
        request.headers['token'] = "token #{@user_token}"
        valid_params = {"booking": {"full_name": " ", mobile_number: ""}}
        put :update_booking, params: valid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
    
    context 'when delete booking' do
      it 'delete booking dettails successfully' do
        request.headers['token'] = "token #{@user_token}"
        delete :delete_booking,params: {booking_id: @booking.id}
        expect(response).to have_http_status(200)
      end
       it 'delete booking dettails failed' do
        request.headers['token'] = "token #{@user_token}"
        delete :delete_booking,params: {booking_id: ""}
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when show booking infomation' do
      it 'show booking dettails successfully' do
        request.headers['token'] = "token #{@user_token}"
        get :show_booking,params:{booking_id: @booking.id}
        expect(response).to have_http_status(200)
      end

      it 'show booking dettails successfully' do
        request.headers['token'] = "token #{@user_token}"
        get :show_booking,params:{booking_id: ""}
        expect(response).to have_http_status(:not_found)
      end
    end
    context 'index_bookings' do
      it 'Index booking dettails successfully' do
        @client = FactoryBot.create(:accounts, role: 'Client')
        request.headers['token'] = "token #{@user_token}"
        get :index_bookings,params:{client_account_id: @client.id}
        expect(response).to have_http_status(200)
      end

      it 'Index booking dettails successfully' do
        @client = FactoryBot.create(:accounts, role: 'Client')
        request.headers['token'] = "token #{@user_token2}"
        get :index_bookings,params:{client_account_id: @client.id}
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
