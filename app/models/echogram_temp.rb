class EchogramTemp < ApplicationRecord

    has_one_attached :gram
    # allows destroying an echogram via a profile's update action
    accepts_nested_attributes_for :gram_attachment, allow_destroy: true  


    validates :latitude,:longitude, presence: {message: "%{attribute} input is empty."}
    validates :latitude,:longitude, numericality: {message: "%{attribute} input is not a valid number."},allow_blank:true
    validate :range_valid

    validate :gram_valid
    validates_uniqueness_of :image_filename, message: "Image file name already exists."


    private
      def range_valid
          if latitude.to_f > 90 || latitude.to_f < -90 
              errors.add :echogram_temp, 'Latitude is out of range.' 
          end

          if longitude.to_f > 180 || longitude.to_f < -180 
            errors.add :echogram_temp, 'Longitude is out of range.' 
          end
      end

      def gram_valid
        if gram.attached?
            if gram.image?()
                name_valid(gram.filename.to_s)
                size_valid
            else  
                errors.add :gram, 'Your uploadding is not an image file.' 
            end      
        else
            errors.add :gram, 'You did not choose any image.' 
        end
      end

      def gram_conflict      
        image_name_filter = gram.filename.to_s
        if can_upload?              
            if duplicate_filename?(image_name_filter)
              errors.add :gram, 'Echogram image file name already exists.' 
            else
              gram_filter = image_name_filter[0,24]
              if gramname_comflict?(gram_filter)
                errors.add :gram, 'Echogram name conflict with other user uploading' 
              end
            end
        end
      end

      def size_valid
          if gram.byte_size > (3*1024*1024)  
            errors.add :gram, 'Image file size is too big.'
          end  
      end

      def name_valid(imagename)
        if imagename_downcase_valid?(imagename)
            if imagename_prefix_valid?(imagename)
              if format_valid?(imagename)
                  unless type_valid?(imagename)
                    errors.add :gram, 'File format invalid.'
                  end
                  unless dot_valid?(imagename)
                    errors.add :gram, 'There should be one and only one "." contained in filenane.'
                  end
                  unless  imagename_date_valid?(imagename)
                    errors.add :gram, 'Fishing date invalid'
                  end
                  unless imagename_time_valid?(imagename)
                    errors.add :gram, 'Start fishing time invalid'
                  end
              else
                  errors.add :gram, 'Name format invalid'
              end                  
            else
              errors.add :gram, 'Image file name should start with "echogram_".'
            end

        else
            errors.add :gram, 'All letters should be in downcase.' 
        end
      end

      def imagename_downcase_valid?(name)
        match = true
        name.each_char do |r|
          if (65..90).cover?(r.ord)
            match = false
          end
        end
        return match
      end

      def imagename_prefix_valid?(name)        
        return name[0,9] == "echogram_" 
      end

      def imagename_date_valid?(name)
        b1 = (1990..2030).cover?(name[9,4].to_i) 
        b2 = (0..12).cover?(name[13,2].to_i) 
        b3 = (0..31).cover?(name[15,2].to_i) 
        match = b1&&b2&&b3
        return match
      end

      def imagename_time_valid?(name)
        b1 = (0..23).cover?(name[18,2].to_i) 
        b2 = (0..59).cover?(name[20,2].to_i) 
        b3 = (0..59).cover?(name[22,2].to_i) 
        match = b1&&b2&&b3
        return match
      end

      def format_valid?(name)
        b1 = name[17] == "_" 
        b2 = name[24] == "_" 
        b3 = name[29] == "." 
        match = b1&&b2&&b3
        return match
      end

      def dot_valid?(name)
        num = name.count(".")
        if num == 1 
          return true
        else 
          return false
        end
      end

      def type_valid?(name)
        temp   = name.split(".")
        format = temp[1]  
        match  = ["gif","jpg","jpeg","png"].include?(format)
        return match
      end
  end