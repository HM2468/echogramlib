class QueryController < ApplicationController
    def querygram

        new_gram_species_hash = Proc.new{
            sql = "SELECT echograms.echogram_name AS gram ,species.scientific_name as species
                    FROM echograms INNER JOIN compositions ON echograms.echogram_name = compositions.echogram_name
                    INNER JOIN species ON compositions.species_code = species.species_code 
                    ORDER BY echograms.echogram_name"
            gram_species =  ActiveRecord::Base.connection.exec_query(sql)

            #create and initialize a hash
            #hash key is echogram_name
            #initial hash value is 0
            @h = Hash.new
            gramname = Echogram.all
            gramname.each do |r|
                temp = r.echogram_name.to_s
                @h["#{temp}"] = "0"
            end

            #assign species name to hash value
            gram_species.each do |r|
                #get echogram_name as hash key
                gram = r['gram'].to_s
                #get species name as hash value
                species = r['species'].to_s
                if @h["#{gram}"] == "0"
                    @h["#{gram}"] = "#{species}"
                else
                    @h["#{gram}"] += ",#{species}"
                end
            end
        }

        #enquery database to display on guery page

        @display = MyQuery.paginate(page: params[:page],per_page: 10)
        @all_species = Species.all
        new_gram_species_hash.call

    end

    def uploadgram
    end
end
