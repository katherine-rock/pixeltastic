class HomeController < ApplicationController
  # Query to select the most recent 6 photos for display on home page
  def page
    @photos = Photo.all.order(:created_at).reverse_order.limit(6)
  end
end


  # This page needs a method page even if it is empty