class ApplicationMailer < ActionMailer::Base
  default from: 'play@worldmusic.school'
  default "Message-ID" => lambda {"<#{SecureRandom.uuid}@worldmusic.school">}
  layout 'mailer'
end
