require 'spec_helper'

describe Api::V1::ReviewsController do

  describe "POST #create" do

    context "When successfuly created" do
      before(:each) do
        @review_attributes = FactoryGirl.attributes_for :review
        post :create, {review: @review_attributes }
      end

      it "renders information about created object" do
        review_response = json_response
        expect(review_response[:mark]).to eql @review_attributes[:mark]
      end

      it { should respond_with 201 }
    end

    context "When creating results in errors" do
      before(:each) do
        @invalid_review_attributes = FactoryGirl.attributes_for :review
        @invalid_review_attributes[:mark] = -10
        post :create, {review: @invalid_review_attributes }
      end

      it "renders information about created object" do
        review_response = json_response
        expect(review_response[:errors][:mark]).to include "must be greater than or equal to 0"
      end

      it { should respond_with 422 }

    end

  end


end
