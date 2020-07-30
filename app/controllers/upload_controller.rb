class UploadController < ApplicationController

    before_action :logged_in_user, only: [:submit,:confirm,:accept,:show,:reject]
    before_action :logged_in_admin, only: [:confirm,:accept,:show,:reject]

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

    def confirm
        #global params shared in confirm/accept/reject
        $id  = params[:id]
        user_gram = EchogramTemp.all.where(user_id: $id)
        sorted = user_gram.order(created_at: :desc)
        @display = sorted.paginate(page: params[:page],per_page: 10)    
    end

    def accept
        temp = EchogramTemp.find_by!(image_filename: params[:filename])
        gramname = temp.echogram_name
        compositions = CompositionTemp.where(echogram_name:gramname)  
        sum = 0.0
        unless composition_temp_empty?(gramname)         
            compositions.each do |r|
                sum += r.numbers.to_f
            end
        end

        filename = temp.image_filename
        dest_folder = "/Users/HM/Desktop/echogramlib/public/images/"
        newfile = dest_folder + filename

        unless FileTest::exist?(newfile)
            binary = temp.gram.download
            File.open(newfile,"wb") do |f|
              f.write(binary)
            end
        end

        Echogram.create!(
            echogram_name:      gramname,
            image_filename:     filename,
            frequency:          temp.frequency,
            latitude:           temp.latitude,
            longitude:          temp.longitude,
            user_id:            temp.user_id
        )

        unless composition_empty?(gramname)
            compositions.each do |r|
                sciname = split_string(r.species)
                hash = species_hash
                percent = (r.numbers/sum).round(4)
                Composition.create!(
                    echogram_name:     gramname,
                    species_code:      hash["#{sciname}"],
                    mean_length:       r.mean_length,
                    n_individuals:     r.numbers,
                    percentage:        percent
                )
                r.destroy
            end
        end

        temp.gram.purge
        temp.destroy
        flash[:success] = "Image was imported successfully."
        redirect_to confirm_path(:id => $id)
    end

    def reject
        temp = EchogramTemp.find_by!(image_filename: params[:filename])
        temp.update(editable: true)
        flash[:danger] = "Image importing was rejected."
        redirect_to confirm_path(:id => $id)
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

    def composition_empty?(gramname)
        temp = Composition.where(echogram_name:gramname)
        count = temp.count
        if count == 0
            return true
        else
            return false
        end
    end

    def composition_temp_empty?(gramname)
        temp = CompositionTemp.where(echogram_name:gramname)
        count = temp.count
        if count == 0
            return true
        else
            return false
        end
    end

    def species_hash
        hash = Hash.new
        temp = Species.all
        temp.each do |r|
            hash["#{r.scientific_name}"] = r.species_code
        end
        return hash
    end

    def split_string(string)
        array = string.split('/')
        return array[1]
    end

end
