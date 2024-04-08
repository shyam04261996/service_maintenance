module BxBlockBooking
 class BookingsController < ApplicationController
    before_action :authenticate_user


    def index_bookings
      @bookings = Booking.all
      if @bookings.empty?
        return render json: { error: 'No bookings available' }, status: :not_found
      end
      serialized_bookings = @bookings.map do |booking|
        BxBlockBooking::BookingSerializer.new(booking).serializable_hash
      end

      render json: { bookings: serialized_bookings }, status: :ok
    end

    # def create_booking
    #   unless current_user.role == 'Client'
    #     return render json: { error: 'You do not have access to create a booking' }, status: :unauthorized
    #   end
    #   @booking = Booking.new(booking_params.merge(client_account_id: current_user.id))
    #   if @booking.save
    #     render json: { booking: BxBlockBooking::BookingSerializer.new(@booking).serializable_hash, message: 'Booking created successfully' }, status: :created
    #   else
    #     render json: @booking.errors, status: :unprocessable_entity
    #   end
    # end

    def create_booking
      unless current_user.role == 'Client'
        return render json: { error: 'You do not have access to create a booking' }, status: :unauthorized
      end
      booking_params_with_default_status = booking_params.merge(status: 'Pending')
      @booking = Booking.new(booking_params_with_default_status.merge(client_account_id: current_user.id))
      if @booking.save
        render json: { booking: BxBlockBooking::BookingSerializer.new(@booking).serializable_hash, message: 'Booking created successfully' }, status: :created
      else
        render json: @booking.errors, status: :unprocessable_entity
      end
    end


    def update_booking
      @booking = BxBlockBooking::Booking.find(params[:booking_id])
      if @booking.update(booking_params)
        render json: { booking: BxBlockBooking::BookingSerializer.new(@booking).serializable_hash, message: 'Booking updated successfully' }, status: :ok
      else
        render json: @booking.errors, status: :unprocessable_entity
      end
    end

    def delete_booking
      @booking = BxBlockBooking::Booking.find(params[:booking_id])
      if @booking.present?
        @booking.destroy
        render json: { message: 'Booking deleted successfully' }, status: :ok
      else
        render json: { error: 'Booking not found' }, status: :not_found
      end
    end

    def show_booking
      @booking = BxBlockBooking::Booking.find_by(id: params[:booking_id])
      if @booking.present?
        render json: { booking: BxBlockBooking::BookingSerializer.new(@booking).serializable_hash, message: 'Booking found successfully' }, status: :ok
      else
        render json: { error: 'Booking not found' }, status: :not_found
      end
    end

    def complete_service
      @service = BxBlockService::Service.find(params[:service_id])
      @booking = BxBlockBooking::Booking.find_by(id: params[:booking_id], service_id: @service.id)
      if @service.present? && @booking.present?
        if current_user.role != 'Client'
          return render json: { error: 'You do not have permission to complete this booking' }, status: :unauthorized
        end
        # discount_percentage = 15
        @discount_percentage = @service.discount_percentage
        discounted_price = @service.price * @discount_percentage / 100
        if @booking.update(status: 'Complete', price: @service.price, discount_amount: discounted_price, total_amount: (@service.price - discounted_price))
          render json: { 
            booking: BxBlockBooking::BookingSerializer.new(@booking).serializable_hash, 
            service: BxBlockService::ServiceSerializer.new(@service).serializable_hash, 
            message: "Booking status updated to 'Complete' successfully with a #{@service.discount_percentage} discount", 
            discounted_price: discounted_price 
          }, status: :ok
        else
          render json: { error: 'Failed to update booking status', errors: @booking.errors }, status: :unprocessable_entity
        end
      else
        render json: { error: 'Service not found or booking not associated with the service' }, status: :not_found
      end
    end

    private

    def booking_params
      params.require(:booking).permit(:full_name, :mobile_number, :start_time, :end_time, :address, :service_department, :status, :description, :service_id)
    end
 end
end
