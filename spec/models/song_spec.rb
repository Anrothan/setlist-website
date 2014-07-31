require 'rails_helper'

RSpec.describe Song, :type => :model do
  
  before { @song = FactoryGirl.build(:song) }

  describe "validations" do
  	it "has a valid factory" do
  		expect(@song).to be_valid
  	end

  	it "has a title" do
  		@song.title = nil
  		expect(@song).to be_invalid
  	end

  	it "has an artist" do
  		@song.artist = nil
  		expect(@song).to be_invalid
  	end
  end
end
