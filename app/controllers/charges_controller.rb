class ChargesController < ApplicationController
  before_action :authenticate_user!

  def new
  end

  def create
    # Amount in cents
    if params[:booking_id]
      @booking = Booking.find(params[:booking_id])
    elsif params[:invoice_id]
      @booking = Invoice.find(params[:invoice_id])
    end

    if @booking.user == current_user

      begin
        customer = Stripe::Customer.create(
          :email => params[:stripeEmail],
          :source  => params[:stripeToken]
        )
      rescue Faraday::ClientError => e
        flash[:error] = e.message
        redirect_to new_charge_path
      end 
      begin
        charge = Stripe::Charge.create(
          :customer    => customer.id,
          :amount      => params[:amount].to_i * 100,
          :description => params[:description],
          :currency    => 'eur'
        )

      rescue Stripe::CardError => e
        flash[:error] = e.message
        redirect_to new_charge_path

      end 

      @booking.update_attribute(:paid, true)
      @booking.update_attribute(:paid_at, Time.now.utc)
      @booking.update_attribute(:paymenttype_id, 2)
      @booking.update_attribute(:stripe_token, params[:stripeToken])
      redirect_to '/'
    else
      flash[:error] = 'This is not your booking to pay.'
      redirect_to '/'
    end

  end

end
