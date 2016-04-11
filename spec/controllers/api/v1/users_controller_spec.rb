require 'spec_helper'

describe Api::V1::UsersController do

  describe 'GET #show' do
    before(:each) do
      @user = FactoryGirl.create :user
      get :show, id: @user.id
    end

    it "returns the information about user on a hash" do
      user_response = json_response[:user]
      expect(user_response[:email]).to eql @user.email
      expect(user_response[:nickname]).to eql @user.nickname
      expect(user_response[:name]).to eql @user.name
      expect(user_response[:last_name]).to eql @user.last_name
    end

    it { should respond_with 200 }
  end

  describe 'POST #create' do

    context "when is sucessfully created" do
      before(:each) do
        @user_attributes = FactoryGirl.attributes_for :user
        post :create, {user: @user_attributes}
      end

      it "renders the json representation for the user record just created" do
        user_response = json_response[:user]
        expect(user_response[:email]).to eql @user_attributes[:email]
      end

      it "generates authentication token" do
        user_response = json_response[:user]
        expect(user_response[:auth_token]).to be_present
      end

      it { should respond_with 201}
    end

    context "when is not created" do
      before(:each) do
        @invalid_user_attributes = { password: "11231", password_confirmation: "11231" }
        post :create, {user: @invalid_user_attributes}
      end

      it "renders error json" do
        user_response = json_response
        expect(user_response).to have_key(:errors)
      end

      it "renders the json errors on why the user could not be created" do
        user_response = json_response
        expect(user_response[:errors][:email]).to include "can't be blank"
      end

      it { should respond_with 422 }

    end

  end

  describe "PUT/PATCH #update" do

    context "when successfully updated" do
      before(:each) do
        @user = FactoryGirl.create :user
        api_authorization_header(@user.auth_token)
        patch :update, {id: @user.id, user: {email: "newmail@example.com" }}
      end

      it "renders the json representation for updated object" do
        user_response = json_response[:user]
        expect(user_response[:email]).to eql "newmail@example.com"
      end

      it { should respond_with 200 }

    end

    context "when is not updated" do
      before(:each) do
        @user = FactoryGirl.create :user
        api_authorization_header(@user.auth_token)
        patch :update, {id: @user.id, user: {email: "bademail" }}
      end

      it "renders errors as json" do
        user_response = json_response
        expect(user_response).to have_key(:errors)
      end

      it "renders information about invalid fields" do
        user_response = json_response
        expect(user_response[:errors][:email]).to include "is invalid"
      end

      it { should respond_with 422 }

    end
  end

  describe "DELETE #destroy" do
    before(:each) do
      @user = FactoryGirl.create :user_with_game_library
      api_authorization_header(@user.auth_token)
      delete :destroy, {id: @user.id }
    end

    it {should respond_with 204 }
  end
end
