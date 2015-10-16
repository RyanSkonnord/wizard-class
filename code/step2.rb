#!/usr/bin/ruby

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
    instance_message_table = {}
    new_instance = make_object(instance_message_table)
    return new_instance
  end

  return new_class
end

Person = make_class()
sam = ask(Person, :instantiate)
puts sam
