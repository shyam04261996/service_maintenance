module BxBlockInvoice
  class InvoicesController < ApplicationController
    
    def index
      # @invoices = Invoice.all
      pdf = WickedPdf.new.pdf_from_string(
        render_to_string('bx_block_invoice/invoices/index.html.erb', layout: false)
      )
      send_data pdf, filename: "resume.pdf", type: "application/pdf", disposition: "attachment"
    end
    
  end
end
