# frozen_string_literal: true

class LinkedList
  def initialize(list = [])
    @list = list
  end

  def size
    @list.size
  end

  def tail
    @list[-1]
  end

  def head
    @list[0]
  end

  def at(index)
    @list[index]
  end

  def append(node)
    tail.next_node = size if @list != []
    @list.append(node)
  end

  def prepend(node)
    @list.each do |i|
      i.next_node += 1 unless i.next_node.nil?
    end
    @list.prepend(node)
    head.next_node = 1
  end

  def pop
    @list.pop
    tail.next_node = nil
  end

  def find(value)
    return nil if @list == []

    current = head
    until current.next_node.nil?
      return current.next_node - 1 if current.value == value

      current = @list[current.next_node]
    end
    nil
  end

  def contains?(value)
    return true if find(value)

    false
  end

  def to_s
    string = ''
    current = head
    until current.next_node.nil?
      string += "( #{current.value} ) -> "
      current = @list[current.next_node]
    end
    string + "( #{current.value} ) -> nil"
  end

  def insert_at(index, value)
    @list.insert(index, value)
    @list[index - 1].next_node = index
    current = @list[index]
    until current.nil?
      return if current.next_node.nil?
      current.next_node += 1
      current = @list[current.next_node]
    end
  end

  def remove_at(index)
    @list[index - 1].next_node = nil if @list[index] == tail
    @list.delete_at(index)
    current = @list[index]
    until current.nil?
      return if current.next_node.nil?
      current.next_node -= 1
      current = @list[current.next_node]
    end
  end
end

class Node
  attr_reader :value
  attr_accessor :next_node

  def initialize(value = nil, next_node = nil)
    @value = value
    @next_node = next_node
  end
end

list = LinkedList.new
100.times do |i|
  list.append(Node.new(i))
end
list.prepend(Node.new('Any data type.'))
list.remove_at(0)
puts list
puts list.find(55)
