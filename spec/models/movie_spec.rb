require 'spec_helper'

describe Movie do
  it { should have_many(:showtimes)}
  it { should have_many(:theaters).through(:showtimes) }

  describe 'attributes' do
    let(:movie) { create(:movie, title: "A Title")}
    it 'should have a title' do
      movie.title.should eq "A Title"
    end
  end
end
