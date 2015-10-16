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
  attr_accessor :weapon

  def introduce
    puts "Hello, my name is #{@name}."
  end

  def drink_tea
    puts 'Slurp'
  end

  def fight(target)
    unless @weapon.nil?
      puts "#{@name} fights #{target.name}. #{@weapon.attack}"
    end
  end
end

class Wizard < Person
  attr_accessor :hat_color
  attr_accessor :is_humble
  
  def introduce
    if is_humble then
      super
    else
      puts "Lo, behold, I am #{name} the #{hat_color}."
    end
  end

end

sam = Person.new
sam.name = 'Sam'
sam.introduce

gandalf = Wizard.new
gandalf.name = 'Gandalf'
gandalf.hat_color = 'Grey'
gandalf.introduce

saruman = Wizard.new
saruman.name = 'Saruman'
saruman.hat_color = 'White'
saruman.introduce

gandalf.is_humble = true
gandalf.introduce

class Staff
  def attack
    'Zap!'
  end
end

class FireStaff < Staff
  def attack
    'Fwoosh! Kaboom!'
  end
end

class FrostStaff < Staff
  def attack
    'Brr! Crack!'
  end
end

gandalf.weapon = FireStaff.new
saruman.weapon = FrostStaff.new
gandalf.fight(saruman)
saruman.fight(gandalf)
