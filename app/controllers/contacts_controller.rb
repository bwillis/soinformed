class ContactsController < ApplicationController
  def index
    current_user.contacts.build
    @contacts = current_user.contacts
  end

  def create
    @contact = current_user.contacts.build(params[:contact])

    if @contact.save
      redirect_to contacts_path, notice: 'Contact was successfully created.'
    else
      @contacts = current_user.contacts
      render :index, alert: model_alert(@contact)
    end
  end

  def update
    @contact = current_user.contacts.find(params[:id])

    if @contact.update_attributes(params[:contact])
      redirect_to contacts_path, notice: 'Contact was successfully updated.'
    else
      @contacts = current_user.contacts
      render :index, alert: model_alert(@contact)
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
end
