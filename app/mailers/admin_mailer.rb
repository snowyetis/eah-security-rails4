class AdminMailer < ApplicationMailer
  default from: 'eahlocksmithtest216.mailer@gmail.com'

  def new_user_waiting_for_approval(user)
    @user = user
    @url  = "https://eah-security.herokuapp.com/admins/signed_up"
    mail(to: "eahlocksmithtest216.mailer@gmail.com", subject: 'A New User has Requested Access')
  end

  def new_user_approved(email)
    @email = email
    @url =  "https://eah-security.herokuapp.com/users/sign_in"
    mail(to: @email, subject: "A Message Regarding your Access to EAHS Security")
  end

end
