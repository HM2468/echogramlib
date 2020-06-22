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

# Genarate echogram information
generate_echogram = Proc.new{
  users = []
  user_record = User.all
  user_record.each do |item|
    users << item.id.to_i
  end  
  users.delete_at(0)
  user_num = users.length
  counts = 0

  haul_record = Haul.all
  haul_record.each do |item|
    name = item.echogram_name.to_s
    fdate = item.fish_date
    ftime = item.strt_fish_time.to_s
    latitude = ((item.strt_fish_lat + item.stp_fish_lat)/2).round(5)
    longitude = ((item.strt_fish_long + item.stp_fish_long)/2).round(5)
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
      echogram_name:      name,
      record_date:        fdate,
      record_time:        ftime,
      latitude:           latitude,
      longitude:          longitude,
      frequency:          freq,
      user_id:            userid
    )
  end

}


# Genarate species composition
generate_composition = Proc.new{

    name = []
    gram = Echogram.all
    gram.each do |item|
      name << item.echogram_name.to_s
    end


    name.each{|item|
              speciesNo = []
              record = Species.all
              record.each do |r|
                speciesNo << r.species_code.to_s
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
              echogram_name = item
              speciesAmount = rand(3) + 1

              puts "======================"
              puts speciesAmount


              case speciesAmount
                when 1
                  print item.to_s + " "
                  print code1.to_s + " "
                  print p0.to_s + " "
                  print length.to_s + " "
                  puts " "

                  Composition.create!(
                    species_code:       code1,
                    percentage:         p0,
                    mean_length:        length,
                    echogram_name:      item
                  )

                when 2 
                  print item.to_s + " "
                  print code1.to_s + " "
                  print p21.to_s + " "
                  print length.to_s + " "
                  puts " "

                  Composition.create!(
                    species_code:       code1,
                    percentage:         p21,
                    mean_length:        length,
                    echogram_name:      item
                    )

                  print item.to_s + " "
                  print code2.to_s + " "
                  print p22.to_s + " "
                  print length.to_s + " "
                  puts " "

                  Composition.create!(
                    species_code:      code2,
                    percentage:        p22,
                    mean_length:       length,
                    echogram_name:     item
                    )
                when 3
                  print item.to_s + " "
                  print code1.to_s + " "
                  print p31.to_s + " "
                  print length.to_s + " "
                  puts " "

                  Composition.create!(
                    species_code:      code1,
                    percentage:        p31,
                    mean_length:       length,
                    echogram_name:     item
                  )

                  print item.to_s + " "
                  print code2.to_s + " "
                  print p32.to_s + " "
                  print length.to_s + " "
                  puts " "

                  Composition.create!(
                    species_code:      code2,
                    percentage:        p32,
                    mean_length:       length,
                    echogram_name:     item
                  )
                  print item.to_s + " "
                  print code3.to_s + " "
                  print p33.to_s + " "
                  print length.to_s + " "
                  puts " "
                  Composition.create!(
                    species_code:       code3,
                    percentage:         p33,
                    mean_length:        length,
                    echogram_name:      item
                  )
                else 
                  puts "error"
              end
    }


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
=end



sql = "SELECT echograms.echogram_name,echograms.record_date,users.name
       FROM Echograms INNER JOIN Users ON Echograms.user_id = Users.id
       ORDER BY users.name"

sql = "SELECT echograms.echogram_name,echograms.record_date,users.name,species.english_name
       FROM Users INNER JOIN echograms ON echograms.user_id = users.id 
       INNER JOIN compositions ON echograms.echogram_name = compositions.echogram_name
       INNER JOIN species ON compositions.species_code = species.species_code 
       ORDER BY users.name"


sql = "SELECT echograms.echogram_name,echograms.record_date,users.name,species.english_name
       FROM Users INNER JOIN echograms ON echograms.user_id = users.id 
       INNER JOIN compositions ON echograms.echogram_name = compositions.echogram_name
       INNER JOIN species ON compositions.species_code = species.species_code 
       ORDER BY users.name"



##############################################       #
##############################################

#
       
test =  ActiveRecord::Base.connection.exec_query(sql)



#display = MyQuery.all
##puts display.class


sql1 = "SELECT echograms.echogram_name AS gram ,species.scientific_name as species
        FROM echograms INNER JOIN compositions ON echograms.echogram_name = compositions.echogram_name
        INNER JOIN species ON compositions.species_code = species.species_code 
        ORDER BY echograms.echogram_name"
gram_species =  ActiveRecord::Base.connection.exec_query(sql1)

#create and initialize a hash
#hash key is echogram_name
#initial hash value is 0
@h = Hash.new
gramname = Echogram.all
gramname.each do |r|
  temp = r.echogram_name.to_s
  @h["#{temp}"] = "0"
end

#assign species name to hash value
gram_species.each do |r|
  #get echogram_name as hash key
  gram = r['gram'].to_s
  #get species name as hash value
  species = r['species'].to_s
  if @h["#{gram}"] == "0"
    @h["#{gram}"] = "#{species}"
  else
    @h["#{gram}"] += ",#{species}"
  end
end

@h.each do |r|
  puts r.inspect
end

