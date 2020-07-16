class QueryController < ApplicationController
    
    def querygram

        #enquery database to display on guery page
        @display = Echogram.paginate(page: params[:page],per_page: 10)
        @count = @display.count
        @text_spec = "All #{@count} items in the database."

        #creat and initialize a species name array
        species = []
        species_temp = MyComposition.all
        species_temp.each do |item|
            species << item.sciname
        end
        
        #deduplicte the array
        species_uniq = species.uniq

        #initialize parameters to show in drop-down list in quergram.html.erb
        @species_list = species_uniq.insert(0,"All")

        @percent_list = ["All",">10%",">20%",">30%",">40%",">50%",">60%",
                            ">70%",">80%",">90%"]

        @avglength_list = ["All",">10cm",">20cm",">30cm",">40cm",">50cm",
                            ">60cm",">70cm",">80cm",">90cm",">100cm"]

        percent_hash = {"All"=>0,">10%"=>0.1,">20%"=>0.2,">30%"=>0.3,">40%"=>0.4,
                        ">50%"=>0.5,">60%"=>0.6,">70%"=>0.7,">80%"=>0.8,">90%"=>0.9}
        
        length_hash = {"All"=>0,">10cm"=>10,">20cm"=>20,">30cm"=>30,">40cm"=>40,">50cm"=>50,
                            ">60cm"=>60,">70cm"=>70,">80cm"=>80,">90cm"=>90,">100cm"=>100}
        
        #get parameters from front end 
        chosen_species = params[:species]
        chosen_length  = params[:avglength]
        chosen_percent = params[:percent] 
                
        #query algorithm 
        if  chosen_species != "All" && chosen_length ==  "All" && chosen_percent ==  "All"
            temp = MyComposition.all.where(sciname:chosen_species)
            gramname = []
            temp.each do |item|
                gramname << item.gramname
            end
            temp1 = Echogram.where(echogram_name:gramname)
            @count = temp1.count
            @display = temp1.paginate(page: params[:page],per_page: 10)
            @text_spec = "Filt by Species = #{chosen_species},
                        #{@count} records found."

        elsif chosen_species != "All" && chosen_length !=  "All" && chosen_percent ==  "All" 
            temp = MyComposition.all.where(sciname:chosen_species)
            temp1 = temp.where('avglength>?',length_hash["#{chosen_length}"])
            gramname = []
            temp1.each do |item|
                gramname << item.gramname
            end
            temp2 = Echogram.where(echogram_name:gramname)
            @count = temp2.count
            @display = temp2.paginate(page: params[:page],per_page: 10)
            @text_spec = "Species: #{chosen_species}, 
                            Mean length #{chosen_length},
                            #{@count} items found."

        elsif chosen_species != "All" && chosen_length ==  "All" && chosen_percent !=  "All" 
            temp = MyComposition.all.where(sciname:chosen_species)
            temp1 = temp.where('percent>?',percent_hash["#{chosen_percent}"])
            gramname = []
            temp1.each do |item|
                gramname << item.gramname
            end
            temp2 = Echogram.where(echogram_name:gramname)
            @count = temp2.count
            @display = temp2.paginate(page: params[:page],per_page: 10)
            @text_spec = "Species: #{chosen_species}, 
                            Percentage #{chosen_percent},
                            #{@count} items found."

        elsif chosen_species != "All" && chosen_length !=  "All" && chosen_percent !=  "All" 
            temp = MyComposition.all.where(sciname:chosen_species)
            temp1 = temp.where('percent>?',percent_hash["#{chosen_percent}"])
            temp2 = temp1.where('avglength>?',length_hash["#{chosen_length}"])
            gramname = []
            temp2.each do |item|
                gramname << item.gramname
            end
            temp3 = Echogram.where(echogram_name:gramname)
            @count = temp3.count
            @display = temp3.paginate(page: params[:page],per_page: 10)
            @text_spec = "Species: #{chosen_species}, 
                            Mean length #{chosen_length},
                            Percentage #{chosen_percent},
                            #{@count} items found."

        elsif chosen_species == "All" && chosen_length !=  "All" && chosen_percent ==  "All" 
            temp = MyComposition.where('avglength>?',length_hash["#{chosen_length}"])
            gram = []
            temp.each do |item|
                gram << item.gramname
            end
            findname = gram.uniq
            temp1 = Echogram.where(echogram_name:findname)
            @count = temp1.count
            @display = temp1.paginate(page: params[:page],per_page: 10)
            @text_spec = " Mean length #{chosen_length},
                           #{@count} items found."
        
        elsif chosen_species == "All" && chosen_length ==  "All" && chosen_percent !=  "All" 

            temp = MyComposition.where('percent>?',percent_hash["#{chosen_percent}"])
            gram = []
            temp.each do |item|
                gram << item.gramname
            end
            findname = gram.uniq
            temp1 = Echogram.where(echogram_name:findname)           
            @count = temp1.count
            @display = temp1.paginate(page: params[:page],per_page: 10)
            @text_spec = "Percentage #{chosen_percent},
                            #{@count} items found."

        elsif chosen_species == "All" && chosen_length != "All" && chosen_percent != "All" 
            temp = MyComposition.where('percent>?',percent_hash["#{chosen_percent}"])
            temp1 = temp.where('avglength>?',length_hash["#{chosen_length}"])
            gram = []
            temp.each do |item|
                gram << item.gramname
            end
            findname = gram.uniq
            temp2 = Echogram.where(echogram_name:findname)            
            @count = temp2.count
            @display = temp2.paginate(page: params[:page],per_page: 10)
            @text_spec = "Mean length #{chosen_length},
                            Percentage #{chosen_percent},
                            #{@count} items found."
        else
                @display
                @text_spec
                @count
        end

        
    end


    def details
        temp = params[:item] 


        temp1 = params[:item].first.to_s  
        @gram = Echogram.all.where(echogram_name: temp)
        @composition = MyComposition.where(gramname: temp)

        puts "===============test================"
        @composition.each do |r|
            puts r.inspect
        end
        puts "===============test================"


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

end