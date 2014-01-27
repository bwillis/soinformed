require './lib/so_informed/message_builder_text'

describe SoInformed::MessageBuilderText do
  let(:text) { 'Some text' }
  subject { SoInformed::MessageBuilderText.new(text) }

  its(:text)     { should eq 'Some text' }
  its(:min_text) { should eq 'Some text' }
  its(:max_size) { should eq 9 }
  its(:min_size) { should eq 9 }

  describe '#optional' do
    before do
      subject.optional = true
    end

    its(:text)     { should eq 'Some text' }
    its(:min_text) { should eq '' }
    its(:max_size) { should eq 9 }
    its(:min_size) { should eq 0 }
  end

  describe '#fallback' do
    before do
      subject.fallback = 'text'
    end

    its(:text)     { should eq 'Some text' }
    its(:min_text) { should eq 'text' }
    its(:max_size) { should eq 9 }
    its(:min_size) { should eq 4 }

    context 'when the fallback text is greater than the given text' do
      it 'raises an error' do
        expect { subject.fallback = 'Some more text' }.to raise_error ArgumentError
      end
    end
  end

end
