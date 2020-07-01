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
    Echogram.destroy_all
    Composition.destroy_all

    generate_Admin.call
    generate_users.call
    generate_echogram.call
    generate_composition.call
    generate_fish_speed.call



sql = "SELECT echograms.echogram_name,echograms.record_date,users.name
       FROM Echograms INNER JOIN Users ON Echograms.user_id = Users.id
       ORDER BY users.name"

sql = "SELECT echograms.echogram_name AS gramname,echograms.record_date AS date,
              echograms.record_time AS time, echograms.latitude AS lat,
              echograms.longitude AS long, echograms.frequency AS freq,
              echograms.user_id AS userid, users.name AS username,
              hauls.fish_speed AS speed
       FROM users INNER JOIN echograms ON echograms.user_id = users.id 
       INNER JOIN hauls ON echograms.echogram_name = hauls.echogram_name
       ORDER BY users.name"


#
       
test =  ActiveRecord::Base.connection.exec_query(sql)


test = MyQuery.all


puts test.class 
count = 0
test.each do |item|
  puts item.inspect
  count += 1
  puts "================#{count}==================="
end

=end


sql = "SELECT echograms.echogram_name AS gramname,echograms.latitude AS lat,
              echograms.longitude AS long,hauls.fish_date AS date
       FROM echograms INNER JOIN hauls ON echograms.echogram_name = hauls.echogram_name 
       ORDER BY echograms.echogram_name"
#
       
test =  ActiveRecord::Base.connection.exec_query(sql)

#test = MyQuery.all

puts test.class 
count = 0
test.each do |item|
  puts item.inspect
  count += 1
  puts "================#{count}==================="
end