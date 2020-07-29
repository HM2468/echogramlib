class UploadController < ApplicationController
    def submit
        user = session[:user_id]
        gram = EchogramTemp.where(user_id: user)
        count = gram.count
        if count > 0
            if repeated?
                flash[:danger] = "You have already submitted everything."
                redirect_to echogram_temps_path
            else
                #email to admin for confirmation
                SubmitMailer.mail_admin(user).deliver_now

                #email to current user for feedback of submitting
                SubmitMailer.mail_user(user).deliver_now

                gram.each do |item|
                    item.update(editable: false)
                end

                flash[:success] = "Your uploading is submited."
                redirect_to echogram_temps_path
            end
        else
            flash[:danger] = "You have nothing to submit. Please upload something first."
            redirect_to echogram_temps_path
        end

    end

private
    def repeated?
        repeated_submitting = true
        user = session[:user_id]
        gram = EchogramTemp.where(user_id: user)
        gram.each do |item|
            #if one editable record found, submitting is not repeated
           if item.editable
                repeated_submitting = false
                break
           end
        end
        return repeated_submitting
    end
end
