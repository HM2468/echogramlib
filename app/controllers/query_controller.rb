class QueryController < ApplicationController
    def querygram

        #enquery database to display on guery page
        column1 = "echograms.echogram_name"
        column2 = "echograms.record_date"
        column3 = "users.name"        
        sql = "SELECT #{column1},#{column2},#{column3}
               FROM Echograms INNER JOIN Users ON Echograms.user_id = Users.id"

        @display =  ActiveRecord::Base.connection.exec_query(sql)

        #paginate json: @display, per_page: 10

        #@display = Echogram.all

        #@test = @display.paginate(page: params[:page])

    end

    def uploadgram
    end
end
