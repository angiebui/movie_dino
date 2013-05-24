require 'spec_helper'

describe Showtime do
  it { should belong_to(:movie) }
  it { should belong_to(:theater) }

  it { should validate_uniqueness_of(:time).scoped_to(:movie_id, :theater_id) }
  it { should validate_presence_of(:time) }
  it { should validate_presence_of(:movie) }
  it { should validate_presence_of(:theater) }

  describe 'attributes' do
    let(:showtime) { build(:showtime) }
    it 'should have a time' do
      showtime.time.should be_a_kind_of Time
    end
  end
end
