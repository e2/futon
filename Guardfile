image_modifiers = %w(
  Dockerfile.specs
  docker-compose.yml
  Gemfile
  Gemfile.lock
  futon.gemspec
  spec/acceptance/fixtures/install_gem_from_cache
)

test_modifiers = %w(
  spec/acceptance/fixtures/simple_restore
)

acceptance_specs = %w(
  spec/acceptance/simple_clone_spec.rb
)

(image_modifiers + test_modifiers + acceptance_specs).each do |file|
  raise "Missing file: #{file.inspect}" unless File.exist?(file)
end

module GuardBlockWrapper
  def around_guard(filename)
    @guard_block_wrapper = proc do |original_guard_body_block|
      yield(original_guard_body_block)
    end

    instance_eval(IO.read(filename), filename, 1)
    @guard_block_wrapper = nil
  end

  def guard(*args, &block)
    return super unless @guard_block_wrapper
    super(*args) { @guard_block_wrapper.call(block) }
  end

  def template_path_for(name)
    filename = ".guard/#{name}.rb"
    return filename if File.exist?(filename)
    raise NotImplementedError
  end
end

self.class.prepend GuardBlockWrapper

group :specs, halt_on_fail: true do
  builder = proc { system('docker-compose build') }
  guard :yield, run_on_modifications: builder do
    image_modifiers.each { |file| watch(file) }
  end

  around_guard(template_path_for(:rspec)) do |guard_body_block|
    guard_body_block.call

    (image_modifiers + test_modifiers).each do |file|
      watch(file) { acceptance_specs }
    end
  end

  guard :rubocop do
    watch(/.+\.rb$/)
    watch(%r{(?:.+/)?\.rubocop\.yml$}) { |m| File.dirname(m[0]) }
    watch('.rubocop_todo.yml') { |m| File.dirname(m[0]) }
  end
end
