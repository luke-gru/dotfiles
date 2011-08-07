require 'pp'
require 'fileutils'

def require_or_msg(lib, msg = nil)
  require lib
  yield if block_given?
rescue LoadError
  puts msg if msg
end

require_or_msg "rubygems" do
  require_or_msg "interactive_editor"
end

@home   = "~"
@desk   = "~/Desktop"
@code   = "~/Desktop/code"
@myruby = "~/Desktop/clones/ruby"
@clones = "~/Desktop/clones"
@source = "~/Desktop/source"
@gems   = "~/.rvm/gems"

@files = Proc.new do
  instance_variables.each do |iv|
    next if iv =~ /prompt|files/
      print "#{iv}: ", instance_variable_get(iv), "\n"
  end
  nil
end

def myfiles
  @files.call
end

class Object
  def local_methods
    (methods - Object.instance_methods).sort
  end
end

