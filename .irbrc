require 'pp'
require 'fileutils'

def require_or_msg(lib)
  require lib
  yield if block_given?
rescue LoadError => e
  puts e.message if e.message
end

def require_and_puts(lib)
  puts "requiring #{lib}"
  require_or_msg lib
end

require_and_puts "rubygems" do
  require 'interactive_editor'
end

if ENV['GEM_PATH'] =~ /rails/
  require_and_puts 'active_support/all'
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
