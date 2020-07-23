
##this rake file is to import data from CSV file
#run in rails app with $ rake data:importdata


file_hauls   = "lib/assets/hauls.csv"
file_species = "lib/assets/species.csv"
file_compositions = "lib/assets/compositions.csv"
file_echograms = "lib/assets/echograms.csv"


#hauls import
hauls_import = Proc.new{
  count_row = 0  
  CSV.foreach(file_hauls,
              headers: true,
              skip_blanks: true,
              skip_lines: /^(?:,\s*)+$/) do |row|
                count_row += 1
                puts "Imported hauls row #{count_row}"
                #import data from csv file
                Haul.create!(
                  id:                row[0].to_i,
                  echogram_name:     row[1],
                  fish_date:         row[2].to_date,
                  strt_fish_time:    row[3],
                  stp_fish_time:     row[4],
                  strt_fish_lat:     row[5].to_f,
                  stp_fish_lat:      row[6].to_f,
                  strt_fish_long:    row[7].to_f,
                  stp_fish_long:     row[8].to_f,
                  strt_fish_depth:   row[9].to_f,
                  stp_fish_depth:    row[10].to_f,
                  bottom_depth:      row[11].to_f
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
                puts "Imported species row #{count_row}"
                #import data from csv file
                Species.create!(
                  species_code:        row[0].to_s,
                  scientific_name:     row[1].to_s,
                  english_name:        row[2].to_s,
                  image_filename:      row[3].to_s
                )
               end
  puts "============ENDS============="
}


#echograms import
echograms_import = Proc.new{
  count_row = 0  
  CSV.foreach(file_echograms,
              headers: true,
              skip_blanks: true,
              skip_lines: /^(?:,\s*)+$/) do |row|
                count_row += 1
                puts "Imported echograms row #{count_row}"
                #import data from csv file
                Echogram.create!(
                  haul_id:              row[0].to_i,
                  echogram_name:        row[1].to_s,
                  frequency:            row[2].to_i,
                  image_filename:       row[3].to_s,
                  user_id:              row[4].to_i,
                  latitude:             row[5].to_f,
                  longitude:            row[6].to_f
                )
               end
  puts "============ENDS============="
}

#compositions import
comopositions_import = Proc.new{
  count_row = 0  
  CSV.foreach(file_compositions,
              headers: true,
              skip_blanks: true,
              skip_lines: /^(?:,\s*)+$/) do |row|
                count_row += 1
                puts "Imported compositions row #{count_row}"
                #import data from csv file
                Composition.create!(
                  echogram_name:        row[0].to_s,
                  species_code:         row[2].to_s,
                  n_individuals:        row[3].to_i,
                  percentage:           row[5].to_f,
                  mean_length:          row[6].to_f
                )
               end
  puts "============ENDS============="
}

#data import from here
require 'csv'
require 'date'
namespace :data do
  desc "Import data from csv files"
  task importdata: :environment do

    Composition.destroy_all
    Species.destroy_all
    Haul.destroy_all
    Echogram.destroy_all

    echograms_import.call
    hauls_import.call
    species_import.call
    comopositions_import.call

  end
end

