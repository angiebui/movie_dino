require 'spec_helper'

describe TheatersZipcode do
  it { should belong_to(:zipcode) }
  it { should belong_to(:theater) }
  it { should validate_uniqueness_of(:theater_id).scoped_to(:zipcode_id) }
  it { should allow_mass_assignment_of(:zipcode) }
  it { should allow_mass_assignment_of(:theater) }

end
