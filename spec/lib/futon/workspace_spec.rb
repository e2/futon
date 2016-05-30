require 'futon/workspace'
RSpec.describe Futon::Workspace do
  before do
  end

  subject { described_class.new(options) }
  describe '#initialize' do
    context 'with valid options' do
      before do
        allow(File).to receive(:expand_path)
          .with('~/work/bar').and_return('/home/foo/work/bar')
      end

      let(:options) do
        {
          name: 'project1',
          directory: '~/work/bar',
          source: {
            type: 'git',
            url: 'http://example.org/foo.git'
          }
        }
      end

      it 'works' do
        subject
      end
    end

    context 'with invalid options' do
      context 'with missing source option' do
        let(:options) do
          {
            name: 'project1',
            directory: '~/work/bar'
          }
        end

        it 'fails' do
          expect { subject.setup }
            .to raise_error(described_class::Error::MissingSource)
        end
      end
    end
  end

  describe '#setup' do
    context 'with a git repository' do
      let(:options) do
        {
          name: 'project1',
          directory: '~/work/bar',
          source: {
            type: 'git',
            url: 'http://example.org/foo.git'
          }
        }
      end

      let(:provider) { instance_double(described_class::Provider::Git) }

      before do
        allow(described_class::Provider::Git).to receive(:new)
          .with(type: 'git', url: 'http://example.org/foo.git')
          .and_return(provider)

        allow(File).to receive(:expand_path)
          .with('~/work/bar').and_return('/home/foo/work/bar')
        allow(provider).to receive(:provide)
      end

      # TODO: clone using ssh if possible
      it 'clones using git' do
        expect(provider).to receive(:provide)
          .with('/home/foo/work/bar').and_return(true)
        subject.setup
      end
    end
  end
end
