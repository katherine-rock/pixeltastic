class PhotosController < ApplicationController
    before_action :set_photo, only: %i[ show edit update destroy ]
    before_action :authenticate_user!, only: %i[ new create edit update destroy ]
    rescue_from Pundit::NotAuthorizedError, with: :unauthorised 

    # Alert message if user attempts to edit or delete another users image
    def unauthorised
        flash[:alert] = "Sorry! You do not have access to do that. If you believe this is an error, please report the issue via the help page."
        redirect_to photos_path
    end
    # Method to list all photos 
    # Added query to display most recently added photos first 
    def index
        @photos = Photo.order(:created_at).reverse_order
    end 
 
    # Need to include although there is no method defined - needed for view to retrieve form    
    def show
    end

    # Added Pundit authorisation so users can only edit their own photos
    def edit
        authorize @photo
    end

    # Query to only display photos uploaded by the current user for their portfolio
    def portfolio
        if user_signed_in?
        @portfolio = Photo.where(user_id: current_user.id)
        else   
        end
    end

    # To create new instance of the photo model
    def new
        @photo = Photo.new 
    end

    # Create method creates new instance, saves it and informs user
    def create
        # raise params.inspect
        @photo = Photo.new(photo_params)

        respond_to do |format|
        if @photo.save
            format.html { redirect_to @photo, notice: "Photo was successfully created." }
            format.json { render :show, status: :created, location: @photo }
        else
            format.html { render :new, status: :unprocessable_entity }
            format.json { render json: @photo.errors, status: :unprocessable_entity }
        end
        end
    end

    # To update photo listing  
    def update
        respond_to do |format|
            if @photo.update(photo_params)
            format.html { redirect_to @photo, notice: "Photo listing has been successfully updated." }
            format.json { render :show, status: :ok, location: @photo }
            else
            format.html { render :edit, status: :unprocessable_entity }
            format.json { render json: @photo.errors, status: :unprocessable_entity }
            end
        end
    end

    # To delete an instance of a photo listing 
    def destroy
        authorize @photo
        @photo.destroy
        respond_to do |format|
            format.html { redirect_to photos_url, notice: "Photo listing has been successfully deleted." }
            format.json { head :no_content }
        end
    end

    # Private methods 
    private

    # Set used to find instance to edit or delete 
    def set_photo
        @photo = Photo.find(params[:id])
    end

    # List all trusted params in symbol format (e.g. :name, :description, :price)
    # Get this info from db migration or schema file (or ERD)
    # Any arrays need to be listed at the end
    def photo_params
        params.require(:photo).permit(:title, :description, :price, :category, :style, :image).merge(user_id: current_user.id)
    end

end
