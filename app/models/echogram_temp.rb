class EchogramTemp < ApplicationRecord

    has_one_attached :gram
    # allows destroying an echogram via a profile's update action
    accepts_nested_attributes_for :gram_attachment, allow_destroy: true  


    validate :gram_valid?
     
    #no blank form allowwed 
    validates_presence_of :latitude, message: 'Latitude input is empty.'
    validates_presence_of :longitude, message: 'Longitude input is empty.'
    validates_inclusion_of :latitude, :in => (-90..90), message: 'Latitude input invalid.'
    validates_inclusion_of :longitude, :in => (-180..180), message: 'Longitude input invalid.'
    
    private

      def coordinate_valid?
      end

      def gram_valid?
        if gram.attached?
          name_valid(gram.filename.to_s)
          if gram.byte_size > (3*1024*1024)  
            errors.add :gram, 'Image file size is too big.'
          end
        else
          errors.add :gram, 'You did not choose any image.' 
        end
      end

      def name_valid(imagename)
        if imagename_downcase_valid?(imagename)

            if imagename_prefix_valid?(imagename)

                  if imagename_split_valid?(imagename)
                      unless imagename_format_valid?(imagename)
                        errors.add :gram, 'File format invalid.'
                      end

                      unless  imagename_date_valid?(imagename)
                        errors.add :gram, 'Fishing date in filename is invalid'
                      end

                      unless imagename_time_valid?(imagename)
                        errors.add :gram, 'Start fishing time in filename is invalid'
                      end
                  else
                    errors.add :gram, 'Filename should be split with "_" in right place.'
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

      def imagename_split_valid?(name)
        b1 = name[17] == "_" 
        b2 = name[24] == "_" 
        b3 = name[29] == "." 
        match = b1&&b2&&b3
        return match
      end

      def imagename_format_valid?(name)
        temp   = name.split(".")
        format = temp[1]  
        match  = ["gif","jpg","jpeg","png"].include?(format)
        return match
      end

  end
  