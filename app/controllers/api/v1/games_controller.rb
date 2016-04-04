class Api::V1::GamesController < ApplicationController
  respond_to :json

  def show
    respond_with Game.find(params[:id])
  end

  def create
    game = Game.new(game_params)
    print(game_params)
    if game.save
      render json: game, status: 201, location: [:api, game]
    else
      render json: {errors: game.errors}, status: 422
    end
  end

    private
      def game_params
        params.require(:game).permit(:title,:description,:price)
      end

end
