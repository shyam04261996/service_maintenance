module BxBlockInvoice
	class InvoicesController < ApplicationController
		
	end
end
# # app/controllers/bx_block_booking/bookings_controller.rb
# module BxBlockBooking
#   class BookingsController < ApplicationController
#     # Other actions...

#     def invoice
#       @booking = BxBlockBooking::Booking.find(params[:id])
#       respond_to do |format|
#         format.html { redirect_to @booking, notice: "Booking not found" }
#         format.pdf do
#           render pdf: "invoice",
#                  template: "bookings/invoice.pdf.erb",
#                  layout: 'pdf.html',
#                  show_as_html: params.key?('debug')
#         end
#       end
#     end
#   end
# end
