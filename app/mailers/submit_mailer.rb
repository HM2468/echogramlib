class SubmitMailer < ApplicationMailer
    include SessionsHelper

    def mail_admin
        mail(to: "huangmiao2468@gmail.com", subject: 'New uploading.')
        #@name = current_user.name
    end

    def mail_user
        email = current_user.email
        mail(to: email, subject: 'Submitting Recieved.')
    end

    def submit_reply
    end

end
