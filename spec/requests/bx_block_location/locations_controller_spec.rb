require 'rails_helper'

RSpec.describe BxBlockLocation::LocationsController, type: :controller do
  before(:all) do 
    @client = FactoryBot.create(:accounts, role: 'Client')
    @employee = FactoryBot.create(:accounts, role: "Employee")      
    payload = { user_id: @client.id }
    @user_token = JsonWebToken.encode(payload)
    @location = FactoryBot.create(:location)
  end

  let(:valid_params_data) do
    {"location": {"address": "Ujjain","city": "indore","state": "madhya pardesh","country": "India","description": "location dummy comments"          
      }}
  end

  let(:invalid_params_data) do
    {"location": {"city": "indore","state": "madhya pardesh","country": "India","description": "location dummy comments"          
      }}
  end


  describe "create location" do
    context 'when creating a location' do
      it 'creates a location successfully with valid params' do
        request.headers['token'] = "token #{@user_token}"
        post :create_location, params: valid_params_data
        expect(response).to have_http_status(:created)
      end

      it 'creates a location successfully with valid params' do
        request.headers['token'] = "token #{@user_token}"
        post :create_location, params: invalid_params_data
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
  describe "index_locations" do
    context 'when a location dettails' do
      it 'location dettails show successfully' do
        request.headers['token'] = "token #{@user_token}"
        get :index_locations, params: valid_params_data
        expect(response).to have_http_status(200)
      end

      # it 'failed location information' do
      #   request.headers['token'] = "token #{@user_token}"
      #   get :index_locations, params: valid_params_data
      #   expect(response).to have_http_status(200)
      # end
    end

    context 'show_location' do
      it 'location dettails' do
        request.headers['token'] = "token #{@user_token}"
        get :show_location, params: {id: @location.id}
        expect(response).to have_http_status(200)
      end

      it 'location dettails failed' do
        request.headers['token'] = "token #{@user_token}"
        get :show_location, params: {id: 123}
        expect(response).to have_http_status(404)
      end
    end

    context 'delete_location' do
      it 'delete location information successfully' do
        request.headers['token'] = "token #{@user_token}"
        delete :delete_location, params: {id: @location.id}
        expect(response).to have_http_status(200)
      end

      it 'delete location information failed' do
        request.headers['token'] = "token #{@user_token}"
        delete :delete_location, params: {id: 505}
        expect(response).to have_http_status(422)
      end
    end

    context 'update_location' do
       it 'updates location information successfully' do
          request.headers['token'] = "token #{@user_token}"
          put :update_location, params: {id: @location.id, location: {address: "indore", city: "indore"}}
          expect(response).to have_http_status(200)
       end
       it 'unprocessable_entity' do
          request.headers['token'] = "token #{@user_token}"
          put :update_location, params: {id: @location.id, location: {address: " ", city: "indore"}}
          expect(response).to have_http_status(422)
       end
       it 'not_found' do
          request.headers['token'] = "token #{@user_token}"
          put :update_location, params: {id: 101, location: {address: "indore", city: "indore"}}
          expect(response).to have_http_status(404)
       end
    end
  end
end
