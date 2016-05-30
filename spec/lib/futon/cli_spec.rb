require 'futon/cli'

RSpec.describe Futon::Cli do
  let(:argv) { [] }
  let(:config) { instance_double(Futon::Configuration) }

  subject { described_class.new(argv) }

  before do
    allow(Futon::Configuration).to receive(:new).and_return(config)
  end

  describe '#initialize' do
    it 'works' do
      subject
    end
  end

  describe '#execute!' do
    let(:workspace1) { instance_double(Futon::Workspace) }
    let(:workspace2) { instance_double(Futon::Workspace) }
    let(:workspaces) { [workspace1, workspace2] }

    before do
      allow(config).to receive(:workspaces).and_return(workspaces)
    end

    it 'sets up workspaces' do
      expect(workspace1).to receive(:setup)
      expect(workspace2).to receive(:setup)
      subject.execute!
    end
  end
end
