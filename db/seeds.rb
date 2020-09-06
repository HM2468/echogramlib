#to generate testing data in this file and 
# run === rails db:seed ==== to start run this file in rails 

# Create a main sample user.
generate_Admin = Proc.new{
  User.create!(name:  "Admin",
             email: "echogramlib@gmail.com",
             phone:  "075641234567",
             password:              "echogram1234",
             password_confirmation: "echogram1234",
             admin:     true)
}

#User.destroy_all
#generate_Admin.call

sql =  "SELECT compositions.echogram_name as gramname ,species.scientific_name as sciname,
        species.english_name as engname, species.species_code as scode,
        compositions.percentage as percent, compositions.mean_length as avglength,
        compositions.n_individuals as num
        FROM compositions INNER JOIN species ON compositions.species_code = species.species_code 
        ORDER BY compositions.echogram_name"


records = ActiveRecord::Base.connection.execute(sql)

puts "======================"
puts records.class
puts "======================"

