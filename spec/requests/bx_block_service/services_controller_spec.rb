require 'rails_helper'

RSpec.describe BxBlockService::ServicesController, type: :controller do
  
  before(:each) do 
    @current_user = FactoryBot.create(:accounts)   
    payload = { user_id: @current_user.id }
    @current_token = JwtHelper.encode(payload)
    @service = FactoryBot.create(:service)
    byebug
  end

  let(:params_data) do
    {
      "service": {
        "attributes": {  
          "account_id": @current_user.id,
          "service_department": "bathroom_renovation",
          "description": "bathroom_renovation service",
          "start_time": "2024-04-15T12:00:00.000Z",
          "end_time": "2024-04-15T14:00:00.000Z",
          "status": "un_assigned",
          "full_name": "dummy",
          "address": "Indore",
          "price": "20000.0",
          "discount_percentage": 15,
          "latitude": nil,
          "longitude": nil
        }
      }
    }
  end

  describe 'POST #create_service' do
    it 'creates a service successfully' do
      post :create_service, params: params_data, headers: { token: @current_token }
      expect(response).to have_http_status(:ok)
    end
  end
end
