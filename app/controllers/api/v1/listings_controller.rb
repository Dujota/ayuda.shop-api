class Api::V1::ListingsController < ApplicationController
  before_action :set_listing, only: %i[show update destroy]

  # GET /api/v1/listings
  def index
    @listings = Listing.all

    render json: @listings
  end

  # GET /api/v1/listings/1
  def show
    render json: @listing
  end

  # POST /api/v1/listings
  def create
    @listing = Listing.new(listing_params)

    if @listing.save
      render json: @listing, status: :created, location: @listing
    else
      render json: @listing.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/listings/1
  def update
    if @listing.update(listing_params)
      render json: @listing
    else
      render json: @listing.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/listings/1
  def destroy
    @listing.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_listing
    @listing = Listing.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def listing_params
    params.require(:listing).permit(:title, :description, :type, :user)
  end
end
