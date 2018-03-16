class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :teacher, class_name: 'User', optional: true
  mount_uploader :invoice, FileUploader
  validates_presence_of :user_id
  scope :paid, -> () { where(fee_paid: true)}
  scope :teacher_approved, -> () { where(teacher_approved: true) }
  before_validation :set_invoice_due
  before_update :generate_invoice

  def student
    user
  end
  
  def in_future?
    if requested_start.nil? 
      return true
    else
      if requested_start > Time.current
        return true
      else
        return false
      end
    end
  end

  def set_invoice_due
    if self.invoice_due.blank? && self.teacher_approved == true
      self.invoice_due = 1.weeks.since
    end
  end

  def viitenumero
     FIViite.generate(sprintf("1%05d", id))
  end
  
  protected

  def generate_invoice

    unless invoice.nil? || teacher_approved != true

      view = ActionView::Base.new(ActionController::Base.view_paths.first, {})
      view.extend(ApplicationHelper)
      view.extend(Rails.application.routes.url_helpers)

      pdf = WickedPdf.new.pdf_from_string(
        view.render(template: 'bookings/invoice.pdf.erb', locals: {booking: self}),
          :page_size => "A4",
          :show_as_html => true,
          :disable_smart_shrinking => false
         )
       #Pass pdf to carrierwave and save url in assessment.assessment
       # Write it to tempfile
       tempfile = Tempfile.new(["invoice_#{sprintf('%06d', id)}", ".pdf"])
       tempfile.binmode
       tempfile.write pdf
       tempfile.close

       # Attach that tempfile to the invoice
       if invoice.blank?
         self.invoice = File.open tempfile.path
       end

       Booking.skip_callback(:update, :before, :generate_invoice)

       save(validate: false)

       Booking.set_callback(:update, :before, :generate_invoice)
    end

  end

  def update_invoice_attributes
    if invoice.present? && invoice_changed?
      if invoice.file.exists?
        self.invoice_content_type = invoice.file.content_type
        self.invoice_size = invoice.file.size
      end
    end
  end
end
