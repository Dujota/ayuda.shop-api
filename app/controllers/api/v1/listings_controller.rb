class API::V1::ListingsController < ApplicationController
  before_action :authenticate_user!, except: %i[index]
  before_action :set_type, only: %i[my_listings]
  load_and_authorize_resource

  # GET /api/v1/listings
  def index
    @listings = Listing.all
    render json: @listings
  end

  def my_listings
    if @type
      @listings = Listing.user_listings(current_user).by_type(@type.id)
      if @listings
        render json: {
                 status: 200,
                 message: "Listings filtered by #{params[:type]}",
                 data: @listings
               },
               status: :ok
      else
        user_listing_types_failed
      end
    else
      @listings = Listing.user_listings(current_user)
      if @listings
        render json: {
                 status: 200,
                 message: "All listings for user #{current_user.id}",
                 data: @listings
               },
               status: :ok
      else
        all_user_listings_failed
      end
    end
  end

  # GET /api/v1/listings/1
  def show
    render json: @listing
  end

  # POST /api/v1/listings
  def create
    @listing = Listing.new(listing_params)
    @listing.user = current_user

    if @listing.save
      render json: @listing,
             status: :created,
             location: api_v1_listings_url(@listing)
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

  # # Use callbacks to share common setup or constraints between actions.

  def user_listing_types_failed
    render json: { status: 400 }, status: :bad_request
  end

  def all_user_listings_failed
    render json: {
             status: 422,
             message: "User listings couldn't be found successfully."
           },
           status: :unprocessable_entity
  end

  def set_type
    @type = Type.find_by(tag: params[:type]) if params[:type]
  end

  # Only allow a list of trusted parameters through.
  def listing_params
    params.require(:listing).permit(
      :title,
      :description,
      :type_id,
      :user_id,
      :type
    )
  end
end
