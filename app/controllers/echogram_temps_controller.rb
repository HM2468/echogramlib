class EchogramTempsController < ApplicationController

  before_action :logged_in_user, only: [:new,:create,:index,:show,:destroy]
  before_action :set_echogram_temp, only: [:update, :destroy]
  before_action :display_composition, only: [:show]

  def index
    @echogram_temps = EchogramTemp.all
    temp = EchogramTemp.all.where(user_id: session[:user_id])
    sorted = temp.order(created_at: :desc)
    @display = sorted.paginate(page: params[:page],per_page: 10)
  end

  def show
  end

  def new
    @echogram_temp = EchogramTemp.new
  end

  def create
    temp = echogram_temp_params
    @echogram_temp = EchogramTemp.new(echogram_temp_params)

    if temp[:gram]
        lat = temp[:latitude]
        long = temp[:longitude]
        filename = temp[:gram].original_filename.to_s
        gramname = filename[0,24]
        freq = filename[25,4].to_i
        userid = session[:user_id] 
    else
        @echogram_temp.errors
    end
   
    @echogram_temp.update(
      echogram_name:  gramname,
      image_filename: filename,
      frequency:      freq,
      user_id:        userid,
      editable:       true
    )

    if @echogram_temp.save
      flash[:success] = "Image successfully uploaded."
      redirect_to echogram_temps_url
    else
      render 'new'
    end

  end

  def destroy
    name = @echogram_temp.echogram_name
    comp = CompositionTemp.where(echogram_name:name)
    num = comp.count

    #delete attached image file
    if num > 0
      comp.destroy_all
    end

    #delete associated species compositions
    @echogram_temp.gram.purge

    #delete echogram_temps table record
    @echogram_temp.destroy
    redirect_to echogram_temps_url
    flash[:success] = "Echogram temp was successfully deleted."
  end

  private
    def set_echogram_temp
      @echogram_temp = EchogramTemp.find(params[:id])
    end

    def display_composition
      temp = set_echogram_temp
      name = temp.echogram_name
      @composition = CompositionTemp.all.where(echogram_name:name)
    end

    def echogram_temp_params
      params.require(:echogram_temp).permit(
        :image_filename, 
        :latitude, 
        :longitude, 
        #Allow uploading a single file
        :gram,       
        # Allow destroying a gram
        gram_attachment_attributes: [:id, :_destroy] 
      )
    end
end
