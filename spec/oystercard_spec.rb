require "oystercard"

describe Oystercard do

  context "Creation of a new Oystercard" do
    it "should have a stating balance of zero by default" do
      expect(subject.balance).to eq 0
    end
  end

  context "Topping up Oystercard" do
    it "should increase the current balance by a specified amount" do
      result = subject.top_up(13)
      expect(result).to eq subject.balance
    end
  end

end
