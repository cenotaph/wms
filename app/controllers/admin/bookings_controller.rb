class Admin::BookingsController < Admin::BaseController
  
  
  def destroy

    @booking = Booking.find params[:id]
    if can? :destroy, @booking
      @booking.destroy!
    end
    redirect_to admin_invoices_path
  end
  def mark_as_paid
    @booking = Booking.find params[:id]
    @booking.paid = true
    if @booking.save
      flash[:notice] = 'The invoice has been marked as paid.'
      redirect_to admin_invoices_path
    end
    
  end

end