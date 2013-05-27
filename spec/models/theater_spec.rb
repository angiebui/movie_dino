require 'spec_helper'

describe Theater do
  let(:theater) { build(:theater) }
  it { should have_many(:showtimes) }
  it { should have_many(:movies).through(:showtimes) }
  it { should have_many(:theaters_zipcodes) }
  it { should have_many(:zipcodes).through(:theaters_zipcodes) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:street) }
  it { should validate_presence_of(:city) }
  it { should validate_presence_of(:state) }
  it { should validate_presence_of(:phone_number) }

  it {should validate_uniqueness_of(:street).scoped_to(:name,
                                                       :city,
                                                       :state,
                                                       :phone_number)}
  describe 'attributes' do
    it 'should have a name' do

      theater.name.should eq "A Theater"
    end
    it 'should have a street' do
      theater.street.should eq "717 California St."
    end
    it 'should have a state' do
      theater.state.should eq "CA"
    end
    it 'should have a city' do
      theater.city.should eq "San Francisco"
    end
    it 'should have a phone number' do
      theater.phone_number.should eq "(111) 111-1111"
    end
  end

  describe '#self.outdated' do
    let(:stale_theater) { create(:stale_theater)}
    let(:fresh_theater) { create(:theater)}
    it 'returns all of the stale movie theaters' do
      Theater.outdated.should include stale_theater
    end
    it 'does not return fresh results' do
      Theater.outdated.should_not include fresh_theater
    end
  end
end
