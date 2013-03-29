class PhoneNumbersController < ApplicationController
  # GET /phone_numbers
  # GET /phone_numbers.json
  def index
    @phone_numbers = PhoneNumber.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @phone_numbers }
    end
  end

  # GET /phone_numbers/1
  # GET /phone_numbers/1.json
  def show
    @phone_number = PhoneNumber.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @phone_number }
    end
  end

  # GET /phone_numbers/new
  # GET /phone_numbers/new.json
  def new
    @phone_number = PhoneNumber.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @phone_number }
    end
  end

  # GET /phone_numbers/1/edit
  def edit
    @phone_number = PhoneNumber.find(params[:id])
  end

  # POST /phone_numbers
  # POST /phone_numbers.json
  def create
    @phone_number = PhoneNumber.new(params[:phone_number])

    respond_to do |format|
      if @phone_number.save
        format.html { redirect_to @phone_number, notice: 'Phone number was successfully created.' }
        format.json { render json: @phone_number, status: :created, location: @phone_number }
      else
        format.html { render action: "new" }
        format.json { render json: @phone_number.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /phone_numbers/1
  # PUT /phone_numbers/1.json
  def update
    @phone_number = PhoneNumber.find(params[:id])

    respond_to do |format|
      if @phone_number.update_attributes(params[:phone_number])
        format.html { redirect_to @phone_number, notice: 'Phone number was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @phone_number.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /phone_numbers/1
  # DELETE /phone_numbers/1.json
  def destroy
    @phone_number = PhoneNumber.find(params[:id])
    @phone_number.destroy

    respond_to do |format|
      format.html { redirect_to phone_numbers_url }
      format.json { head :no_content }
    end
  end
end
