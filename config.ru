root= File.expand_path "..", __FILE__
require "#{root}/application_base.rb"
require "#{root}/models.rb"
require "#{root}/application.rb"

map("/") {run Application}
