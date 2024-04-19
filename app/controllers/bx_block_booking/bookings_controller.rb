module BxBlockBooking
 class BookingsController < ApplicationController
    before_action :authenticate_user
    before_action :find_account, only: [:create_booking, :update_booking, :delete_booking, :show_booking, :index_bookings]

    def create_booking
      unless @current_user.role == 'Client'
        return render json: { error: 'You do not have access to create a booking' }, status: :unauthorized
      end
      @status = booking_params.merge(status: 'Pending')
      @booking = Booking.new(@status.merge(client_account_id: @current_user.id))
     
      if @booking.save
        render json: { booking: BxBlockBooking::BookingSerializer.new(@booking).serializable_hash, message: 'Booking created successfully' }, status: :created
      else
        render json: @booking.errors, status: :unprocessable_entity
      end
    end

    def update_booking
      @booking = BxBlockBooking::Booking.find_by(client_account_id: @current_user.id)      
      if @booking.nil?
        render json: { error: 'Booking not found or you do not have permission to update this booking' }, status: :not_found
      elsif @booking.update(booking_params)
        render json: { booking: BxBlockBooking::BookingSerializer.new(@booking).serializable_hash, message: 'Booking updated successfully' }, status: :ok
      else
        render json: { errors: @booking.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def delete_booking
      @booking = BxBlockBooking::Booking.find_by(id: params[:booking_id])
      if @booking.present?
        @booking.destroy
        render json: { message: 'Booking deleted successfully' }, status: :ok
      else
        render json: { error: 'Booking not found or you do not have permission to delete it' }, status: :unprocessable_entity
      end
    end

    def show_booking
      @booking = BxBlockBooking::Booking.find(params[:booking_id])
       render json: { booking: BxBlockBooking::BookingSerializer.new(@booking).serializable_hash}, status: :ok
     rescue ActiveRecord::RecordNotFound
      render json: { error: 'Booking not found' }, status: :not_found
    end


    def index_bookings
      @bookings = BxBlockBooking::Booking.where(client_account_id: @current_user.id)
      if @bookings.present?
        render json: { bookings: @bookings.map { |book| BxBlockBooking::BookingSerializer.new(book).serializable_hash } }, status: :ok
      else
        render json: { meta: { message: "No bookings found for the current user" } }, status: :not_found
      end
    end

    private
    def booking_params
      params.require(:booking).permit(:full_name, :mobile_number, :start_time, :end_time, :address, :service_department, :status, :description, :service_id)
    end

    def find_account
      @current_user ||= AccountBlock::Account.find(@token.id)
    end
 end
end
