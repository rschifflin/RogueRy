require File.dirname(__FILE__) + '/config/boot.rb'

Engine.instance.configure(
  input: CursesIOWrapper, 
  draw: CursesIOWrapper
)

Engine.instance.start
