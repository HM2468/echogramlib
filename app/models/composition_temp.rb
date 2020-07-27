class CompositionTemp < ApplicationRecord
        #no blank form allowwed
        validates_presence_of :mean_length, message: 'Mean length input is empty'
        validates_presence_of :numbers, message: 'Numbers input is empty'

        validate :species_form
        validate :gram_form

        private
  
        def gram_form
          if echogram_name == "Select echogram"
             errors.add(:composition_temp,"Select an echogram image or upload one first.")
          end
        end

        def species_form
          if species == "Select species"
             errors.add(:composition_temp,"Select species from the dropdown list.")
          end
        end

      
end
