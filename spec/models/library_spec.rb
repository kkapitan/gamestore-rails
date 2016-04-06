require 'spec_helper'

describe Library do
  let(:library) { FactoryGirl.build :library }
  subject { library }

  it { should respond_to :game_id }
  it { should respond_to :user_id }

  it { should belong_to :game }
  it { should belong_to :user }
end
