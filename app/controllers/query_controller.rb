class QueryController < ApplicationController
    
    def querygram

        #enquery database to display on guery page
        @display = Echogram.paginate(page: params[:page],per_page: 10)
        @count = @display.count
        @text_spec = "All #{@count} items in the database."

        #creat and initialize a species name array
        species_arr = []
        MyComposition.all.each do |item|
            species_arr << item.sciname
        end

        #sort species list by frequncy appeared DEC
        species_arr = []
        MyComposition.all.each do |item|
            species_arr << item.sciname
        end
        species_uniq = species_arr.uniq
        freq_h = Hash.new
        species_uniq.each do |r|
          freq_h["#{r}"] = 0
        end
        species_arr.each do |r|
          freq_h["#{r}"] += 1
        end
        sorted_h = freq_h.sort_by {|k,v| -v}
        sorted_arr = []
        sorted_h.each{ |key,value| sorted_arr << key }


        #initialize parameters to show in drop-down list in quergram.html.erb
        @species_list = sorted_arr.insert(0,"All")

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

        per = percent_hash["#{chosen_percent}"]
        len = length_hash["#{chosen_length}"]
                
        puts "======================================="
        puts per
        puts len
        puts "======================================="
        #query algorithm 
        if  chosen_species != "All" && chosen_length ==  "All" && chosen_percent ==  "All"
            temp = MyComposition.where(sciname:chosen_species)
            name = []
            temp.each do |item|
                name << item.gramname
            end
            gramname = name.uniq
            temp1 = Echogram.where(echogram_name:gramname)
            @count = temp1.count
            @display = temp1.paginate(page: params[:page],per_page: 10)
            @text_spec = "Filt by Species = #{chosen_species},
                        #{@count} records found."

        elsif chosen_species != "All" && chosen_length !=  "All" && chosen_percent ==  "All" 
            temp = MyComposition.where(sciname:chosen_species)
            temp1 = temp.where('avglength>?',length_hash["#{chosen_length}"])
            name = []
            temp.each do |item|
                name << item.gramname
            end
            gramname = name.uniq
            temp2 = Echogram.where(echogram_name:gramname)
            @count = temp2.count
            @display = temp2.paginate(page: params[:page],per_page: 10)
            @text_spec = "Species: #{chosen_species}, 
                            Mean length #{chosen_length},
                            #{@count} items found."

        elsif chosen_species != "All" && chosen_length ==  "All" && chosen_percent !=  "All" 
            temp = MyComposition.where(sciname:chosen_species)
            temp1 = temp.where('percent>?',percent_hash["#{chosen_percent}"])
            name = []
            temp.each do |item|
                name << item.gramname
            end
            gramname = name.uniq
            temp2 = Echogram.where(echogram_name:gramname)
            @count = temp2.count
            @display = temp2.paginate(page: params[:page],per_page: 10)
            @text_spec = "Species: #{chosen_species}, 
                            Percentage #{chosen_percent},
                            #{@count} items found."

        elsif chosen_species != "All" && chosen_length !=  "All" && chosen_percent !=  "All" 
            temp = MyComposition.where(sciname:chosen_species)
            temp1 = temp.where('percent>?',percent_hash["#{chosen_percent}"])
            temp2 = temp1.where('avglength>?',length_hash["#{chosen_length}"])
            name = []
            temp.each do |item|
                name << item.gramname
            end
            gramname = name.uniq
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
                    per = percent_hash["#{chosen_percent}"]
        len = length_hash["#{chosen_length}"]
            temp = MyComposition.where("'percent>?', per and
                                       'avglength>?',len")
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