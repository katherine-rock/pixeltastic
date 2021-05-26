class TransactionsController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [:create, :webhook]

    def create
        photo = Photo.find params["id"]
        session = Stripe::Checkout::Session.create({
            payment_method_types: ['card'],
            line_items: [
               {
                price_data: {
                    unit_amount: photo.price*100,
                    currency: 'aud',
                    product_data: {
                        name: photo.title
                    },
                },
                quantity: 1,
            }],
            mode: 'payment',
            success_url: rails_blob_url(photo.image, disposition: "attachment"),
            cancel_url: photos_url,
        })
        render json: { id: session.id }

    end

    def webhook
        transaction_id= params[:data][:object][:payment_intent]
        transaction = Stripe::PaymentIntent.retrieve(transaction_id)
        photo_id = transaction.metadata.photo_id
        user_id = transaction.metadata.user_id
        render plain: "Success"
    end

    def transaction_params
        params.require(:transaction).permit(:id, :seller_id, :buyer_id, :photo_id, :amount, :photo)
    end

end
