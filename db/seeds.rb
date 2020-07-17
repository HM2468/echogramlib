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
temp = MyComposition.where('avglength>?',70)
gram = []
temp.each do |item|
  gram << item.gramname
end
findname = gram.uniq

test = Echogram.where(echogram_name:findname)

test = MyComposition.all


puts test.class 
count = 0
test.each do |item|
  puts item.inspect
  count += 1
  puts "================#{count}==================="
end      

=end

species_arr = []
MyComposition.all.each do |item|
    species_arr << item.sciname
end
species_uniq = species_arr.uniq
freq_h = Hash.new
species_uniq.each do |r|
  freq_h["#{r}"] = 0
end
species_arr.each do |r|
  freq_h["#{r}"] += 1
end
sorted_h = freq_h.sort_by {|k,v| -v}
sorted_arr = []
sorted_h.each{ |key,value| sorted_arr << key }
puts sorted_arr

