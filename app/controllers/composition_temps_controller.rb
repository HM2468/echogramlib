class CompositionTempsController < ApplicationController

  before_action :logged_in_user, only: [:new,:create,:destroy]

  def new
    $gram_id = params[:gram_id]
    @composition_temp = CompositionTemp.new
    @all = specieslist
    @default = default_gram($gram_id) 
    @back_url = request.base_url + "/echogram_temps/#{$gram_id}"
  end

  def create
    @default = default_gram($gram_id)
    @all = specieslist
    @composition_temp = CompositionTemp.new(composition_temp_params)
    @back_url = request.base_url + "/echogram_temps/#{$gram_id}"

    if @composition_temp.save
      flash[:success] = "Added species compositions."
      redirect_to back_url($gram_id)
    else
      render 'new'
    end
  end

  def destroy
    comp_id = params[:comp_id]
    gram_id = params[:gram_id]
    @composition_temp = CompositionTemp.find(comp_id)
    @composition_temp.destroy  
    redirect_to back_url(gram_id)
    flash[:success] = "Species composition record deleted."
  end

  private
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

    def default_gram(id)
      gram = EchogramTemp.find(id)
      gramname = gram.echogram_name
      array = []
      array << gramname
      return array
    end

    def back_url(id)
      url = "/echogram_temps/#{id}"
    end

end
