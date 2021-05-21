class TransactionsController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [:create]

    def create
        photo = Photo.find params["id"]
        session = Stripe::Checkout::Session.create({
            payment_method_types: ['card'],
            line_items: [
               {
                price_data: {
                    unit_amount: 1000,
                    currency: 'aud',
                    product_data: {
                        name: 'Stubborn 1',
                    },
                },
                quantity: 1,
            },
            {
                price_data: {
                    unit_amount: 3000,
                    currency: 'aud',
                    product_data: {
                        name: 'Stubborn 2',
                    },
                },
                quantity: 2,
            },
                {
                price_data: {
                    unit_amount: 3000,
                    currency: 'aud',
                    product_data: {
                        name: 'Stubborn 3',
                    },
                },
                quantity: 3,
            }],
            mode: 'payment',
            success_url: checkout_success_url,
            cancel_url: photos_url,
        })

        render json: { id: session.id }
    end

    def success
    end
end
