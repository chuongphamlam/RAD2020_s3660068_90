class CardsController < ApplicationController
    before_action :logged_in_user, only: [:edit, :create,:update, :destroy]
    before_action :correct_user, only: [:edit, :update]
    skip_before_action :verify_authenticity_token

    def create
        @card = current_user.cards.new(card_params)
        if @card.save
            flash[:success] = "verification Success !"
            redirect_to "/users/#{current_user.id}"
        else
            flash[:danger] = "verification Errors !"
            redirect_to "/settings?verification"
        end

    end
    
    private

    def card_params
        params.require(:card).permit(
          :name,
          :number,
          :photo,
        )
      end
end
