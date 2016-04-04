require 'spec_helper'

describe Api::V1::GamesController do

  describe "GET #show" do
    before(:each) do
      @game = FactoryGirl.create :game
      get :show, id: @game.id
    end

    it "returns the information about a game on a hash" do
      product_response = json_response
      expect(product_response[:title]).to eql @game.title
    end

    it { should respond_with 200 }

  end

  

end
