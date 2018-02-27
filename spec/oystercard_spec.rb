require 'oystercard'

describe Oystercard do
  context 'Creation of a new Oystercard' do
    it 'should have a stating balance of zero by default' do
      expect(subject.balance).to eq 0
    end
  end

  context 'Topping up Oystercard' do
    it 'should increase the current balance by a specified amount' do
      subject.top_up(13)
      expect(subject.balance).to eq 13
    end

    it 'raises an error if attempt to top up would exceed maximum balance' do
      expect { subject.top_up(Oystercard::TOP_UP_LIMIT + 1) }.to raise_error "Exceeded #{Oystercard::TOP_UP_LIMIT} limit"
    end
  end

  context 'Deducting from Oystercard' do
    it 'should decrease the current balance by a specified amount' do
      subject.top_up(1)
      subject.touch_in
      expect(subject.touch_out).to eq 0
    end
  end

  context 'Checking whether you are in journey or not' do
    before(:each) do
      subject.balance = 1
      subject.touch_in
    end

    it 'expects to initally not be in journey' do
      subject.touch_out
      expect(subject).not_to be_in_journey
    end

    it 'expects to be in a journey after a touch in' do
      expect(subject.card_status).to be :in_use
    end

    it 'expects to not to be in a journey after a touch out' do
      subject.touch_out
      expect(subject.card_status).to be :not_in_use
    end

    context 'Trying to start a journey with balance under the limit' do
      it 'returns an error, not enough funds' do
        subject.touch_out
        expect { subject.touch_in }.to raise_error 'Insufficient funds, top up.'
      end
    end

    context 'When finishing the journey' do
      it 'updates the balance by deducting the min fare' do
        expect { subject.touch_out }.to change { subject.balance }.by(-1)
      end
    end
  end
end
