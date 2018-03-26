class Invoice < ApplicationRecord
  belongs_to :user
  mount_uploader :pdf, FileUploader
  validates_presence_of :user_id, :description
  before_save :update_pdf_attributes
  before_create :save_due_date
  after_save :update_user_membership

  def viitenumero
     FIViite.generate(sprintf("9%05d", id))
  end
  
  def invoice_amount
    amount
  end

  def invoice_due
    created_at.to_date + 14
  end

  def is_paid
    paid
  end

  def update_user_membership
    if paid == true && paid_changed?
      user.set_paid_membership
    end
    
  end
  def invoice_id
    "9" + sprintf("%04d", id)
  end

  def annual_student_membership_fee
    view = ActionView::Base.new(ActionController::Base.view_paths.first, {})
           view.extend(ApplicationHelper)
           view.extend(Rails.application.routes.url_helpers)
           pdf = WickedPdf.new.pdf_from_string(
           view.render(
            template: 'invoices/annual_student_fee.pdf.erb',
            locals: { :@alert => self }),
            :layout => 'layouts/pdf.html.erb',
            :print_media_type => false,
            :page_size => "A4",
            :show_as_html => true,
            :disable_smart_shrinking => false, 
          )
  end
  
  private
  
  def save_due_date
    if due_date.blank?
      self.due_date = (Time.current.to_date + 14)
    end
  end
  
  def update_pdf_attributes
    if pdf.present? && pdf_changed?
      if pdf.file.exists?
        self.pdf_content_type = pdf.file.content_type
        self.pdf_size = pdf.file.size
      end
    end
  end
  
  
end
