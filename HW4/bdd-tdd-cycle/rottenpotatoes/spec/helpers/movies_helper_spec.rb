require 'spec_helper'

describe MoviesHelper do
  describe 'odd helper' do
    it 'should always return odd for one' do
      oddness(1).should == 'odd'
    end
    it 'should always return even for two' do
      oddness(2).should == 'even'
    end
  end
end