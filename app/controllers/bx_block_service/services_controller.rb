# app/controllers/bx_block_service/services_controller.rb
module BxBlockService
  class ServicesController < ApplicationController
    before_action :authenticate_user
    before_action :set_service, only: [:show, :update, :destroy]

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

    # def service_request
    #   @service = BxBlockService::Service.find(params[:service_id])
    #   @booking = BxBlockBooking::Booking.find_by(id: params[:booking_id], service_id: @service.id)
    #   if @service.present? && @booking.present?
    #     if @booking.update(status: 'Confirmed')
    #       render json: { message: 'Booking Confirmed successfully' }, status: :ok
    #     else
    #       render json: { error: 'Failed to update booking status', errors: @booking.errors }, status: :unprocessable_entity
    #     end
    #   else
    #     render json: { error: 'Service not found or booking not associated with the service' }, status: :not_found
    #   end
    # end

    def service_request
      @service = BxBlockService::Service.find(params[:service_id])
      @booking = BxBlockBooking::Booking.find_by(id: params[:booking_id], service_id: @service.id)
      if @service.present? && @booking.present?
        new_status = params[:status]
        if valid_status?(new_status)
          if @booking.update(status: new_status)
            render json: { message: "Booking status updated to '#{new_status}' successfully" }, status: :ok
          else
            render json: { error: 'Failed to update booking status', errors: @booking.errors }, status: :unprocessable_entity
          end
        else
          render json: { error: 'Invalid status provided' }, status: :unprocessable_entity
        end
      else
        render json: { error: 'Service not found or booking not associated with the service' }, status: :not_found
      end
    end

    private

    def valid_status?(status)
      ['Pending ','Confirmed' ,'Cancelled' ,'In_progress'].include?(status)
    end

    def service_params
      params.require(:service).permit(:service_department, :description, :start_time, :end_time, :status, :full_name, :address, :account_id, :price, :discount_percentage)
    end
  end
end
