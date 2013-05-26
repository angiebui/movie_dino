require 'spec_helper'

describe MovieTime do

  
  describe '#initialize' do
    before do
      Mechanize.any_instance.stub(:get)
      Mechanize.any_instance.should_receive(:get).and_return(nil)

      MovieTime.any_instance.stub(:fetch_times!)
      MovieTime.any_instance.should_receive(:fetch_times!).and_return(nil)
      @mt = MovieTime.new('94108')
    end
    it 'should do stuff' do
      @mt.page.should be_nil
    end
  end

  describe '#fetch_theater' do
    it 'should require a theater_doc' do
      pending
      expect { @mt.fetch_theater() }.to raise_error(ArgumentError)
    end
  end
end
