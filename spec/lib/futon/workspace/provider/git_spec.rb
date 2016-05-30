require 'futon/workspace/provider/git'

RSpec.describe Futon::Workspace::Provider::Git do
  let(:options) { {} }
  subject { described_class.new(options) }

  describe '#initialize' do
    context 'with valid options' do
      let(:options) { { url: 'http://example.org/foo.git' } }
      it 'works' do
        subject
      end
    end
  end

  describe '#provide' do
    context 'with valid options' do
      let(:options) { { url: 'http://example.org/foo.git' } }

      context 'with a valid directory' do
        context 'with a succeeding command' do
          it 'clones the repository' do
            allow(Futon::Os).to receive(:system)
            args = %w(git clone http://example.org/foo.git /home/foo/work/bar)
            expect(Futon::Os).to receive(:system).with(*args).and_return(true)
            subject.provide('/home/foo/work/bar')
          end
        end

        context 'with a failing command' do
          it 'clones the repository' do
            allow(Futon::Os).to receive(:system)
            args = %w(git clone http://example.org/foo.git /home/foo/work/bar)
            expect(Futon::Os).to receive(:system).with(*args).and_return(nil)
            expect do
              subject.provide('/home/foo/work/bar')
            end.to raise_error(
              described_class::Error::CloneFailed,
              %r{command\ failed\ \[\(exec\ failed\)\]:
              \ 'git\ clone\ http://example\.org/foo.git\ /home/foo/work/bar'}x
            )
          end
        end
      end
    end
  end
end
