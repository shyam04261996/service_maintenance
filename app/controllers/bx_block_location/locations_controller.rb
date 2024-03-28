module BxBlockLocation
  class LocationsController < ApplicationController
    before_action :authenticate_user

    def create_location
      @location = Location.new(location_params)
      if @location.save
        render json: { location: BxBlockLocation::LocationSerializer.new(@location).serializable_hash, message: 'Location created successfully' }, status: :created
      else
        render json: @location.errors, status: :unprocessable_entity
      end
    end

    private

    def location_params
      params.require(:location).permit(:address, :city, :state, :country, :description, :town, :postal_code)
    end
  end
end
