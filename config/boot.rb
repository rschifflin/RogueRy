#set up the load path
$:.unshift(File.expand_path("../../src/", __FILE__))
$:.unshift(File.expand_path("../../src/base/", __FILE__))
$:.unshift(File.expand_path("../../src/curses/", __FILE__))

#Base classes
Dir[File.dirname(__FILE__) + '/../src/base/**/*.rb'].each { |f| require f }

#Curses classes
Dir[File.dirname(__FILE__) + '/../src/curses/**/*.rb'].each { |f| require f }

#All others
Dir[File.dirname(__FILE__) + '/../src/**/*.rb'].each { |f| require f }
