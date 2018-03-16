class BookingsMailer <  ActionMailer::Base
  default from: "play@worldmusic.school"
  default "Message-ID" => lambda {"<#{SecureRandom.uuid}@worldmusic.school>"}


  def confirmed_booking(booking)
    @student = booking.student
    @teacher = booking.teacher
    @booking = booking
    attachments["invoice_000#{booking.id.to_s}.pdf"] = @booking.invoice.read
    mail(to: @student.email, cc: @teacher.email, subject: 'Confirmed booking for ' + @student.name + ' with ' + @teacher.name)
  end
    
end