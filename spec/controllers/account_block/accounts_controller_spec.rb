require 'rails_helper'

RSpec.describe AccountBlock::AccountsController, type: :controller do
  describe 'POST #create_account' do
    it 'creates an account successfully' do
      post :create_account, params: {
        account: {
          first_name: "dummy",
          last_name: "dummy",
          full_phone_number: "+91-9876543210",
          phone_number: "9876890000",
          email: "dummy@info.com",
          password: "password",
          role: "Client"
        }
      }
      expect(response).to have_http_status(:ok)
    end
    
    it 'account not created without required parameters' do
      post :create_account, params: {
        account: {
          first_name: "dummy",
          last_name: "dummy",
          full_phone_number: "+91-9876543210",
          phone_number: "9876890000",
          email: "dummy@info.com",
          password: "password"
        }
      }
      expect(response).to have_http_status(422)
    end
  end

  describe 'GET #show_account' do
    it 'shows account details' do
      user = FactoryBot.create(:accounts)      
      get :show_account, params: { id: user.id }
      expect(response).to have_http_status(:ok)
    end

    it 'not show accounts details' do
      user = FactoryBot.create(:accounts)      
      get :show_account, params: { id: 123 }
      expect(response).to have_http_status(404)
    end

    it 'delete employee dettails' do
      user = FactoryBot.create(:accounts)      
      get :destroy_account, params: { id: user.id }
      expect(response).to have_http_status(200)
    end

    it 'delete  not employee dettails' do
      user = FactoryBot.create(:accounts)      
      get :destroy_account, params: { id: 456 }
      expect(response).to have_http_status(404)
    end

    it 'update account information' do
      user = FactoryBot.create(:accounts)      
      put :update_account, params: {id: user.id, account: { first_name: "dummy", password: "password"} }
      expect(response).to have_http_status(200)
    end

    it 'failed update account information' do
      user = FactoryBot.create(:accounts)      
      put :update_account, params: {id:user.id, account: { first_name: "dummy"} }
      expect(response).to have_http_status(422)
    end
  end
end
