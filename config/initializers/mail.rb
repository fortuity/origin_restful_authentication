# Email settings for your own server
# ActionMailer::Base.delivery_method = :smtp  # or :sendmail
# ActionMailer::Base.smtp_settings = {
#  :address => "mail.YOURDOMAIN.com",
#  :port => 25,
#  :domain => "YOURDOMAIN.com",
#  :authentication => :login,
#  :user_name => "YOURUSERNAME@YOURDOMAIN.com",
#  :password => "YOURPASSWORD"
#}

# Email settings for Google gmail
require 'smtp_tls'
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  :address => "smtp.gmail.com",
  :port => 587,
  :domain => "localhost",
  :authentication => :plain,
  :user_name => GOOGLE_ACCOUNT_LOGIN,
  :password => GOOGLE_ACCOUNT_PASSWORD
}
