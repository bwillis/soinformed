class ContactsController < ApplicationController

  def index
    current_user.contacts.build(:location_display => current_user.default_location_display)
    @contacts = current_user.contacts
    fresh_when(@contacts)
  end

  def create
    @contact = current_user.contacts.build(contact_params)

    if @contact.save
      redirect_to contacts_path, notice: 'Contact was successfully created.'
    else
      redirect_to contacts_path, alert: model_alert(@contact)
    end
  end

  def update
    @contact = current_user.contacts.find(params[:id])

    if @contact.update_attributes(contact_params)
      redirect_to contacts_path, notice: 'Contact was successfully updated.'
    else
      redirect_to contacts_path, alert: model_alert(@contact)
    end
  end

  def destroy
    @contact = current_user.contacts.find(params[:id])
    @contact.destroy

    redirect_to contacts_path, notice: 'Contact was successfully removed.'
  end

  private

    def model_alert(model)
      "Please fix these issues and try again: <ul><li>#{model.errors.full_messages.join("</li><li>")}</li></ul>".html_safe
    end

    def contact_params
      params.require(:contact).permit(:phone_number, :name, :notify_state, :location_display)
    end
end
