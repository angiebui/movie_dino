require 'spec_helper'

describe Zipcode do
  it { should have_many(:theaters).through(:theaters_zipcodes) }
  it { should have_many(:theaters_zipcodes) }
  it { should validate_presence_of(:zipcode) }
  it { should allow_mass_assignment_of(:zipcode) 
  it { should allow_mass_assignment_of(:theater) }
  it { should allow_mass_assignment_of(:cache_date) }

  describe 'attributes' do
    let(:zipcode) { build(:zipcode) }
    it 'should have a zipcode' do
      zipcode.zipcode.should eq "12345"
    end
  end

  describe '#stale?' do
    let(:stale_zipcode) { create(:stale_zipcode) }
    let(:fresh_zipcode) { create(:zipcode) }
    it 'returns true if zipcode is stale' do
      stale_zipcode.stale?.should eq true
    end

    it 'returns false if zipcode is not stale' do
      fresh_zipcode.stale?.should eq false
    end
  end
end
