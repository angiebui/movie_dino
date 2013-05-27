require 'spec_helper'

describe Selection do
  it { should belong_to(:showtime) }
  it { should belong_to(:outing) }
  it { should belong_to(:movie) }
  it { should belong_to(:theater) }
  it { should have_many(:selecteds) }
  it { should have_many(:attendees).through(:selecteds)}

 
end
