require 'spec_helper'

describe Game do

  before do
    @game = FactoryGirl.build :game
  end

  subject { @game }

  it { should respond_to :title }
  it { should respond_to :description }
  it { should respond_to :price }

  it { should validate_presence_of :title }
  it { should validate_presence_of :description }
  it { should validate_presence_of :price }
  it { should validate_numericality_of(:price).is_greater_than_or_equal_to(0) }


  describe ".filter_by_title" do
    before(:each) do
      @game1 = FactoryGirl.create :game, title: "World of Warcraft"
      @game2 = FactoryGirl.create :game, title: "Witcher 3"
      @game3 = FactoryGirl.create :game, title: "GTA V"
      @game4 = FactoryGirl.create :game, title: "Worms"
    end

    context "when a 'Wo' pattern is sent" do

      it "returns the 2 games matching" do
        expect(Game.filter_by_title("Wo").count).to eql 2
      end

      it "returns the games matching" do
        expect(Game.filter_by_title("Wo")).to match_array([@game1, @game4])
      end

    end

  end

  describe ".above_or_equal_to_price" do
    before(:each) do
      @game1 = FactoryGirl.create :game, price: 100
      @game2 = FactoryGirl.create :game, price: 99
      @game3 = FactoryGirl.create :game, price: 150
      @game4 = FactoryGirl.create :game, price: 50
    end

    it "returns the 2 games matching" do
      expect(Game.above_or_equal_to_price(100).count).to eql 2
    end

    it "returns the games matching" do
      expect(Game.above_or_equal_to_price(100)).to match_array([@game1, @game3])
    end

  end

  describe ".below_or_equal_to_price" do
    before(:each) do
      @game1 = FactoryGirl.create :game, price: 100
      @game2 = FactoryGirl.create :game, price: 99
      @game3 = FactoryGirl.create :game, price: 150
      @game4 = FactoryGirl.create :game, price: 50
    end

    it "returns the 3 games matching" do
      expect(Game.below_or_equal_to_price(100).count).to eql 3
    end

    it "returns the games matching" do
      expect(Game.below_or_equal_to_price(100)).to match_array([@game2, @game4, @game1])
    end

  end

end
