#set up the load path
$:.unshift(File.expand_path("../../src/", __FILE__))
$:.unshift(File.expand_path("../../lib/", __FILE__))

#Require libraries
Dir[File.dirname(__FILE__) + '/../lib/**/*.rb'].each { |f| require f }
