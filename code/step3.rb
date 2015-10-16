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

def make_object(message_table)
  return (lambda do |message, *message_args|
            message_table[message].call(*message_args)
          end)
end

def ask(object, message, *message_args)
  return object.call(message, *message_args)
end

def make_class()
  class_message_table = {}
  new_class = make_object(class_message_table)

  class_message_table[:instantiate] = lambda do | |
    fields = {}
    instance_message_table = {}
    new_instance = make_object(instance_message_table)

    instance_message_table[:get_field] = lambda do |field_name|
      return fields[field_name]
    end

    instance_message_table[:set_field] = lambda do |field_name, value|
      fields[field_name] = value
    end

    return new_instance
  end

  return new_class
end

Person = make_class()
sam = ask(Person, :instantiate)
ask(sam, :set_field, :name, 'Sam')
puts ask(sam, :get_field, :name)
