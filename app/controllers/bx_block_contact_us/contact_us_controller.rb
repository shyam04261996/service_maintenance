module BxBlockContactUs
  class ContactUsController < ApplicationController
    before_action :authenticate_user

    def create
      @contact = BxBlockContactUs::Contact.new(contact_params)
      if @contact.save
        render json: { contact: BxBlockContactUs::ContactSerializer.new(@contact).serializable_hash, message: 'Contact created successfully' }, status: :created
      else
        render json: { errors: @contact.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def update
	  @contact = BxBlockContactUs::Contact.find_by(id: params[:id])
	  if @contact.present?
	    if @contact.update(contact_params)
	      render json: { contact: BxBlockContactUs::ContactSerializer.new(@contact).serializable_hash, message: 'Contact updated successfully' }, status: :ok
	    else
	      render json: { errors: @contact.errors.full_messages }, status: :unprocessable_entity
	    end
	  else
	    render json: { error: 'Contact not found' }, status: :not_found
	  end
	end

	def destroy
	  @contact = BxBlockContactUs::Contact.find_by(id: params[:id])
	  if @contact.present?
	    @contact.destroy
	    render json: { message: 'Contact deleted successfully' }, status: :ok
	  else
	    render json: { error: 'Contact not found' }, status: :not_found
	  end
	end

	def index
	  @contacts = BxBlockContactUs::Contact.all
	  render json: { contacts: @contacts.map { |contact| BxBlockContactUs::ContactSerializer.new(contact).serializable_hash } }, status: :ok
	end

    private

    def contact_params
      params.require(:contact).permit(:name, :email, :message)
    end
  end
end
