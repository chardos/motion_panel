$:.unshift('/Library/RubyMotion/lib')
require 'motion/project/template/ios'
require './lib/motion_panel'

begin
  require 'bundler'
  require 'motion/project/template/gem/gem_tasks'
  Bundler.require
rescue LoadError
end

Motion::Project::App.setup do |app|
  app.detect_dependencies = false
  app.name = 'motion_panel'
end

task :spec do
  App.config.spec_mode = true
  spec_files = App.config.spec_files
  App.config.instance_variable_set("@spec_files", spec_files)
  Rake::Task['simulator'].invoke
end
