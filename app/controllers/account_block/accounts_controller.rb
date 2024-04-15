module AccountBlock
 class AccountsController < ApplicationController
    skip_before_action :verify_authenticity_token

   def create_account
      @account = AccountBlock::Account.new(account_params)
      if @account.save
        render json: { account: AccountBlock::AccountSerializer.new(@account).serializable_hash, message: 'Account created successfully' }, status: :ok
      else
        render json: { errors: @account.errors.full_messages }, status: :unprocessable_entity
      end
    end


    def show_account
      @account = AccountBlock::Account.find(params[:id])
      render json: AccountBlock::AccountSerializer.new(@account).serializable_hash, status: :ok
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Account not found' }, status: :not_found
    end

    def destroy_account
      @account = AccountBlock::Account.find(params[:id])
      @account.destroy
      render json: { message: 'Account deleted successfully' }, status: :ok
      rescue ActiveRecord::RecordNotFound
      render json: { error: 'Account not found' }, status: :not_found
    end

    def update_account
      @account = AccountBlock::Account.find(params[:id])
      if @account.update(account_params)
        render json: AccountBlock::AccountSerializer.new(@account).serializable_hash, status: :ok
      else
        render json: { errors: @account.errors.full_messages }, status: :unprocessable_entity
      end
    end

    private

    def account_params
      params.require(:account).permit(:first_name, :last_name, :full_phone_number, :email, :password, :role)
    end
 end
end
