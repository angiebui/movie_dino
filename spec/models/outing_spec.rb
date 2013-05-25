require 'spec_helper'

describe Outing do
  it { should have_many(:selections) }
  it { should have_many(:attendees) }
  it { should belong_to(:user) }

end
