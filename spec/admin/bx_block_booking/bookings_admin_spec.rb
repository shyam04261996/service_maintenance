require 'rails_helper'

RSpec.describe Admin::BookingsController, type: :controller do
  include Devise::Test::ControllerHelpers
  render_views

  before(:each) do
    @admin = User.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
    sign_in @admin
    @client = FactoryBot.create(:accounts, role: 'Client')
    @employee = FactoryBot.create(:accounts, role: "Employee")      
    @service = FactoryBot.create(:service, account_id: @employee.id)
    @booking = FactoryBot.create(:booking, client_account_id: @client.id, service_id: @service.id)
  end
  
  describe "POST#create" do
    let(:valid_params_data) do
      {
        booking: {
          service_id: @service.id,
          full_name: "Vinay",
          status: "Pending",
          mobile_number: "+91-9876500000",
          start_time: "2023-04-17T10:00:00Z",
          end_time: "2023-04-17T09:00:00Z",
          address: "DNS Hospital Indore",
          service_department: "bathroom_renovation",
          description: "vishes Hospital door exchange and window"
        }
      }
    end

    it "creates a new booking" do
      post :new, params: valid_params_data
      expect(response) 
    end
  end
end



