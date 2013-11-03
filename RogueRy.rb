require File.dirname(__FILE__) + '/config/boot.rb'
Dir[File.dirname(__FILE__) + '/src/**/*.rb'].each { |f| require f }

Engine.instance.start(CursesIOWrapper.new)
