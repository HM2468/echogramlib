class UploadController < ApplicationController
    def myupload
        temp = EchogramTemp.all.where(user_id: session[:user_id])
        #@display = temp.paginate(page: params[:page],per_page: 10)
        @echogram_temp = temp.first
    end
  
end
