require 'spec_helper'

describe Api::V1::SessionsController do
  describe "POST #create" do

    before(:each) do
      @user = FactoryGirl.create :user
    end

    context "when the credentials are correct" do

      before(:each) do
        credentials = { email: @user.email, password: "password" }
        post :create, { session: credentials }
      end

      it "returns user record corresponding to given credentials" do
        @user.reload
        expect(json_response[:auth_token]).to eql @user.auth_token
      end

      it { should respond_with 200 }

    end

    context "when the credentials are incorrect" do

      before(:each) do
        credentials = { email: @user.email, password: "badpassword" }
        post :create, { session: credentials }
      end

      it "returns json with errors" do
        expect(json_response[:errors]).to eql "Invalid email or password"
      end

      it { should respond_with 422 }

    end

  end

  describe "DELETE #destroy" do
    before(:each) do
      @user = FactoryGirl.create(:user, auth_token: "authtoken123")
      request.headers["Authorization"] = @user.auth_token
      delete :destroy
    end

    it { should respond_with 204 }

  end
end
