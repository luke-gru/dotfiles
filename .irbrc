require 'pp'
require 'fileutils'

def require_and_msg(lib)
  begin
    require lib
  rescue LoadError => e
    puts "couldn't load #{lib}"
    return
  end
  puts "loaded #{lib}"
end

def _require(lib)
  require lib
  libs = yield
  libs.each {|l| require_and_msg l}
end

_require "rubygems" do
  [].tap do |libs|
    libs << 'interactive_editor'
    libs << 'active_support/all'
  end
end

def h
  help
end

def e
  quit
end
alias q e

def ls
  files = Dir.glob('*').sort
  files.each do |f|
    if Dir.exists? f
      puts f + '/'
    else
      puts f
    end
  end
  nil
end

def loaded_gems
  $:.select do |p|
    p =~ /rvm\/gems/
  end.each do |_p|
      puts _p
  end
  nil
end

def add_load_path(dir=`pwd`)
  dir.chomp! if dir[-1] == "\n"
  $:.unshift dir
  dir << '/' unless dir[-1] == '/'
  files = Dir.glob("#{dir}*")
  files.each {|f| f << '/' if Dir.exists? f}
end

class Object
  def local_methods
    if self.instance_of?(Class)
      (methods - Class.instance_methods).sort
    else
      (methods - Object.instance_methods).sort
    end
  end
end

class Class
  def local_instance_methods
    (instance_methods - Class.instance_methods).sort
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

class Range
  def method_missing(method, *args, &block)
    if [].respond_to? method
      to_a.__send__(method, *args, &block)
    else
      super
    end
  end
end
