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
    email = "example-#{n+1}@echo.com"
    phone = Faker::PhoneNumber.cell_phone.to_s
    password = "password"
    User.create!(name:  name,
                email: email,
                phone: phone,
                password:              password,
                password_confirmation: password)
  end
}

# Genarate echogram information
generate_echogram = Proc.new{
  users = []
  user_record = User.all
  user_record.each do |i|
    users << i.id.to_i
  end  
  users.delete_at(0)
  user_num = users.length
  counts = 0

  haul_record = Haul.all
  haul_record.each do |i|
    name = i.echogramName.to_s
    fdate = i.fishDate
    ftime = i.strtFishTime.to_s
    latitude = ((i.strtFishLat + i.stpFishLat)/2).round(5)
    longitude = ((i.strtFishLong + i.stpFishLong)/2).round(5)
    freq = 38
    userid = users[counts%user_num]
    counts += 1
    #=============puts status===========
    print  name.to_s + " "
    print  fdate.to_s + " "
    print  ftime.to_s + " "
    print  latitude.to_s + " "
    print  longitude.to_s + " "
    print  freq.to_s + " "
    print  userid.to_s + " "
    puts

    Echogram.create!( 
      echogramName: name,
      recordDate: fdate,
      recordTime: ftime,
      latitude: latitude,
      longitude: longitude,
      frequency: freq,
      user_id: userid
    )
  end

}


# Genarate species composition
generate_species_composition = Proc.new{

    name = []
    gram = Echogram.all
    gram.each do |i|
      name << i.echogramName.to_s
    end

    name.each{|item|
              speciesNo = []
              record = Species.all
              record.each do |i|
                speciesNo << i.speciesCode.to_s
              end
              index1 = rand(40)
              code1 = speciesNo[index1]
              speciesNo.delete_at(index1)
              index2 = rand(39)
              code2 = speciesNo[index2]
              speciesNo.delete_at(index2)
              index3 = rand(38)
              code3 = speciesNo[index3]
              
              p0 = 100

              p21 = rand(100)
              p22 = 100 - p21

              p31 = rand(49)
              p32 = rand(49)
              p33 = 99 - p31 - p32

              length = rand(10) + 10
              echogramName = item
              speciesAmount = rand(3) + 1
              case speciesAmount
                when 1
                  print item.to_s + " "
                  print code1.to_s + " "
                  print p0.to_s + " "
                  print length.to_s + " "
                  puts " "

                  Composition.create!(
                    speciesCode: code1,
                    percentage: p0,
                    meanLength: length,
                    echogramName: item
                  )

                when 2 
                  print item.to_s + " "
                  print code1.to_s + " "
                  print p21.to_s + " "
                  print length.to_s + " "
                  puts " "

                  Composition.create!(
                    speciesCode: code1,
                    percentage: p21,
                    meanLength: length,
                    echogramName: item
                    )

                  print item.to_s + " "
                  print code2.to_s + " "
                  print p22.to_s + " "
                  print length.to_s + " "
                  puts " "

                  Composition.create!(
                    speciesCode: code2,
                    percentage: p22,
                    meanLength: length,
                    echogramName: item
                    )
                when 3
                  print item.to_s + " "
                  print code1.to_s + " "
                  print p31.to_s + " "
                  print length.to_s + " "
                  puts " "

                  Composition.create!(
                    speciesCode: code1,
                    percentage: p31,
                    meanLength: length,
                    echogramName: item
                  )

                  print item.to_s + " "
                  print code2.to_s + " "
                  print p32.to_s + " "
                  print length.to_s + " "
                  puts " "

                  Composition.create!(
                    speciesCode: code2,
                    percentage: p32,
                    meanLength: length,
                    echogramName: item
                  )
                  print item.to_s + " "
                  print code3.to_s + " "
                  print p33.to_s + " "
                  print length.to_s + " "
                  puts " "
                  Composition.create!(
                    speciesCode: code3,
                    percentage: p33,
                    meanLength: length,
                    echogramName: item
                  )
                else 
                  puts "error"
              end
    }


}


#==============================================
#the work truely begins from here
#mind that the order of the codes below matters

generate_Admin.call
generate_users.call
generate_echogram.call
generate_species_composition.call

