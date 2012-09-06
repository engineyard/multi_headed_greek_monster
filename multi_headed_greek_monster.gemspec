# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "multi_headed_greek_monster"
  s.version = "0.0.1"
  s.author = "Jacob"
  s.email = "jacob@engineyard.com"
  s.homepage = "https://github.com/engineyard/multi_headed_greek_monster"
  s.summary = "parallelize stuff"

  s.files = Dir.glob("{lib}/**/*") + %w(MIT-LICENSE README.rdoc)
  s.require_path = 'lib'

  s.add_development_dependency('cubbyhole')

  s.required_rubygems_version = %q{>= 1.3.6}
  s.test_files = Dir.glob("test/**/*")
end
