class UsersMailer <  ActionMailer::Base
  default from: "play@worldmusic.school"
  default "Message-ID" => lambda {"<#{SecureRandom.uuid}@worldmusic.school>"}


  def new_student_staff(user)
    @user = user
    User.all.each do |recipient|
      next unless recipient.has_role?(:admin)
      mail(to: recipient.email, subject: 'New student registration: ' + @user.name)
    end
  end
  
  def new_student_student(user)
    @user = user
    attachments['membership_fee_invoice.pdf'] = @user.invoices.last.pdf.url
    mail(to: user.email, subject: 'You have registered for World Music School!')
  end
  
  def new_student_staff_legacy(user)
    @user = user
    User.all.each do |recipient|
      next unless recipient.has_role?(:admin)
      mail(to: recipient.email, subject: 'New student registration: ' + @user.name)
    end
  end
  
  def new_student_student_legacy(user)
    @user = user
    mail(to: user.email, subject: 'You have registered for World Music School!')
  end
  
    
  def new_teacher_staff(user)
    @user = user
    User.all.each do |recipient|
      next unless recipient.has_role?(:admin)
      mail(to: recipient.email, subject: 'New teacher registration: ' + @user.name)
    end
  end
  
  def new_teacher_teacher(user)
    @user = user
    mail(to: user.email, subject: 'You have registered for World Music School!')
  end
  
  def approved_teacher(user)
    @user = user
    mail(to: user.email, subject: 'You have been accepted as a teacher at World Music School')
  end
  
  def approved_student(user)
    @user = user
    mail(to: user.email, subject: 'You have been accepted as a student at World Music School')
  end 
end