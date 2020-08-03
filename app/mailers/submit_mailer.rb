class SubmitMailer < ApplicationMailer


    def mail_admin(name,url)      

        @name = name
        #@url = "http://localhost:3000/confirm?id=#{user_id}"
        #@url = request.base_url + "/confirm?id=#{user_id}"
        @url = url       
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
