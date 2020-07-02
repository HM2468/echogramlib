#to generate testing data in this file and 
# run === rails db:seed ==== to start run this file in rails 

# Create a main sample user.
generate_Admin = Proc.new{
  User.create!(name:  "Admin",
             email: "administrator@echogram.com",
             phone:  "07564123456",
             password:              "echo1234",
             password_confirmation: "echo1234",
             admin:     true)
}

# Generate a bunch of additional users.
generate_users = Proc.new{
  10.times do |n|
    name  = Faker::Name.name
    email = "example-#{n+1}@echogram.com"
    phone = Faker::PhoneNumber.cell_phone.to_s
    password = "password"
    User.create!(name:  name,
                email: email,
                phone: phone,
                password:              password,
                password_confirmation: password)
  end
}





#==============================================
#the work truely begins from here
#mind that the order of the codes below matters

=begin
    User.destroy_all

    generate_Admin.call
    generate_users.call
 


#
sql = "SELECT echograms.echogram_name as gramname ,species.scientific_name as sciname,
              species.english_name as engname, species.species_code as scode,
              compositions.percentage as percent, compositions.mean_length as avglength
       FROM echograms INNER JOIN compositions ON echograms.echogram_name = compositions.echogram_name
       INNER JOIN species ON compositions.species_code = species.species_code 
       ORDER BY echograms.echogram_name"
#
       
#test =  ActiveRecord::Base.connection.exec_query(sql)

test = MyComposition.all


puts test.class 
count = 0
test.each do |item|
  puts item.inspect
  count += 1
  puts "================#{count}==================="
end      

=end




temp = MyComposition.all.where(sciname: "Clupea harengus")

test = temp.where('percent>?',0.1 )



count = 0
test.each do |item|
  puts item.inspect
  count += 1
  puts "================#{count}==================="
end  


