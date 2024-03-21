# app/controllers/bx_block_service/services_controller.rb
module BxBlockService
  class ServicesController < ApplicationController
    # skip_before_action :verify_authenticity_token
    before_action :authenticate_user
    before_action :set_service, only: [:show, :update, :destroy]

    # def create_service
    #   @service = Service.new(service_params)
    #   if @service.save
    #     render json: { service: BxBlockService::ServiceSerializer.new(@service).serializable_hash, message: 'Service created successfully' }, status: :created
    #   else
    #     render json: @service.errors, status: :unprocessable_entity
    #   end
    # end

    def create_service
     @service = Service.new(service_params.merge(account_id: current_user.id))
      if @service.save
        render json: { service: BxBlockService::ServiceSerializer.new(@service).serializable_hash, message: 'Service created successfully' }, status: :created
     else
        render json: @service.errors, status: :unprocessable_entity
     end
    end


    def update_service
      @service = BxBlockService::Service.find(params[:id])
      if @service.update(service_params)
        render json: { service: BxBlockService::ServiceSerializer.new(@service).serializable_hash, message: 'Service updated successfully' }, status: :ok
      else
        render json: @service.errors, status: :unprocessable_entity
      end
    end

    def show_service
      @service = BxBlockService::Service.find(params[:id])
      if @service.present?
        render json: { service: BxBlockService::ServiceSerializer.new(@service).serializable_hash}, status: :ok
      else
        render json: @service.errors, status: :unprocessable_entity
      end
    end

    def delete_service
      @service = BxBlockService::Service.find(params[:id])
      if @service.present?
        @service.destroy
        render json: { message: 'Service deleted successfully' }, status: :ok
      else
        render json: { error: 'Service not found' }, status: :not_found
      end
    end

    private

    # def user
    #   user = Account.find(current_user.id)
    # end

    def service_params
      params.require(:service).permit(:service_department, :description, :start_time, :end_time, :status, :full_name, :address, :account_id)
    end
  end
end
