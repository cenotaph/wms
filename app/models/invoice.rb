class Invoice < ApplicationRecord
  belongs_to :user
  mount_uploader :pdf, FileUploader
  validates_presence_of :user_id, :description
  before_save :update_pdf_attributes
  before_create :save_due_date

  def viitenumero
     FIViite.generate(sprintf("7%05d", id))
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
