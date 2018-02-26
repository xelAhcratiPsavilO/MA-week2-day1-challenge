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
      expect(result).to eq 13
    end
    it "raises an error if attempt to top up would exceed maximum balance" do
      expect { subject.top_up(91) }.to raise_error "Balance limit #{Oystercard::LIMIT} exceeded"
    end
  end

  context "Deducting from Oystercard" do
    it "should decrease the current balance by a specified amount" do
      subject.top_up(24)
      result = subject.deduct(13)
      expect(result).to eq 11
    end
  end


end
