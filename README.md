# README

## System Requirements 

* Ruby version 2.6.3
* Rails version 5.2.4
* database: postgresql  

## How to set up PostgreSQL on Ubuntu 

**Install postgresql client on Ubuntu can refer to**
https://computingforgeeks.com/install-postgresql-12-on-ubuntu/

**Create your username,password in postgresql as is said above** 

**Create a databse and connect to it on your ubuntu  as is said above**
This step may be somewhat tricky but my suggestion is "if failed, google and try again" :sunglasses:

 

**Edit _config/database.yml_ file in rails app**
```
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
    
  production:                 #just ignore this part, it is only used for deploy on Heroku or other server             
    host: 
    adapter: postgresql
    encoding: unicode
    database: echogramlib
    username: postgres
    password: miao
    pool: 5
    timeout: 5000
```    

**Now run commands as below step by step in your command line**
```
    $ bundle install              #update all gems
    $ rails db:migrate            #create tables in your postgresql database
    $ rails db:seed               #generate fake records in some tables for testing use
    $ rake  data:importdata       #import data from csv file to your database
```


Well done now you should have all data in your database, you can check it by pgadmin4 or postgre client command line
or rails console window. I recommand rails console for a quick check
```
    $ rails c                     #enter rails console window
    $ puts Echogram.all.inspect   #output all records of model/table Echogram, the same as Haul,User,etc
    $ q                           #quit from rails console
```

**To update the database run `git pull` to make sure that your codes are the newest version, then run**
```
    $ bundle install              #install new gem 
    $ bundle update               #update all gems 
    $ rails db:migrate            #migrations on modifying database
    $ rake data:importdata        #import newest data from csv file to psql
```

## How to show images 

**Copy all echogram images into _public/image_, large file is not uploaded into GitHub, you have to included it manually.**

##  How to show Google Maps 

Under file _view/query/details.html.erb_:

  <script async defer
      src="https://maps.googleapis.com/maps/api/js?key=<%= Google_Map_API%>&callback=initMap">
  </script>

  replace "<%= Google_Map_API%>" with your own google API key, to get one, refer:
  https://developers.google.com/maps/documentation/javascript/get-api-key

  #then the google map can be displayed normally.
  #Google API key should not be included in a public github repo.

## How to upload images 

To upload images, you need to install _imagemagic_ on your dev environmen. Here are methods for both mac OS and Ubuntu:

You need to install _libmagickwand-dev_ in order to successfully complete the _rmagick_ gem. 
Following command will do the job for you:
```
  On ubuntu:
  $ sudo apt-get install libmagickwand-dev
  On MacOS:
  $ brew install imagemagick 
```

## How to Deploy on Google Cloud 

  1. Create a virtue machine/Google engine on Google Cloud platform. 
     Choose the OS system as Ubuntu and the area as european
  2. Create an guest acoount in this machine and install Ruby on Rails 
     environment under this account. Ruby version and Rails version 
     should be exactly the same as specified above.
     PS: never install under root account, it would cause mounts of problems.
  3. Create a file to hold the codes. For example, my Ubuntu user account is 
     _huangmiao_, I create _home/huangmiao/codes_ to hold all the codes
     ``` 
     $ cd  home/huangmiao/codes 
     $ git pull https://github.com/HM2468/echogramlib.git 
     ```
  4. Install _psql_ on this virtue machine as specified above
  5. Then run 
     ```
     $ cd home/huangmiao/codes/echogramlib
     $ bundle install
     $ rails db:migrate
     $ rails db:seed
     $ rake data:importdata  
     $ rails s -b 0.0.0.0 -p 3000
     ```
  6. Now the website can be accessed at http://xx.xx.xx.xx:3000/ where 
     xx.xx.xx.xx is the external IP of your Goole virtue machine
  7. The most important and usefull step is to make your Google Cloud drive as a 
     hard disk in your virtue machine. That means your virtue machine can write and 
     read to the Google Cloud drive directly. It would make it possible to utilize large 
     files on virtue machine for free.
     All details can be found at https://github.com/rclone/rclone
    
## How to run the testing

**Using RSpec testing framework to Ruby on Rails**
1. If you want run all the test :
   run commands "rspec" on the terminal .
2. If you want specific test :
   run commands "rspec + the path of test file  " on the terminal . 
   For example:"rspec /home/ubuntu/environment/echogramlib/spec/controllers/users_controller_spec.rb"
 
