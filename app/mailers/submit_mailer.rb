class SubmitMailer < ApplicationMailer


    def mail_admin(user_id)      
        current_user = User.find_by(id: user_id)
        @name = current_user.name
        @url = "1234567"
        mail(to: "huangmiao2468@gmail.com", subject: 'New uploading.')
    end

    def mail_user(user_id)
        current_user = User.find_by(id: user_id)
        email = current_user.email
        @name = current_user.name
        mail(to: email, subject: 'Submitting Recieved.')
    end

    def submit_reply
    end

end
