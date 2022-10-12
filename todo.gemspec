# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name                   = 'todo'
  spec.version                = '0.1.0'
  spec.authors                = ['Spenser Black']
  spec.email                  = ['spenserblack01@gmail.com']

  spec.summary                = 'A simple todo list manager'
  spec.description            = 'Manages multiple todo lists in $HOME/.todo'

  spec.homepage               = 'https://github.com/spenserblack/todo.rb'
  spec.license                = 'MIT'
  spec.required_ruby_version  = Gem::Requirement.new('>= 2.7.0')

  # spec.metadata['allowed_push_host'] = '' # TODO: Set?

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/spenserblakc/todo.rb'

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end

  spec.bindir                = 'exe'
  spec.executables           = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths         = ['lib']

  spec.metadata['rubygems_mfa_required'] = 'true'
end
