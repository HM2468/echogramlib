# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version 2.6.3

* Rails version 2.5.4

* database: postgresql 

*install postgresql client on Ubuntu can refer to 
https://computingforgeeks.com/install-postgresql-12-on-ubuntu/

*create your username,password in postgresql as is said above 

*create a databse and connect to it on your ubuntu  as is said above 
#this step may be somewhat tricky but I can not find an universal tutorial for you all
 for it has something to do with the pc environment.
 my suggestion is "if failed, google and try again"
 if still can't be successfully connected, try to seek help from Bruce, I am also a beginner
 

*edit config/database.yml file in rails app
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
* bundle install              #update all gems
* rails db:migrate            #create tables in your postgresql database
* rake bears:importdata       #import data from csv file to your database
* rails db:seed               #generate fake records in some tables for testing use

#well done now you should have all data in your database, you can check it by pgadmin4 or postgre client command line
#or rails console window. I recommand rails console for a quick check

* rails c                     #enter rails console window
* puts Echogram.all.inspect   #output all records of model/table Echogram, the same as Haul,User,etc
* q                           #quit from rails console
