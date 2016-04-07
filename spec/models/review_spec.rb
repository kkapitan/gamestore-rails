require 'spec_helper'

describe Review do

  it { should belong_to(:user) }
  it { should belong_to(:game) }

  it { should respond_to(:title) }
  it { should respond_to(:body) }
  it { should respond_to(:mark) }

  it { should validate_numericality_of(:mark).is_less_than_or_equal_to(10) }
  it { should validate_numericality_of(:mark).is_greater_than_or_equal_to(0) }
  it { should validate_numericality_of(:mark).only_integer }

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:body) }
  it { should validate_presence_of(:mark) }

  it { should validate_length_of(:title).is_at_most(50) }
  it { should validate_length_of(:body).is_at_most(200) }

end
