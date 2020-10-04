class QueryController < ApplicationController

    before_action :logged_in_admin, only: [:manage,:delete_gram]
    
    def querygram

        #initialize guery page parameters
        gram       = Echogram.all.order(echogram_name: :desc)
        @display   = gram.paginate(page: params[:page],per_page: 10)
        @count     = gram.count
        @text_spec = "All #{@count} items in the database."

        #sort species list by apperance frequncy in Decrease order
        @species_list   = species_order_by_freq_desc
        @percent_list   = percent_list
        @avglength_list = avglength_list
      
        #get parameters from front end download
        chosen_species = params[:species]
        chosen_length  = params[:avglength]
        chosen_percent = params[:percent] 
        search_input   = params[:searching] 

        per = get_percent(chosen_percent)
        len = get_length(chosen_length)


        #query algorithm 
       if  chosen_species || chosen_length || chosen_percent       
            if  chosen_species != "All" && chosen_length ==  "All" && chosen_percent ==  "All"
                temp = MyComposition.where(sciname:chosen_species)
                gramname = gramname_collection(temp)
                result = Echogram.where(echogram_name:gramname)

                result_display(result)
                set_spec_text(chosen_species,chosen_percent,chosen_length)

            elsif chosen_species != "All" && chosen_length !=  "All" && chosen_percent ==  "All" 
                temp = MyComposition.where(sciname:chosen_species)
                temp1 = temp.where('avglength>?',len)
                gramname = gramname_collection(temp1)
                result = Echogram.where(echogram_name:gramname)

                result_display(result)
                set_spec_text(chosen_species,chosen_percent,chosen_length)

            elsif chosen_species != "All" && chosen_length ==  "All" && chosen_percent !=  "All" 
                temp = MyComposition.where(sciname:chosen_species)
                temp1 = temp.where('percent>?',per)
                gramname = gramname_collection(temp1)
                result = Echogram.where(echogram_name:gramname)

                result_display(result)
                set_spec_text(chosen_species,chosen_percent,chosen_length)

            elsif chosen_species != "All" && chosen_length !=  "All" && chosen_percent !=  "All" 
                temp = MyComposition.where(sciname:chosen_species)
                temp1 = temp.where('percent>?',per)
                temp2 = temp1.where('avglength>?',len)
                gramname = gramname_collection(temp2)
                result = Echogram.where(echogram_name:gramname)

                result_display(result)
                set_spec_text(chosen_species,chosen_percent,chosen_length)

            elsif chosen_species == "All" && chosen_length !=  "All" && chosen_percent ==  "All" 
                temp = MyComposition.where('avglength>?',len)
                gramname = gramname_collection(temp)
                result = Echogram.where(echogram_name:gramname)

                result_display(result)
                set_spec_text(chosen_species,chosen_percent,chosen_length)
            
            elsif chosen_species == "All" && chosen_length ==  "All" && chosen_percent !=  "All" 

                temp = MyComposition.where('percent>?',per)
                gramname = gramname_collection(temp)
                result = Echogram.where(echogram_name:gramname)  

                result_display(result)
                set_spec_text(chosen_species,chosen_percent,chosen_length)

            elsif chosen_species == "All" && chosen_length != "All" && chosen_percent != "All" 

                temp = MyComposition.where('percent>?', per)
                temp1 = temp.where('avglength>?', len)
                gramname = gramname_collection(temp1)
                result = Echogram.where(echogram_name:gramname)  

                result_display(result)
                set_spec_text(chosen_species,chosen_percent,chosen_length)
            else
                @display
                @text_spec
                @count
            end   
        end  
        
        if search_input && search_input != ""
            gram    = Echogram.all.order(created_at: :desc)
            result  = gram.where("image_filename like ?", "%#{search_input}%")

            result_display(result)
            @text_spec = "Search input: \"#{search_input}\",  #{@count} items found."
        end
        
    end


    def details
        temp = params[:item] 

        temp1 = params[:item].first.to_s  
        @gram = Echogram.all.where(echogram_name: temp)
        @composition = MyComposition.where(gramname: temp)

        count = @composition.count
        species = []
        percent = []
        @composition.each do |r|
            species << r.sciname.to_s
            percent << r.percent.to_f
        end

        array = []
        for i in 0...count
            t = []
            t[0] = species[i]
            t[1] = percent[i]
            array.push(t)
        end
        @data = array
    end

    def manage
        #initialize query page parameters
        gram       = Echogram.all.order(created_at: :desc)
        @display   = gram.paginate(page: params[:page],per_page: 10)
        @count     = gram.count
        @text_spec = "All #{@count} items in the database."

        search_input   = params[:searching] 

        if search_input && search_input != ""
            gram       = Echogram.all.order(created_at: :desc)
            result       = gram.where("image_filename like ?", "%#{search_input}%")
            result_display(result)
            @text_spec = "Search input: \"#{search_input}\",  #{@count} items found."
        end
    end

    def delete_gram
        gramname = params[:item]
        composition_to_delete = Composition.where(echogram_name:gramname)
        if composition_to_delete.count > 0
            composition_to_delete.each do |r|
                r.destroy
            end
        end

        haul_to_delete = Haul.where(echogram_name:gramname)
        haul_to_delete.each do |r|
            r.destroy
        end

        gram_to_delete = Echogram.where(echogram_name:gramname)
        gram_to_delete.each do |r|
            image_file_dir = Rails.root + "public/images/" + r.image_filename

            if File.exist?(image_file_dir)
                File.delete(image_file_dir) 
            end
            
            r.destroy
        end

        flash[:success] = "Image deleted sucessfully."
        redirect_to manage_path
    end

    private
        require "set"

        #sort species dropdown list by frequency desc
        def species_order_by_freq_desc
            freq_h = Hash.new(0)
            MyComposition.all.each do |item|
                freq_h["#{item.sciname}"] += 1
            end

            sorted_h = freq_h.sort_by {|k,v| -v}
            sorted_arr = []
            sorted_h.each{ |key,value| sorted_arr << key }   
            return sorted_arr.insert(0,"All")
        end

        def percent_list

            ["All",">10%",">20%",">30%",">40%",">50%",">60%",
             ">70%",">80%",">90%",">99.9%"]
        end

        def avglength_list

            ["All",">10cm",">20cm",">30cm",">40cm",">50cm",
             ">60cm",">70cm",">80cm",">90cm",">100cm"]
        end

        def get_percent(key)

            percent_hash = {"All"=>0,">10%"=>0.1,">20%"=>0.2,">30%"=>0.3,
                            ">40%"=>0.4,">50%"=>0.5,">60%"=>0.6,">70%"=>0.7,
                            ">80%"=>0.8,">90%"=>0.9,">99.9%"=>0.999}

            per = percent_hash["#{key}"].to_f

        end

        def get_length(key)

            length_hash = {"All"=>0,">10cm"=>10,">20cm"=>20,">30cm"=>30,
                           ">40cm"=>40,">50cm"=>50,">60cm"=>60,">70cm"=>70,
                           ">80cm"=>80,">90cm"=>90,">100cm"=>100}
            
            len = length_hash["#{key}"].to_f

        end

        def gramname_collection(middle_obj)
            gram = Set.new
            middle_obj.each do |item|
                gram << item.gramname
            end
            return gram.to_a
        end

        def set_spec_text(species,percent,length)
            text = "Filter by:"
            if species != "All"
                text += " Species = #{species}"
            end
            if percent != "All"
                text += " Percent #{percent}"
            end
            if length != "All"
                text += " Length #{length}"
            end
            text += ". #{@count} items found."
            @text_spec = text
        end

        def result_display(result)
            @count = result.count
            @display = result.paginate(page: params[:page],per_page: 10)
        end

end