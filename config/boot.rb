#set up the load path
$:.unshift(File.expand_path("../../src/", __FILE__))

#Load source files
Dir[File.dirname(__FILE__) + '/../src/**/*.rb'].each { |f| require f }
