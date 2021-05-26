class HomeController < ApplicationController
  # Query to select the 6 most recently added photos for display on home page, based on datestamp in db
  def page
    @photos = Photo.all.order(:created_at).reverse_order.limit(6)
  end
end
