#set up the load path
$:.unshift(File.expand_path("../../src/", __FILE__))
$:.unshift(File.expand_path("../../src/base/", __FILE__))
$:.unshift(File.expand_path("../../src/curses/", __FILE__))

#Libraries
Dir[File.dirname(__FILE__) + '/../lib/**/*.rb'].each { |f| require f }

#Base classes
Dir[File.dirname(__FILE__) + '/../src/base/**/*.rb'].each { |f| require f }

#Curses classes
Dir[File.dirname(__FILE__) + '/../src/curses/**/*.rb'].each { |f| require f }

#Engine classes
Dir[File.dirname(__FILE__) + '/../src/engine/**/*.rb'].each { |f| require f }

#All others
Dir[File.dirname(__FILE__) + '/../src/**/*.rb'].each { |f| require f }
