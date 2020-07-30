class QueryController < ApplicationController
    
    def querygram

        #initialize guery page parameters
        gram       = Echogram.all.order(created_at: :desc)
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

        per = get_percent(chosen_percent)
        len = get_length(chosen_length)


        #query algorithm 
       if  chosen_species || chosen_length || chosen_percent
        
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
                temp1 = temp.where('avglength>?',len)
                name = []
                temp1.each do |item|
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
                temp1 = temp.where('percent>?',per)
                name = []
                temp1.each do |item|
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
                temp1 = temp.where('percent>?',per)
                temp2 = temp1.where('avglength>?',len)
                name = []
                temp2.each do |item|
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
                temp = MyComposition.where('avglength>?',len)
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

                temp = MyComposition.where('percent>?',per)
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

                temp = MyComposition.where('percent>?',   per)
                temp1 = temp.where('avglength>?', len)
                gram = []
                temp1.each do |item|
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

    private

        def species_order_by_freq_desc
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


end