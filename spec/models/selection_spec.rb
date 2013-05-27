require 'spec_helper'

describe Selection do
  it { should belong_to(:showtime) }
  it { should belong_to(:owner) }
  it { should belong_to(:movie) }
  it { should belong_to(:theater) }

  describe 'references the correct owner' do
    context 'when given an outing' do
      it 'should reference an outing' do
        outing_selection = create(:outing_selection)
        outing_selection.owner.should be_a_kind_of Outing
      end
    end

    context 'when given an attendee' do
      it 'should reference an attendee' do
        attendee_selection = create(:attendee_selection)
        attendee_selection.owner.should be_a_kind_of Attendee
      end
    end
  end
end
