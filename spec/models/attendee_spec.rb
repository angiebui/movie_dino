require 'spec_helper'

describe Attendee do
  it { should belong_to(:outing) }
  it { should have_many(:selections) }
end
