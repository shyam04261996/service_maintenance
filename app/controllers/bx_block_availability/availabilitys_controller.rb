module BxBlockAvailability
  class AvailabilitysController < ApplicationController
    before_action :authenticate_user
    before_action :find_account, only: [:create_availability, :update_availability, :delete_availability,:show_availability]

    def create_availability
      @availability = BxBlockAvailability::Availability.new(availability_params.merge(account_id: @current_user.id))
      if @availability.save
        render json: { availability: BxBlockAvailability::AvailabilitySerializer.new(@availability).serializable_hash, message: 'Availability created successfully' }, status: :created
      else
        render json: { errors: @availability.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def update_availability
      @availability = BxBlockAvailability::Availability.find_by(account_id: @current_user.id)
      
      if @availability.nil?
        render json: { errors: 'Availability record not found' }, status: :not_found
      elsif @availability.update(availability_params)
        render json: { availability: BxBlockAvailability::AvailabilitySerializer.new(@availability).serializable_hash, message: 'Availability updated successfully' }, status: :ok
      else
        render json: { errors: @availability.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def delete_availability
      begin
        @availability = BxBlockAvailability::Availability.find(params[:availability_id])
        if @availability.destroy
          render json: { message: 'Deleted successfully' }, status: :ok
        else
          render json: { message: 'Unable to delete' }, status: :unprocessable_entity
        end
      rescue ActiveRecord::RecordNotFound
        render json: { message: 'Availability not found' }, status: :not_found
      end
    end


    def show_availability
      begin
        @availability = BxBlockAvailability::Availability.find(params[:availability_id])
        render json: BxBlockAvailability::AvailabilitySerializer.new(@availability).serializable_hash, status: :ok
      rescue ActiveRecord::RecordNotFound
        render json: { message: 'Availability not found' }, status: :not_found
      end
    end

    private

    def availability_params
      params.require(:availability).permit(:start_time, :end_time, :description, :remark)
    end

    def find_account
      @current_user ||= AccountBlock::Account.find(@token.id)
    end
  end
end
