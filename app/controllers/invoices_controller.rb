class InvoicesController < ApplicationController

  before_action :authenticate_user!
  
  def generate_annual_student_fee
    @user = User.friendly.find(params[:id])
    @invoice = Invoice.find(params[:id])
    if current_user == @invoice.user || current_user.has_role?(:admin)
      respond_to do |format|
        # format.html
        format.pdf do
          render pdf: "file_name" , layout: 'invoice'
        end
      end
    else
      flash[:error] = 'This is not your invoice.'
      redirect_to '/'
    end
  end
  
  
end