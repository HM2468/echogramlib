class CompositionTemp < ApplicationRecord

    validate :gramname_valid
    validate :species_valid
    validate :numbers_valid
    validate :mean_length_valid
 
    private

      def gramname_valid
        if echogram_name == "Select echogram"
            errors.add(:composition_temp,"Select an echogram image or upload one first.")
        end
      end

      def species_valid
        if species == "Select species"
            errors.add(:composition_temp,"Select species from the dropdown list.")
        end
      end

      def numbers_valid
        if numbers.empty?
          errors.add(:composition_temp, "Numbers input is empty.")
        else
          if integer_valid?(numbers)
            if numbers.to_i <= 0 || numbers.to_i > 10000
              errors.add(:composition_temp, "Numbers input is out of numbers range.")
            end
          else
            errors.add(:composition_temp, "Numbers input invalid.")
          end
        end
      end

      def mean_length_valid
        if mean_length.empty?
          errors.add(:composition_temp,"Mean length input is empty")
        else
          if float_valid?(mean_length)
            if mean_length.to_i < 0 || mean_length.to_i > 500
              errors.add(:composition_temp, "Mean length input is out of length range.")
            end
          else
            errors.add(:composition_temp, "Mean length input invalid.")
          end
        end 
      end

      #to judge whether an input is a valid float number form
      def float_valid?(input)
        temp = input.to_s
        true_num = true
        #invalid input if there are more than one "."
        #and start with "."
        dot_num = temp.count(".")  
        if dot_num != 0
          if dot_num > 1
            true_num = false
          end
          if temp.index(".") == 0
            true_num = false
          end
        end
        #invalid input if there are more than one "-"
        #and not start with "-"
        minus_num = temp.count("-")
        if minus_num != 0
          if minus_num > 1
            true_num = false
          end
          if temp.index("-") != 0
            true_num = false
          end
        end
      
        #invalid input if there are other symbols
        temp.each_char do |r|
            flag = (45..57).cover?(r.ord) && r.ord != 47
            if !flag
                true_num = false
            end
        end
        return true_num
      end

      #to judge whether an input is a valid integer number form
      def integer_valid?(input)
        temp = input.to_s
        true_num = true      
        #invalid input if there are other symbols
        temp.each_char do |r|
            flag = (48..57).cover?(r.ord)
            if !flag
                true_num = false
            end
        end
        return true_num
      end
  
end
