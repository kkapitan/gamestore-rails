require 'spec_helper'

describe Api::V1::LibrariesController do

  describe "PUT/PATCH #update" do


    context "when update is successfull" do
      before(:each) do
        @user = FactoryGirl.create :user
        @game1 = FactoryGirl.create :game
        @game2 = FactoryGirl.create :game
        patch :update, {id: @user.id, game_ids: [@game1.id, @game2.id]}

        @user.reload
      end

      it "renders json with updated library information" do
        library_response = json_response
        expect(JSON.parse(library_response[:games].to_json)).to eql JSON.parse(ActiveModel::ArraySerializer.new(@user.games, each_serializer: GameSerializer).to_json)
      end

      it { should respond_with 200 }
    end

    context "when update is not successfull" do
      before(:each) do
        @user = FactoryGirl.create :user
        @game1 = FactoryGirl.create :game
        patch :update, {id: @user.id, game_ids: [@game1.id, @game1.id]}

        @user.reload
      end

      it "renders json with information about errors" do
        library_response = json_response
        expect(library_response).to have_key(:errors)
      end

      it { should respond_with 422 }
    end


  end

end
