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

end
