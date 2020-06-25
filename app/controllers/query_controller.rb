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

        #set the drop list value
        uploader = []
        uploadyear = []
        species  = []

        users = User.all
        users.each do |item|
            uploader << item.name
        end

        species_temp = Species.all
        species_temp.each do |item|
            species << item.scientific_name
        end

        year_temp = Echogram.all
        year_temp.each do |item|
            uploadyear << item.record_date.year
        end

        uploader.delete_at(0)
        @all_uploader = uploader.uniq
        @all_species = species.uniq
        @all_year = uploadyear.uniq

        @all_uploader.insert(0,"————")
        @all_species.insert(0,"————")
        @all_year.insert(0,"————")

        #pass value from view to controller
        chosen_year = params[:year]
        chosen_species = params[:species]
        chosen_uploader = params[:uploader]

        #further select value
        @by_year = MyQuery.all.where("extract(year from date) = ?",chosen_year).paginate(page: params[:page],per_page: 10)
        @by_uploader = MyQuery.all.where(username: chosen_uploader).paginate(page: params[:page],per_page: 10)
        @by_species =  FishKind.all.where(sciname: chosen_species).paginate(page: params[:page],per_page: 10)




















    end






    def uploadgram
    end
end
