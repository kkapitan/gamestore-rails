class Api::V1::GamesController < ApplicationController

  respond_to :json
  #before_action :authenticate_with_token!

  def index
    render json:[Game.search(params).page(params[:page]).per(params[:limit]), {categories: Game.categories.hash.values}], status:200
  end

  def show
    render json:Game.find(params[:id]), serializer: DetailedGameSerializer, status: 200
  end

  def create
    game = Game.new(game_params)
    if game.save
      render json: game, status: 201, location: [:api, game]
    else
      render json: {errors: game.errors}, status: 422
    end
  end

  def update
    game = Game.find(params[:id])
    if game.update(game_params)
      render json: game, status: 200, location: [:api, game]
    else
      render json: {errors: game.errors }, status: 422
    end
  end

  def destroy
    game = Game.find(params[:id])
    game.destroy
    head 204
  end

    private
      def game_params
        params.require(:game).permit(:title,:description,:price)
      end

end
