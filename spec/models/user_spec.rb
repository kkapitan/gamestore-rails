require 'spec_helper'

describe User do
  before { @user = FactoryGirl.build(:user) }

  subject { @user }

  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:auth_token)}

  it { should be_valid }

  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }
  it { should validate_confirmation_of(:password) }
  it { should allow_value('example@domain.com').for(:email) }
  it { should validate_uniqueness_of(:auth_token) }

  it { should have_many(:libraries) }
  it { should have_many(:games).through(:libraries) }

  it { should have_many(:reviews) }

  describe "#generate_authentication_token!" do

    it "generates a unique  token" do
      Devise.stub(:friendly_token).and_return("anuniquetoken123")
      @user.generate_authentication_token!
      expect(@user.auth_token).to eql "anuniquetoken123"
    end

    it "genenerates another token if one was taken" do
      existing_user = FactoryGirl.create(:user, auth_token: "anuniquetoken123")
      @user.generate_authentication_token!
      expect(@user.auth_token).not_to eql existing_user.auth_token
    end

  end



end
