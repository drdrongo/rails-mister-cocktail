class CocktailsController < ApplicationController
  before_action :find_doses, only: %i[show]

  def index
    if params[:query].present?
      @cocktails = Cocktail.flavor_search(params[:query]).collect.to_a
      cocktails_by_name = Cocktail.where('name ILIKE ?', "%#{params[:query]}%").to_a
      @cocktails += cocktails_by_name
    else
      @cocktails = Cocktail.all
    end
  end

  def show
    @cocktail = Cocktail.find(params[:id])
    @dose = Dose.new
  end

  def new
    @cocktail = Cocktail.new
  end

  def create
    @cocktail = Cocktail.new(cocktail_params)
    if @cocktail.save
      redirect_to cocktail_path(@cocktail)
    else
      render :new
    end
  end

  def edit
    @cocktail = Cocktail.find(params[:id])
  end

  def update
    @cocktail = Cocktail.find(params[:id])
    if @cocktail.update(cocktail_params)
      redirect_to cocktail_path(@cocktail)
    else
      render :edit
    end
  end

  private

  def find_doses
    @doses = Dose.where(cocktail_id: params[:id])
  end

  def cocktail_params
    params.require(:cocktail).permit(:name, :photo)
  end
end
