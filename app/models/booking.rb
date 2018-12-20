class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :teacher, class_name: 'User', optional: true
  mount_uploader :invoice, FileUploader
  validates_presence_of :user_id, :price
  scope :paid, -> () { where(paid: true) }
  scope :teacher_approved, -> () { where(teacher_approved: true) }
  before_validation :set_invoice_due
  before_validation :set_price

  def description
    "Class with #{teacher.name} at #{requested_start.strftime("%d %B %Y %H:%M")}"
  end

  def pdf
    invoice
  end

  def amount
    hours = teacher.hourly_rate
    hours ? 50 : hours
  end

  def set_price
    self.price ||= amount
  end

  def due_date
    invoice_due
  end

  def is_paid
    paid
  end

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

  def invoice_amount
    price
  end

  def set_invoice_due
    if self.invoice_due.blank? && self.teacher_approved == true
      self.invoice_due = 1.weeks.since
    end
  end

  def for_teacher
    if location == 'Viipurinkatu'
      invoice_amount * 0.8
    else
      invoice_amount * 0.9
    end    
  end

  def for_room_rental
    location == 'Viipurinkatu'  ? (invoice_amount * 0.1) : 0
  end

  def for_nci
    location == 'Viipurinkatu'  ? (invoice_amount * 0.025) : 0
  end

  def for_wms
    location == 'Viipurinkatu'  ? (invoice_amount * 0.075) : (invoice_amount * 0.1)
  end

  def viitenumero
     FIViite.generate(sprintf("7%05d", id))
  end
  
  def invoice_id
    "7" + sprintf("%04d", id)
  end

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

       # Booking.skip_callback(:update, :before, :generate_invoice)

       save(validate: false)

       # Booking.set_callback(:update, :before, :generate_invoice)
    end

  end
  
  protected


  def update_invoice_attributes
    if invoice.present? && invoice_changed?
      if invoice.file.exists?
        self.invoice_content_type = invoice.file.content_type
        self.invoice_size = invoice.file.size
      end
    end
  end
end
