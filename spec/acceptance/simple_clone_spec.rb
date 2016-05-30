RSpec.describe 'simple restore/checkout', type: :feature do
  context 'with a valid setup' do
    let(:script) { 'fixtures/simple_restore' }
    let(:checkout_path) { '/home/guest/futon' }
    let(:full_script_path) { "#{checkout_path}/spec/acceptance/#{script}" }

    it 'works' do
      cmd = "docker-compose run --rm specs_image #{full_script_path}"
      expect(system(cmd)).to be
    end
  end
end
