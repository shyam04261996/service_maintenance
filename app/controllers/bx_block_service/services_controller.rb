# app/controllers/bx_block_service/services_controller.rb
module BxBlockService
  class ServicesController < ApplicationController
    before_action :authenticate_user
    before_action :find_account, only: [:update_service, :show_service, :delete_service, :service_request, :listing_service]

    def create_service
     @service = Service.new(service_params.merge(account_id: current_user.id))
        if @service.save
          render json: { service: BxBlockService::ServiceSerializer.new(@service).serializable_hash, message: 'Service created successfully' }, status: :created
       else
          render json: @service.errors, status: :unprocessable_entity
       end
    end

    def update_service
      begin
        @service = BxBlockService::Service.find(params[:id])

        if @service.update(service_params)
          render json: { service: BxBlockService::ServiceSerializer.new(@service).serializable_hash, message: 'Service updated successfully' }, status: :ok
        else
          render json: { error: @service.errors.full_messages }, status: :unprocessable_entity
        end
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Service not found' }, status: :not_found
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
      @service = BxBlockService::Service.find_by(id: params[:id])
      if @service.present?
        @service.destroy
        render json: { message: 'Service deleted successfully' }, status: :ok
      else
        render json: { error: 'Service not found' }, status: :not_found
      end
    end

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
        render json: { error: 'Please Check Valid Data Service and Booking' }, status: :not_found
      end
    end

    def listing_service
      @services = BxBlockService::Service.where(account_id: @current_user.id)
      if params[:search].present?
        search_query = "%#{params[:search].downcase}%"
        @services = @services.where("LOWER(service_department) LIKE ? OR LOWER(status) LIKE ?", search_query, search_query)
      end
      render json: { services: @services.map { |service| BxBlockService::ServiceSerializer.new(service).serializable_hash } }, status: :ok
    end

    private

    def valid_status?(status)
      ['Pending ','Confirmed' ,'Cancelled' ,'In_progress', 'Completed'].include?(status)
    end

    def service_params
      params.require(:service).permit(:service_department, :description, :start_time, :end_time, :status, :full_name, :address, :account_id, :price, :discount_percentage)
    end

    def find_account
      @current_user ||= AccountBlock::Account.find(@token.id)
    end
  end
end
