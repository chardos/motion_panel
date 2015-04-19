# -*- encoding: utf-8 -*-

$:.push File.expand_path("../lib", __FILE__)
require "motion_panel/version"

Gem::Specification.new do |s|
  s.name = 'motion_panel'
  s.version = Mixpanel::VERSION
  s.summary = 'Native Rubymotion gem for Mixpanel'
  s.description = 'A native Rubymotion wrapper around the Mixpanel API'
  s.authors     = ['Thomas Broomfield']
  s.homepage = 'https://github.com/tombroomfield/motion_panel'
  s.license = 'MIT'

  files = []
  files << 'README.md'
  files << 'LICENSE.md'
  files.concat(Dir.glob('lib/**/*.rb'))
  s.files = files

  s.add_dependency 'motion-support', '~> 0.2.6'
  s.add_dependency 'bubble-wrap', '~> 1.8'
  s.add_dependency 'afmotion', '2.5'
  s.add_development_dependency 'rake'
end
