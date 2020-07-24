class EchogramTemp < ApplicationRecord

    has_one_attached :gram
    # allows destroying an echogram via a profile's update action
    accepts_nested_attributes_for :gram_attachment, allow_destroy: true
  
    #validation for image file size
    #validate :gram_byte_size, if: ->{ gram.attached? }
  
    #validation for image file name
    validate :gram_file_name, if: ->{ gram.attached? }
  
    validates :gram, attached: true, size: { less_than: 3.megabytes , message: 'is not given between size' }
  
    
    #no blank form allowwed
    validates :longitude, presence: true
    validates :latitude, presence: true
  
    private
      def gram_byte_size
        errors.add :gram, 'image file is too big.' if gram.byte_size > (1080 ** 2)
      end
  
  
      def gram_file_name
        name = gram.filename.to_s
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
  
        errors.add :gram, 'image file name error' if !match
      end
  
  
  end
  