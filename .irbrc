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

@home    = "~"
@desk    = "~/Desktop"
@code    = "~/Desktop/code"
@myruby  = "~/Desktop/clones/myruby"
@myrails = "~/Desktop/clones/myrails"
@clones  = "~/Desktop/clones"
@source  = "~/Desktop/source"
@gems    = "~/.rvm/gems"

@files = Proc.new do
  instance_variables.each do |iv|
    next if iv =~ /prompt|files/
      print "#{iv}: ", instance_variable_get(iv), "\n"
  end
  nil
end

def h
  help
end

def e
  quit
end

def myfiles
  @files.call
end

def loaded_gems
  $:.select do |p|
    p =~ /rvm\/gems/
  end.each do |_p|
      puts _p
  end
  nil
end

class Object
  def local_methods
    if self.instance_of?(Class)
      (methods - Class.methods).sort
    else
    (methods - Object.instance_methods).sort
    end
  end
end

class Module
  def ancestor_type
    ancestors = self.ancestors
    ancestors.reverse_each do |mod|
      if mod.instance_of? Module
        puts mod.to_s + " (module)"
      elsif mod.instance_of? Class
        puts mod.to_s + " (class)"
      end
    end
  end
end

