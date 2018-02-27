require 'oystercard'

describe Oystercard do
  let(:fake_station) { double() }
  context 'Creation of a new Oystercard' do
    it 'should have a stating balance of zero by default' do
      expect(subject.balance).to eq 0
    end

    it 'should have an empty journey history' do
      expect(subject.history).to be_empty
    end
  end

  context 'Topping up Oystercard' do
    it 'should increase the current balance by a specified amount' do
      subject.top_up(13)
      expect(subject.balance).to eq 13
    end

    it 'raises an error if attempt to top up would exceed maximum balance' do
      expect { subject.top_up(Oystercard::TOP_UP_LIMIT + 1) }.to raise_error "Exceeded top up limit of: #{Oystercard::TOP_UP_LIMIT}"
    end
  end

  context 'Deducting from Oystercard' do
    it 'should decrease the current balance by a specified amount' do
      subject.top_up(1)
      subject.touch_in(fake_station)
      expect(subject.touch_out(fake_station)).to eq 0
    end
  end

  context 'Checking whether you are in journey or not' do
    before(:each) do
      subject.balance = 1
      subject.touch_in(fake_station)
    end

    it 'expects to initally not be in journey' do
      subject.touch_out(fake_station)
      expect(subject).not_to be_in_journey
    end

    it 'expects to be in a journey after a touch in' do
      expect(subject.in_journey?).to be true
    end

    it 'expects to not to be in a journey after a touch out' do
      subject.touch_out(fake_station)
      expect(subject.in_journey?).to be false
    end

    context 'Trying to start a journey with balance under the limit' do
      it 'returns an error, not enough funds' do
        subject.touch_out(fake_station)
        expect { subject.touch_in(fake_station) }.to raise_error 'Insufficient funds, top up.'
      end
    end

    context 'When I start my journey' do
      it 'should save my starting station' do
        expect(subject.entry_station).to eq fake_station
      end
    end

    context 'When finishing the journey' do
      it 'updates the balance by deducting the min fare' do
        expect { subject.touch_out(fake_station) }.to change { subject.balance }.by(-1)
      end

      before(:each) do
        subject.touch_out(fake_station)
      end

      it 'should reset entry station' do
        expect(subject.entry_station).to eq nil
      end

      it 'should save my touch out station' do
        expect(subject.exit_station).to eq fake_station
      end

      it 'should create a journey' do
        expect(subject.history).not_to be_empty
      end

      it 'shold store journey history' do
        expect(subject.history).to eq [{:entry_station => fake_station, :exit_station => fake_station}]
      end
    end
  end
end
