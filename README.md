# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version 2.6.3

* Rails version 2.5.4

* database: postgresql 

**install postgresql client on Ubuntu can refer to 
https://computingforgeeks.com/install-postgresql-12-on-ubuntu/

**create your username,password in postgresql as is said above 

**create a databse and connect to it on your ubuntu  as is said above 
#this step may be somewhat tricky but I can not find an universal tutorial for you all
 for it has something to do with the pc environment.
 my suggestion is "if failed, google and try again"
 if still can't be successfully connected, try to seek help from Bruce, I am also a beginner
 

**edit config/database.yml file in rails app

    development:
      host: localhost        
      adapter: postgresql
      encoding: unicode
      database: echogramlib      #change to your own created in your postgresql client
      username: postgres         #default value canbe changed to your own 
      password: miao             #change to your own set by yourself
      pool: 5
      timeout: 5000

    test:                        #keep this part the same as above of "development:"
      host: localhost
      adapter: postgresql
      encoding: unicode
      database: echogramlib
      username: postgres
      password: miao
      pool: 5
      timeout: 5000
      
    production:                #just ignore this part, it is only used for deploy on Heroku or other server             
      host: 
      adapter: postgresql
      encoding: unicode
      database: echogramlib
      username: postgres
      password: miao
      pool: 5
      timeout: 5000
    
#run commands as below step by step in your command line
      $ bundle install              #update all gems
      $ rails db:migrate            #create tables in your postgresql database
      $ rails db:seed               #generate fake records in some tables for testing use
      $ rake bears:importdata       #import data from csv file to your database


#well done now you should have all data in your database, you can check it by pgadmin4 or postgre client command line
#or rails console window. I recommand rails console for a quick check

      $ rails c                     #enter rails console window
      $ puts Echogram.all.inspect   #output all records of model/table Echogram, the same as Haul,User,etc
      $ q                           #quit from rails console

To update the database run git pull to make sure that your codes are the newest version, then run 
      $ bundle install              #install new gem 
      $ bundle update               #update all gems 
      $ rails db:migrate            #migrations on modifying database
      $ rake bears:importdata       #import newest data from csv file to psql


**Copy all echogram images into public/image, large file is not uploaded into github, you have to included it manually.

**Under file view/query/details.html.erb:

    <script async defer
        src="https://maps.googleapis.com/maps/api/js?key=<%= Google_Map_API%>&callback=initMap">
    </script>

    replace "<%= Google_Map_API%>" with your own google API key, to get one, refer:
    https://developers.google.com/maps/documentation/javascript/get-api-key

    then the google map can be displayed normally.
    Google API key should not be included in a public github repo.


########## DEPLOY ON GOOGLE CLOUD ###########
      1.Create a virtue machine/Google engine on google cloud platform. 
        Choose the OS system as Ubuntu and the area as european
      2.Create an guest acoount in this machine and install Ruby on Rails 
        environment under this account. Ruby version and Rails version 
        should be exactly the same as specified above.
        PS: never install under root account, it would cause mounts of problems.
      3.Create a file to hold the codes. For example, my Ubuntu user account is 
        huangmiao, I create home/huangmiao/codes to hold all the codes 
        $ cd  home/huangmiao/codes 
        $ git pull https://github.com/HM2468/echogramlib.git 
      5.install psql on this virtue machine as specified above
      6.$ cd home/huangmiao/codes/echogramlib
        $ bundle install
        $ rails db:migrate
        $ rails db:seed
        $ rake bears:importdata  
        $ rails s -b 0.0.0.0 -p 3000
          Now the website can be accessed at http://xx.xx.xx.xx:3000/
          xx.xx.xx.xx is the external IP of your Goole virtue machine
      7. The most important and usefull step is to make your google cloud drive as a 
        hard disk in your virtue machine. that means your virtue machine can write and 
        read to the Google cloud drive directly. It would make it possible to utilize large 
        files on virtue machine for free.
        All details can be found at https://github.com/rclone/rclone
