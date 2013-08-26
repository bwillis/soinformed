class ContactsController < ApplicationController
  def index
    current_user.contacts.build
  end

  def create
    @contact = current_user.contacts.build(contact_params)

    if @contact.save
      redirect_to contacts_path, notice: 'Contact was successfully created.'
    else
      flash[:alert] = model_alert(@contact)
      render :index
    end
  end

  def update
    @contact = current_user.contacts.find(params[:id])

    if @contact.update_attributes(contact_params)
      redirect_to contacts_path, notice: 'Contact was successfully updated.'
    else
      current_user.contacts.build
      flash[:alert] = model_alert(@contact)
      render :index
    end
  end

  def destroy
    @contact = current_user.contacts.find(params[:id])
    @contact.destroy

    redirect_to contacts_url, notice: 'Contact was successfully removed.'
  end

  private

    def model_alert(model)
      "Oh noes! Please fix these issues and try again: <ul><li>#{model.errors.full_messages.join("</li><li>")}</li></ul>".html_safe
    end

    def contact_params
      params.require(:contact).permit(:phone_number, :name, :notify_state)
    end
end
