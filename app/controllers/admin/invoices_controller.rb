class Admin::InvoicesController < Admin::BaseController
  
  
  def destroy
    @invoice = Invoice.find params[:id]
    if @invoice.destroy!
      flash[:notice] = 'This legacy teacher has been destroyed.'
      redirect_to admin_invoices_path
    end
  end
  
  def edit
    @invoice = Invoice.find params[:id]
    if cannot? :edit, @invoice
      flash[:notice] = 'You do not have permission to edit invoices.'
      redirect_to admin_invoices_path
    end
  end
  
  def index
    @invoices = [Invoice.all, Booking.teacher_approved].flatten.compact
  end
  
  def mark_as_paid
    @invoice = Invoice.find params[:id]
    @invoice.is_paid = true
    if @invoice.save
      flash[:notice] = 'The invoice has been marked as paid.'
      redirect_to admin_invoices_path
    end
    
  end
  
  def update
    @invoice = Invoice.find(params[:id])
    if cannot? :edit, @invoice
      flash[:error] = 'Cannot edit invoice profile.'
    else
      if @invoice.update_attributes(invoice_params)
        flash[:notice] = 'Updated invoice profile.'
        redirect_to admin_invoices_path
      else
        flash[:error] = @invoice.errors.inspect
        if @invoice.applied_as_teacher == 1
          render template: 'register_as_teacher'
        else
          render template: 'register_as_student'
        end
      end
    end
  end
  
  protected
  
  def invoice_params
    params.require(:invoice).permit(:description, :is_paid, :due_date)
  end
  
  
end