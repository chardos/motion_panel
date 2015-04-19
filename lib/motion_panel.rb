unless defined?(Motion::Project::Config)
  raise "This file must be required within a RubyMotion project Rakefile."
end

require 'bubble-wrap/core'
require 'motion-support'

Motion::Project::App.setup do |app|
  Dir.glob(File.join(File.dirname(__FILE__), 'motion_panel/*.rb')).each do |file|
    app.files.unshift(file)
  end
  Dir.glob(File.join(File.dirname(__FILE__), 'motion_panel/errors/*.rb')).each do |file|
    app.files.unshift(file)
  end
end
