class CompositionTempsController < ApplicationController
  before_action :set_composition_temp, only: [:show, :edit, :update, :destroy]


  def index
    @composition_temps = CompositionTemp.all
  end


  def show
  end


  def new
    @composition_temp = CompositionTemp.new
    @all = specieslist
    @gramname = gramlist
  end

 
  def edit
  end


  def create
    @all = specieslist
    @gramname = gramlist
    @composition_temp = CompositionTemp.new(composition_temp_params)

    if @composition_temp.save
      flash[:success] = "Added species compositions."
      redirect_to @composition_temp
    else
      render 'new'
    end


  end


  def update
  end

  def destroy
    @composition_temp.destroy
    respond_to do |format|
      format.html { redirect_to composition_temps_url, notice: 'Composition temp was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_composition_temp
      @composition_temp = CompositionTemp.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def composition_temp_params
      params.require(:composition_temp).permit(
          :echogram_name,
          :species, 
          :numbers, 
          :mean_length
        )
    end

    #select list in _form.html.erb
    def specieslist
      temp = Species.all
      array = []
      temp.each do |r|
        if r.english_name.present?
          array.push(r.english_name.to_s +  "/" + r.scientific_name.to_s)
        else   
          array.push("No common name/" + r.scientific_name.to_s)
        end
      end
      sorted = array.sort
      return sorted.insert(0,"Select species")
    end

    #select list in _form.html.erb
    def gramlist
      gram = EchogramTemp.all.where(user_id: session[:user_id])
      gramname = []
      gram.each do |r|
        gramname << r.echogram_name
      end
      uniqname = gramname.uniq
      return uniqname.insert(0,"Select echogram")
    end
end
