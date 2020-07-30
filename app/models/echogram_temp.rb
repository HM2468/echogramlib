class EchogramTemp < ApplicationRecord

    has_one_attached :gram
    # allows destroying an echogram via a profile's update action
    accepts_nested_attributes_for :gram_attachment, allow_destroy: true  
    validate :gram_valid?
    validates :image_filename, uniqueness: true
     
    #no blank form allowwed 
    validates_presence_of :latitude, message: 'Latitude input is empty.'
    validates_presence_of :longitude, message: 'Longitude input is empty.'
    
    private

      def gram_valid?
        if gram.attached?
          if !name_valid?(gram.filename.to_s)
             errors.add :gram, 'Image file name format error.' 
          elsif gram.byte_size > (1080 ** 2)  
            errors.add :gram, 'Image file size is too big.'
          else
          end
        else
          errors.add :gram, 'You did not choose any image.' 
        end
      end

      def name_valid?(name)
        temp = name.split(".")
        format = temp[1]      
        match = true
        c1 = name[0,9] == "echogram_" 
        c2 = (1990..2030).cover?(name[9,4].to_i) 
        c3 = (0..12).cover?(name[13,2].to_i) 
        c4 = (0..31).cover?(name[15,2].to_i) 
        c5 = name[17] == "_" 
        c6 = (0..23).cover?(name[18,2].to_i) 
        c7 = (0..59).cover?(name[20,2].to_i) 
        c8 = (0..59).cover?(name[22,2].to_i) 
        c9 = name[24] == "_" 
        c10 = ["0038","0120","0200"].include?(name[25,4]) 
        c11 = name[29] == "." 
        c12 = ["gif","jpg","jpeg","png"].include?(format)
        match = c1&&c2&&c3&&c4&&c5&&c6&&c7&&c8&&c9&&c10&&c11&&c12
        return match
      end
  end
  