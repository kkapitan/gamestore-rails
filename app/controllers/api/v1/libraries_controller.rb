class Api::V1::LibrariesController < ApplicationController
  def update
    user = User.find(params[:id])

    game_ids = params[:game_ids]
    game_ids.each { |game_id|
      library_entry = Library.new({user_id:user.id, game_id:game_id})

      unless library_entry.save
        render json: {errors: "Something went wrong!"}, status: 422
        return
      end
    }

    render json: {games: ActiveModel::ArraySerializer.new(user.games, each_serializer: GameSerializer)}, status:200
  end

end
