require 'rubygems'
require 'interactive_editor'
require 'pp'
@home = "~"
@desk = "~/Desktop"
@code = "~/Desktop/code"
@myruby = "~/Desktop/clones/ruby"
@clones = "~/Desktop/clones"
@source = "~/Desktop/source"

@files = Proc.new do
  instance_variables.each do |iv|
    next if iv =~ /prompt|files/
      print "#{iv}: ", instance_variable_get(iv), "\n"
  end
  nil
end
