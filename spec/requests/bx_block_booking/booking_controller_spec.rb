require 'rails_helper'

RSpec.describe BxBlockBooking::BookingsController, type: :controller do
  
  before(:all) do 
    @client = FactoryBot.create(:accounts, role: 'Client')
    @employee = FactoryBot.create(:accounts, role: "Employee")      
    payload = { user_id: @client.id }
    @user_token = JsonWebToken.encode(payload)
    # request.headers['token'] = @user_token
    @service = FactoryBot.create(:service, account_id: @employee.id)
    @booking = FactoryBot.create(:booking, client_account_id: @client.id, service_id:@service.id)
  end

  let(:valid_params_data) do
    {"booking": { "service_id": @service.id,
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

  describe 'POST #create_booking' do
    context 'when creating a booking' do
      it 'creates a booking successfully with valid params' do
        post :create_booking, params: valid_params_data, headers: {token: @user_token}
        expect(response).to have_http_status(:created)
      end
    end
  end
end