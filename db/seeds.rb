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

temp = MyComposition.where(sciname: "Clupea harengus")
temp1 = temp.where('avglength>?',30)
name = []
temp1.each do |item|
    name << item.gramname
end
gramname = name.uniq
test = Echogram.where(echogram_name:gramname)


puts test.class 
count = 0
test.each do |item|
  puts item.inspect
  count += 1
  puts "================#{count}==================="
end      



