require "oystercard"

describe Oystercard do

  context "Creation of a new Oystercard" do
    it "should have a stating balance of zero by default" do
      expect(subject.balance).to eq 0
    end
  end


end
