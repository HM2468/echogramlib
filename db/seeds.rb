#to generate testing data in this file and 
# run === rails db:seed ==== to start run this file in rails 

# Create a main sample user.
generate_Admin = Proc.new{
  User.create!(name:  "Admin",
             email: "echogramlib@gmail.com",
             phone:  "075641234567",
             password:              "echogram2020",
             password_confirmation: "echogram2020",
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

#generate_Admin.call
#generate_users.call



#==============================================
#the work truely begins from here
#mind that the order of the codes below matters
=begin
gram = EchogramTemp.all.where(user_id: 12)
gramname = []
gram.each do |r|
  gramname << r.echogram_name
end
uniqname = gramname.uniq
test = uniqname.insert(0,"Select echogram")

count = 0
test.each do |item|
  puts item.inspect
  count += 1
  puts "================#{count}==================="
end      
=end
gram = EchogramTemp.all
count = gram.count
if count > 0
  gram.each do |item|
    item.update(editable:true)
  end
end



