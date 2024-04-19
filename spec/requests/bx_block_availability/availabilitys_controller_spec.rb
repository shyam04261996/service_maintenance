require 'rails_helper'

RSpec.describe BxBlockAvailability::AvailabilitysController, type: :controller do
  before(:each) do 
    @employee = FactoryBot.create(:accounts, role: "Employee")      
    payload = { user_id: @employee.id }
    @user_token = JsonWebToken.encode(payload)
    request.headers['token'] = "#{@user_token}"
    @availability = FactoryBot.create(:availability, account_id: @employee.id)    
    @employee2 = FactoryBot.create(:accounts, role: "Employee")
    @availability2 = FactoryBot.create(:availability)
	  payload2 = { user_id: @employee2.id }
    @user_token2 = JsonWebToken.encode(payload2)
  end

  let(:valid_params_data) do
    { availability: { start_time: "2024-04-18T10:00:00Z",end_time: "2024-04-18T18:00:00Z", description: "Emergency Leave",remark: "Not Available this date"
      }}
  end

  let(:invalid_params_data) do
	{ availability: { description: "Emergency Leave",remark: "Not Available this date"}}
  end

   describe 'POST #create_availability' do
	    context 'when creating an availability' do
	      it 'creates an availability successfully with valid params' do
	        post :create_availability, params: valid_params_data
	        expect(response).to have_http_status(:created)
	      end

	      it 'availability create failed' do
	        post :create_availability, params: invalid_params_data
	        expect(response).to have_http_status(422)
	      end
	    end
	end

	describe 'PUT #update_availability' do
	  context 'when updating an availability' do
		    it 'updates an availability successfully with valid params' do
		      put :update_availability, params: { id: @availability.id, availability: { start_time: "10:00 AM", end_time: "18:00 PM", account_id: @employee.id } }
		      expect(response).to have_http_status(200)
		    end

		    it 'updates an record not found' do
		      request.headers['token'] = "#{@user_token2}"
		      put :update_availability, params: { id: @availability2.id, availability: { start_time: "10:00 AM", account_id: @employee2.id } }
		      expect(response).to have_http_status(404)
		    end

		    it 'updates an unprocessable entity' do
		      put :update_availability, params: { id: @availability.id, availability: { start_time: "", end_time: "", account_id: @employee.id } }
		      expect(response).to have_http_status(422)
		    end
	   end
	end

	describe 'PUT #delete_availability' do
	  context 'when delete an availability' do
	  	it 'delete successfully' do
		  	delete :delete_availability, params: {availability_id: @availability.id}
	        expect(response).to have_http_status(200)
	    end

	    it 'delete not found' do
		  	delete :delete_availability, params: {availability_id: 123}
	        expect(response).to have_http_status(404)
	    end
	  end
	end

	describe 'GET #show_availability' do
	  context 'show availability successfully' do
	  	it 'availability dettails' do
		  get :show_availability, params: {availability_id: @availability.id}
		  expect(response).to have_http_status(200)
	  	end
	  	it 'availability record not found' do
		  get :show_availability, params: {availability_id: 456}
		  expect(response).to have_http_status(404)
	  	end
	  end
	end
end
