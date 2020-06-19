
##this rake file is to import data from CSV file
#run in rails app with $ rake bears:importdata


file_hauls = "lib/assets/haul.csv"
file_species = "lib/assets/species.csv"


#hauls import
hauls_import = Proc.new{
  count_row = 0  
  CSV.foreach(file_hauls,
              headers: true,
              skip_blanks: true,
              skip_lines: /^(?:,\s*)+$/) do |row|
                count_row += 1
                puts "Imported row #{count_row}"
                #import data from csv file
                Haul.create!(
                  echogramName: row[0],
                  fishDate: row[1].to_date,
                  strtFishTime: row[2],
                  stpFishTime: row[3],
                  strtFishLat: row[4].to_f,
                  stpFishLat: row[5].to_f,
                  strtFishLong: row[6].to_f,
                  stpFishLong: row[7].to_f,
                  strtFishDepth: row[8].to_f,
                  stpFishDepth: row[9].to_f,
                  bottomDepth: row[10].to_f
                )
               end
  puts "============ENDS============="
}

#species import
species_import = Proc.new{
  count_row = 0  
  CSV.foreach(file_species,
              headers: true,
              skip_blanks: true,
              skip_lines: /^(?:,\s*)+$/) do |row|
                count_row += 1
                puts "Imported row #{count_row}"
                #import data from csv file
                Species.create!(
                  speciesCode: row[0].to_s,
                  scientificName: row[1],
                  englishName: row[2],
                  frenchName: row[3],
                  spanishName: row[4]
                )
               end
  puts "============ENDS============="
}


#data import from here
require 'csv'
require 'date'
namespace :bears do
  desc "Import data from goods.csv"
  task importdata: :environment do

    Haul.destroy_all
    Species.destroy_all

    hauls_import.call
    species_import.call

  end
end

