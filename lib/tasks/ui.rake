namespace :ui do
  namespace :curses do
    SRC_UI_DIR = "src/ui"
    SPEC_SRC_UI_DIR = "spec/src/ui"
    SRC_CURSES_DIR = "src/curses/ui"
    SPEC_SRC_CURSES_UI_DIR= "spec/src/curses/ui"

    directory SRC_UI_DIR
    directory SPEC_SRC_UI_DIR
    directory SRC_CURSES_DIR
    directory SPEC_SRC_CURSES_UI_DIR

    desc "Remove UI element, Curses element and corresponding tests"
    task :delete, [:name] do |t, args|

      if args.name
        element_file = "#{SRC_UI_DIR}/ui_#{args.name.to_snake}.rb"
        element_spec_file = "#{SPEC_SRC_UI_DIR}/ui_#{args.name.to_snake}_spec.rb"
        curses_file = "#{SRC_CURSES_DIR}/curses_ui_#{args.name.to_snake}.rb"
        curses_spec_file = "#{SPEC_SRC_CURSES_UI_DIR}/curses_ui_#{args.name.to_snake}_spec.rb"

        delete_file element_file
        delete_file element_spec_file
        delete_file curses_file
        delete_file curses_spec_file
      else
        puts "Element name required. Syntax: ui:curses:delete[name]" 
      end
    end

    desc "Generate UI element, Curses element and corresponding tests"
    task :new, [:name] => [SRC_UI_DIR, SPEC_SRC_UI_DIR, SRC_CURSES_DIR, SPEC_SRC_CURSES_UI_DIR] do |t, args|
      if args.name
        element_file = "#{SRC_UI_DIR}/ui_#{args.name.to_snake}.rb"
        element_spec_file = "#{SPEC_SRC_UI_DIR}/ui_#{args.name.to_snake}_spec.rb"
        curses_file = "#{SRC_CURSES_DIR}/curses_ui_#{args.name.to_snake}.rb"
        curses_spec_file = "#{SPEC_SRC_CURSES_UI_DIR}/curses_ui_#{args.name.to_snake}_spec.rb"
        
        create_file element_file, 
          <<-contents
class UI#{args.name.to_camel} < UIElement
end
          contents
        
        create_file element_spec_file, 
          <<-contents
require 'spec_helper'

describe UI#{args.name.to_camel} do
end
          contents

        create_file curses_file, 
          <<-contents
class CursesUI#{args.name.to_camel} < CursesUIElement
  def update_from ui_element
    super
    # UI#{args.name.to_camel}-specific copy logic goes here
  end

  def render output
    output = output.dup
    # Output is the existing array of curses strings that will be drawn to the screen.
    # Modify the duplicated output (for example, using string#merge) to specify how this element will be rendered
    output
  end
end
          contents
        create_file curses_spec_file,
          <<-contents
require 'spec_helper'

describe CursesUI#{args.name.to_camel} do
  subject(#{args.name.to_snake}) { UI#{args.name.to_camel}.new }
  describe "#render" do
    it "renders correctly" do
      pending "Test CursesUI#{args.name.to_camel} rendering logic here"
    end
  end
end
          contents
      else
        puts "Element name required. Syntax: ui:curses:new[name]" 
      end
    end

    def create_file filepath, contents
      unless File.file?(filepath)
        File.open(filepath, 'w') do |f| 
          f.write(contents) 
        end 
        puts "Created file: #{filepath}"
      end
    end

    def delete_file filepath
      if File.file?(filepath)
        File.delete(filepath) 
        puts "Removed file: #{filepath}"
      end
    end


  end
end
