require './lib/so_informed/message_builder'

describe SoInformed::MessageBuilder do
  subject { SoInformed::MessageBuilder.new }
  before do
    subject.add 'Hello'
    subject.add ' world!'
  end

  its(:message)  { should eq 'Hello world!' }
  its(:max_size) { should eq 12 }
  its(:min_size) { should eq 12 }

  describe '#add' do
    context 'when input is nil' do
      before { subject.add nil }

      its(:message)  { should eq 'Hello world!' }
      its(:max_size) { should eq 12 }
      its(:min_size) { should eq 12 }
    end
  end

  describe '#add_optional' do
    before do
      subject.add_optional ' Have a great day!'
    end

    its(:message)          { should eq 'Hello world! Have a great day!' }
    its(:shortest_message) { should eq 'Hello world!' }
    its(:max_size)         { should eq 30 }
    its(:min_size)         { should eq 12 }
  end

  describe '#add_with_fallback' do
    before do
      subject.add_with_fallback ' Have a great day!', ' Bye!'
    end

    its(:message)          { should eq 'Hello world! Have a great day!' }
    its(:shortest_message) { should eq 'Hello world! Bye!' }
    its(:max_size)         { should eq 30 }
    its(:min_size)         { should eq 17 }

    context 'when the fallback text is greater than the given text' do
      it 'raises an error' do
        expect { subject.add_with_fallback 'Hi', 'Hello' }.to raise_error ArgumentError
      end
    end
  end

  describe '#add_spaces' do
    before do
      subject.reset
      subject.add_spaces = true
      subject.add 'Hello'
      subject.add 'world!'
    end

    its(:message)  { should eq 'Hello world!' }
    its(:max_size) { should eq 12 }
  end

  describe 'sized message' do
    before do
      subject.reset
      subject.add_spaces = true
      subject.add 'Hi there'
      subject.add_with_fallback 'William Smith,', 'Will S,'
      subject.add 'I hope you are doing well.'
      subject.add_optional 'Cya later!'
    end

    it { subject.message(55).should eq 'Hi there Will S, I hope you are doing well. Cya later!' }
    it { subject.message(50).should eq 'Hi there William Smith, I hope you are doing well.' }
    it { subject.message(49).should eq 'Hi there Will S, I hope you are doing well.' }

    context 'word substitutions' do
      before do
        subject.reset
        subject.add 'San Francisco International Airport'
      end

      it { subject.message(34).should eq 'San Francisco Int\'l Airport' }
    end
  end

  describe '#add_ellipsis' do
    before do
      subject.add_ellipsis ' This is some really long text'
    end

    it { subject.message(35).should eq 'Hello world! This is some re...' }
  end
end
