#!/usr/bin/ruby

# Copyright (c) 2015 Ryan Skonnord
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

class Person
  attr_accessor :name

  def introduce
    puts "Hello, my name is #{@name}."
  end
end

class Wizard < Person
  attr_accessor :weapon

  def cast_spell(spell)
    puts "I cast the #{spell} spell!"
  end
end

sam = Person.new
sam.name = 'Sam'
sam.introduce
puts

gandalf = Wizard.new
gandalf.name = 'Gandalf'
gandalf.introduce
gandalf.cast_spell('Light')
puts

class FireWizard < Wizard
  def cast_spell(spell)
    super
    if spell == 'Fire'
      puts "My favorite!"
    end
  end
end

gandalf.cast_spell('Fire')
puts

chandra = FireWizard.new
chandra.cast_spell('Fire')
