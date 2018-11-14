# cocktails controller
class CocktailsController < ApplicationController
  before_action :set_cocktail, only: [:show, :edit, :update, :destroy]

  def index
    @cocktails = Cocktail.all
  end

  def show
    # before_action
  end

  def new
    @cocktail = Cocktail.new
  end

  def edit
    # before_action
  end

  def create
    @cocktail = Cocktail.new(cocktail_params)
    if @cocktail.save
      redirect_to @cocktail
    else
      render :new
    end
  end

  def update
    if @cocktail.update(cocktail_params)
      redirect_to @cocktail
    else
      render :edit
    end
  end

  def search
    if params[:search].blank?
      redirect_to(root_path, alert: 'Empty field!')
    else
      @cocktails = Cocktail.where("name ILIKE ?", "%#{params[:search]}%")
      render :index
    end
  end

  def destroy
    @cocktail.destroy
    redirect_to cocktails_url
  end

  private

  def set_cocktail
    @cocktail = Cocktail.find(params[:id])
  end

  def cocktail_params
    params.require(:cocktail).permit(:name, :photo)
  end
end
