
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
                  echogram_name:     row[0],
                  fish_date:         row[1].to_date,
                  strt_fish_time:    row[2],
                  stp_fish_time:     row[3],
                  strt_fish_lat:     row[4].to_f,
                  stp_fish_lat:      row[5].to_f,
                  strt_fish_long:    row[6].to_f,
                  stp_fish_long:     row[7].to_f,
                  strt_fish_depth:   row[8].to_f,
                  stp_fish_depth:    row[9].to_f,
                  bottom_depth:      row[10].to_f
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
                  species_code:        row[0].to_s,
                  scientific_name:     row[1],
                  english_name:        row[2],
                  french_name:         row[3],
                  spanish_name:        row[4]
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

