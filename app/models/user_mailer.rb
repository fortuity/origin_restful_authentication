class UserMailer < ActionMailer::Base
  def signup_notification(user)
    setup_email(user)
    @subject    += 'Please activate your new account'
  
    @body[:url]  = "#{Conf.site_url}activate/#{user.activation_code}"
  
  end
  
  def activation(user)
    setup_email(user)
    @subject    += 'Your account has been activated!'
    @body[:url]  = "#{Conf.site_url}"
  end

  def forgot_password(user)
    setup_email(user)
    @subject    += 'You have requested to change your password'
    @body[:url]  = "#{Conf.site_url}reset_password/#{user.password_reset_code}"
  end

  def reset_password(user)
    setup_email(user)
    @subject    += 'Your password has been reset.'
  end

  def message_to_admin(subject,body)
    @admin = User.find_by_login(Conf.admin_login)
    @recipients  = @admin.email
    @from        = @admin.email
    @subject     = "#{Conf.site_name}"
    @sent_on     = Time.now
    @subject    += subject
    @body[:body]  = body
  end
  
  protected
    def setup_email(user)
      @recipients  = "#{user.email}"
      @from        = "#{Conf.site_email_address}"
      @subject     = "#{Conf.site_name}"
      @sent_on     = Time.now
      @body[:user] = user
    end
end
