class QueryController < ApplicationController
    def querygram

        #enquery database to display on guery page
        @display = MyGram.paginate(page: params[:page],per_page: 10)
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
        chosen_species_1 = params[:species_1]
        chosen_length = params[:avglength]

        chosen_species_2 = params[:species_2]
        chosen_percent   = params[:percent]
       
        #query algorithm 
        if  params[:species_1] && params[:avglength]

                if chosen_species_1 != "All" && chosen_length == "All"
                    temp = MyComposition.all.where(sciname:chosen_species_1)
                    @count = temp.count
                    @display = temp.paginate(page: params[:page],per_page: 10)
                    @text_spec = "Search by Species = #{chosen_species_1},
                                #{@count} records found."
                elsif chosen_species_1 != "All" && chosen_length != "All"
                    temp = MyComposition.all.where(sciname:chosen_species_1)
                    temp1 = temp.where('avglength>?',length_hash["#{chosen_length}"])
                    @count = temp1.count
                    @display = temp1.paginate(page: params[:page],per_page: 10)
                    @text_spec = "Species: #{chosen_species_1}, 
                                  Mean length #{chosen_length},
                                  #{@count} items found."
                else
                    @display
                    @text_spec
                    @count
                end

        elsif params[:species_2] && params[:percent]

                if chosen_species_2 != "All" && chosen_percent == "All"
                    temp = MyComposition.all.where(sciname:chosen_species_2)
                    @count = temp.count
                    @display = temp.paginate(page: params[:page],per_page: 10)
                    @text_spec = "Search by Species = #{chosen_species_2},
                                 #{@count} records found."
                elsif chosen_species_2 != "All" && chosen_percent != "All"
                    temp = MyComposition.all.where(sciname:chosen_species_2)
                    temp1 = temp.where('percent>?',percent_hash["#{chosen_percent}"])
                    @count = temp1.count
                    @display = temp1.paginate(page: params[:page],per_page: 10)
                    @text_spec = "Species: #{chosen_species_2}, 
                                  Percentage #{chosen_percent},
                                  #{@count} items found."
                else
                    @display
                    @text_spec
                    @count
                end

        else
                @display
                @text_spec
                @count
        end

    end

    def details
        temp   = params[:item].to_s       
        @gram = MyGram.all.where(gramname: temp)
        @dir   = "/images/" + temp
        @imagename = temp
        @composition = MyComposition.all.where(gramname: temp)



        puts "===================test begins======================"

        puts @gram.inspect
        puts "==================testing==========================="
        puts @composition.inspect

        puts "===================test ends======================"



    end





end
