class DosesController < ApplicationController
  def new
    @cocktail = Cocktail.find(params[:cocktail_id])
    @dose = Dose.new
    @collection = dose_collection(@cocktail)
  end

  def create
    @cocktail = Cocktail.find(params[:cocktail_id])
    @dose = Dose.new(dose_params)
    @dose.cocktail = @cocktail
    if @dose.save
      redirect_to cocktail_path(@cocktail)
    else
      @collection = dose_collection(@cocktail)
      render :new
    end
  end

  def destroy
    @dose = Dose.find(params[:id])
    @dose.destroy
    redirect_to cocktail_path(@dose.cocktail)
  end

  private

  def dose_params
    params.require(:dose).permit(:description, :ingredient_id)
  end

  def dose_collection(cocktail)
    collection = Ingredient.order(:name)
    cocktail.ingredients.each do |cocktail_ing|
      collection = collection.reject { |collection_ing| collection_ing == cocktail_ing }
    end
    collection
  end
end
