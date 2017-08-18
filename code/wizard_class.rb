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

def make_class(parents, method_table)
  class_message_table = {}
  new_class = make_object(class_message_table)

  class_message_table[:get_method] = lambda do |method_name|
    method = nil
    if method_table.has_key? method_name
      method = method_table[method_name]
    else
      parents.each do |parent|
        method = ask(parent, :get_method, method_name)
        unless method.nil?
          break
        end
      end
    end
    return method
  end

  class_message_table[:get_usual_method] = lambda do |method_name|
    return method_table[method_name]
  end

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

    instance_message_table[:call_method] = lambda do |method_name, *method_args|
      method = ask(new_class, :get_method, method_name)
      return method.call(new_instance, *method_args)
    end

    instance_message_table[:call_usual_method] = lambda do |class_obj, method_name, *method_args|
      method = ask(class_obj, :get_usual_method, method_name)
      return method.call(new_instance, *method_args)
    end

    return new_instance
  end

  return new_class
end


Person = make_class([],
                    {
                      :introduce => lambda do |this|
                        name = ask(this, :get_field, :name)
                        puts "Hello, my name is #{name}."
                      end,
                    })

sam = ask(Person, :instantiate)
ask(sam, :set_field, :name, 'Sam')
ask(sam, :call_method, :introduce)
puts

Wizard = make_class([Person],
                    {
                      :cast_spell => lambda do |this, spell|
                        puts "I cast the #{spell} spell!"
                      end,
                    })

gandalf = ask(Wizard, :instantiate)
ask(gandalf, :set_field, :name, 'Gandalf')
ask(gandalf, :call_method, :introduce)
ask(gandalf, :call_method, :cast_spell, 'Light')
puts

FireWizard = make_class([Wizard],
                        {
                          :cast_spell => lambda do |this, spell|
                            ask(this, :call_usual_method, Wizard, :cast_spell, spell)
                            if spell == 'Fire'
                              puts "My favorite!"
                            end
                          end,
                        })

ask(gandalf, :call_method, :cast_spell, 'Fire')
puts

chandra = ask(FireWizard, :instantiate)
ask(chandra, :call_method, :cast_spell, 'Fire')
