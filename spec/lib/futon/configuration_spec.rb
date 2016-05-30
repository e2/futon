require 'futon/configuration'

RSpec.describe Futon::Configuration do
  describe '#workspaces' do
    context 'with a default file path' do
      let(:actual_config_file) { '/home/foo/.futon/default.yml' }
      let(:default_config_file) { '~/.futon/default.yml' }

      before do
        allow(IO).to receive(:read).with(actual_config_file)
        allow(YAML).to receive(:load_file)
          .with(actual_config_file).and_return(raw_options)
        allow(File).to receive(:expand_path)
          .with(default_config_file).and_return(actual_config_file)
      end

      context 'with a invalid yaml file' do
        context 'with no workspace section' do
          let(:raw_options) { {} }
          it 'fails' do
            expect { subject.workspaces }
              .to raise_error(Futon::Configuration::Error::NoWorkspaces)
          end
        end

        context 'with no options' do
          let(:raw_options) { nil }
          it 'fails' do
            expect { subject.workspaces }
              .to raise_error(Futon::Configuration::Error::NoWorkspaces)
          end
        end
      end

      context 'with a valid yaml file' do
        context 'with an empty workspace config' do
          let(:raw_options) { { workspaces: {} } }
          pending 'ask to remove projects based on last checkout'
        end

        context 'with a single workspace config' do
          let(:workspace1) { instance_double(Futon::Workspace) }
          let(:raw_options) do
            {
              workspaces: {
                'foo' => { foo_option: 'foo1' }
              }
            }
          end

          it 'creates a workspace instance' do
            expected = { name: 'foo', foo_option: 'foo1' }
            allow(Futon::Workspace).to receive(:new)
              .with(hash_including(expected))
              .and_return(workspace1)

            expect(subject.workspaces).to eq([workspace1])
          end
        end

        context 'with a multiple workspace configs' do
          let(:workspace1) { instance_double(Futon::Workspace) }
          let(:workspace2) { instance_double(Futon::Workspace) }
          let(:raw_options) do
            {
              workspaces: {
                'foo' => { foo_option: 'foo1' },
                'bar' => { bar_option: 'bar1' }
              }
            }
          end

          it 'creates multiple workspace instances' do
            allow(Futon::Workspace).to receive(:new)
              .with(name: 'foo', foo_option: 'foo1').and_return(workspace1)
            allow(Futon::Workspace).to receive(:new)
              .with(name: 'bar', bar_option: 'bar1').and_return(workspace2)
            expect(subject.workspaces).to eq([workspace1, workspace2])
          end
        end
      end
    end
  end
end
