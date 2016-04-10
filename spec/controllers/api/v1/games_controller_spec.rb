require 'spec_helper'

describe Api::V1::GamesController do
  before(:each) do
    @user = FactoryGirl.create :user
    api_authorization_header(@user.auth_token)
  end

  describe "GET #show" do
    before(:each) do
      @game = FactoryGirl.create :game_with_reviews
      get :show, id: @game.id
    end

    it "returns the information about a game on a hash" do
      game_response = json_response[:game]
      expect(game_response[:title]).to eql @game.title
    end

    it "returns information about game reviews" do
      game_response = json_response[:game]
      expect(game_response).to have_key(:reviews)
    end

    it { should respond_with 200 }

  end

  describe "GET #index" do

    context "when no search and paging are specified" do

      before(:each) do
        4.times { FactoryGirl.create :game }
        get :index
      end

      it "returns json with list of games" do
        game_response = json_response
        expect(game_response[:games].count).to eql 4
      end

      it { should respond_with 200 }
    end

    context "when page and limit are specified" do

      before(:each) do
        @game1 = FactoryGirl.create :game, title: "World"
        @game2 = FactoryGirl.create :game, title: "World 2"
        @game3 = FactoryGirl.create :game, title: "2 World"
        @game4 = FactoryGirl.create :game, title: "3 World"
        
        get :index, {page:2, limit: 2 }
      end

      it "returns json with limited list of games" do
        game_response = json_response
        expect(game_response[:games].count).to eql 2
      end

      it "returns objects from the limited list" do
        game_response = json_response
        expect(game_response[:games][0][:id]).to eql @game3.id
        expect(game_response[:games][1][:id]).to eql @game4.id
      end

      it { should respond_with 200 }
    end

    context "when search criteria are present"  do
      before(:each) do
        @game1 = FactoryGirl.create :game, title: "World"
        @game2 = FactoryGirl.create :game, title: "World 2"
        @game3 = FactoryGirl.create :game, title: "2 World"
        @game4 = FactoryGirl.create :game, title: "3 World"

        get :index, {keyword:"2" }
      end

      it "returns json with filtered list of games" do
        game_response = json_response
        expect(game_response[:games].count).to eql 2
      end

      it "returns objects from the filtered list" do
        game_response = json_response
        expect(game_response[:games][0][:id]).to eql @game2.id
        expect(game_response[:games][1][:id]).to eql @game3.id
      end
      it { should respond_with 200 }
    end

  end

  describe "POST #create" do

    context "When successfuly created" do
      before(:each) do
        @game_attributes = FactoryGirl.attributes_for :game
        post :create, { game: @game_attributes }
      end

      it "returns json with information about created object" do
        game_response = json_response[:game]
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
        game_response = json_response[:game]
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

  describe "DELETE #destroy" do
    before(:each) do
      @game = FactoryGirl.create :game
      delete :destroy, id: @game.id
    end

    it { should respond_with 204 }

  end



end
