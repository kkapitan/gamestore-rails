class Api::V1::ReviewsController < ApplicationController

  def create
    review = Review.new(review_params)
    if review.save
      render json: review, status: 201
    else
      render json: { errors: review.errors }, status: 422
    end
  end

  private
    def review_params
      params.require(:review).permit(:title,:body,:mark,:user_id,:game_id)
    end

end
