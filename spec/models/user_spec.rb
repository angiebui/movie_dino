require 'spec_helper'

describe User do
  it { should have_many(:outings) }

  describe 'attributes' do
    let(:user) { create(:user) }
    it 'should include email' do
      user.email.should eq 'email@example.com'
    end
    it 'should include first_name' do
      user.first_name.should eq 'Robby'
    end
    it 'should include last_name' do
      user.last_name.should eq 'Bobby'
    end
    it 'should include an image' do
      user.image.should eq 'http://www.example.com/1'
    end
  end
end
