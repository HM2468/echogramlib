class QueryController < ApplicationController
    def querygram

        #enquery database to display on guery page

        #@display =  MyQuery.all
        @display = MyQuery.paginate(page: params[:page],per_page: 15)

    end

    def uploadgram
    end
end
