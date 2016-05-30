require 'futon/os'

RSpec.describe Futon::Os do
  before do
    allow(Kernel).to receive(:system)
  end

  describe '.system' do
    it 'delegates to kernel.system' do
      expect(Kernel).to receive(:system).with('foo', 'bar')
      described_class.system('foo', 'bar')
    end
  end
end
