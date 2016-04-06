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

  describe "POST #create" do

    context "When successfuly created" do
      before(:each) do
        @game_attributes = FactoryGirl.attributes_for :game
        post :create, { game: @game_attributes }
      end

      it "returns json with information about created object" do
        game_response = json_response
        expect(game_response[:title]).to eql @game_attributes[:title]
      end

      it { should respond_with 201 }
    end

    context "When creating results in error" do
      before(:each) do
        @invalid_game_attributes = { title: "Test game" }
        post :create, { game: @invalid_game_attributes }
      end

      it "returns json with information about errors" do
        game_response = json_response
        expect(game_response[:errors][:description]).to include "can't be blank"
      end

      it { should respond_with 422 }

    end

  end

  describe "PUT/PATCH #update" do

    context "When successfuly updated" do
      before(:each) do
        @game = FactoryGirl.create :game
        @update_attributes = { price: "100.0" }
        patch :update,{ id: @game.id, game: @update_attributes }
      end

      it "renders json with information about updated object" do
        game_response = json_response
        expect(game_response[:price]).to eql @update_attributes[:price]
      end

      it { should respond_with 200 }

    end

    context "When updating results in error" do
      before(:each) do
        @game = FactoryGirl.create :game
        @invalid_update_attributes = { price: "-100" }
        patch :update,{ id: @game.id, game: @invalid_update_attributes }
      end

      it "renders json with information about error" do
        game_response = json_response
        expect(game_response[:errors][:price]).to include "must be greater than or equal to 0"
      end

      it { should respond_with 422 }

    end

  end



end
