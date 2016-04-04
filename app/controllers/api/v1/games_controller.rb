class Api::V1::GamesController < ApplicationController
  respond_to :json

  def show
    respond_with Game.find(params[:id])
  end



end
