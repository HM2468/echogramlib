class EchogramTempsController < ApplicationController

  before_action :set_echogram_temp, only: [:show, :edit, :update, :destroy]

  def index
    @echogram_temps = EchogramTemp.all
  end

  def show
  end

  def new
    @echogram_temp = EchogramTemp.new
  end

  def edit
  end

  def create
    temp = echogram_temp_params
    #EchogramTemp.destroy_all
    @echogram_temp = EchogramTemp.new(echogram_temp_params)

    if temp[:gram]
        lat = temp[:latitude]
        long = temp[:longitude]
        filename = temp[:gram].original_filename.to_s
        gramname = filename[0,24]
        freq = filename[25,4].to_i
        userid = 8
    else
       @echogram_temp.errors
    end
   
    @echogram_temp.update(
      echogram_name:  gramname,
      image_filename: filename,
      frequency:      freq,
      user_id:        userid
    )

    respond_to do |format|
      if @echogram_temp.save
        format.html { redirect_to @echogram_temp, notice: 'Echogram was successfully created.' }
        format.json { render :show, status: :created, location: @echogram_temp }
      else
        format.html { render :new }
        format.json { render json: @echogram_temp.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    
    respond_to do |format|
      if @echogram_temp.update(echogram_temp_params)
        format.html { redirect_to @echogram_temp, notice: 'Echogram was successfully updated.' }
        format.json { render :show, status: :ok, location: @echogram_temp }
      else
        format.html { render :edit }
        format.json { render json: @echogram_temp.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @echogram_temp.destroy
    @echogram_temp.gram.purge
    respond_to do |format|
      format.html { redirect_to echogram_temps_url, notice: 'Echogram temp was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private

    def set_echogram_temp
      @echogram_temp = EchogramTemp.find(params[:id])
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
