module BxBlockLocation
  class LocationsController < ApplicationController
    before_action :authenticate_user
    before_action :find_account, only: [:create_location, :update_location, :index_locations, :show_location, :delete_location]

    def create_location
      @location = BxBlockLocation::Location.new(location_params)
      set_account_id(@location)
      if @location.save
        render json: { location: BxBlockLocation::LocationSerializer.new(@location).serializable_hash, message: 'Location created successfully' }, status: :created
      else
        render json: @location.errors, status: :unprocessable_entity
      end
    end

    def update_location
      @location = BxBlockLocation::Location.find_by(id: params[:id])
      if @location.nil?
        render json: { error: 'Location not found or you do not have permission to update this location' }, status: :not_found
      elsif @location.update(location_params)
        render json: { location: BxBlockLocation::LocationSerializer.new(@location).serializable_hash, message: 'Location updated successfully' }, status: :ok
      else
        render json: { errors: @location.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def delete_location
      @location = BxBlockLocation::Location.find_by(id: params[:id])
      if @location.present?
        @location.destroy
        render json: { message: 'Location deleted successfully' }, status: :ok
      else
        render json: { error: 'Location not found or you do not have permission to delete it' }, status: :unprocessable_entity
      end
    end

    def show_location
      @location = BxBlockLocation::Location.find_by(id: params[:id])
      if @location.present?
        render json: { location: BxBlockLocation::LocationSerializer.new(@location).serializable_hash }, status: :ok
      else
        render json: { error: 'Location not found or you do not have permission to view it' }, status: :not_found
      end
    end

    def index_locations
      @locations = BxBlockLocation::Location.all
      render json: { locations: @locations.map { |loc| BxBlockLocation::LocationSerializer.new(loc).serializable_hash } }, status: :ok
    end

    private

    def find_account
      @current_user ||= AccountBlock::Account.find(@token.id)
    end

    def set_account_id(location)
      if @current_user.role == 'Employee'
        location.employee_account_id = @current_user.id
      elsif @current_user.role == 'Client'
        location.client_account_id = @current_user.id
      end
    end

    def location_params
      params.require(:location).permit(:address, :city, :state, :country, :description, :town, :postal_code)
    end
  end
end
