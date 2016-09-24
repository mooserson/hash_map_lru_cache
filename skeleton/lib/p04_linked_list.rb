require 'byebug'
class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end
end

class LinkedList
  include Enumerable

  def initialize
    @first = Link.new
    @last = Link.new
    @first.next = @last
    @last.prev = @first
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @first.next unless empty?
  end

  def last
    @last.prev unless empty?
  end

  def empty?
    @first.next == @last
  end

  def get(key)
    return nil if empty?
    self.each{|link| return link.val if link.key == key}
  end

  def include?(key)
    get(key).nil? == false
  end

  def insert(key, val)

    if include?(key)
      remove(key)
    end

    l = Link.new(key, val)
    l.prev = @last.prev
    l.next = @last
    @last.prev.next = l
    @last.prev = l
    # end
  end

  def remove(key)
    self.each do |link|
      if link.key == key
        link.prev.next = link.next
        link.next.prev = link.prev
      end
    end
  end

  def each(&prc)
    # debugger
    current_link = self.first
    until current_link == @last
      prc.call(current_link)
      current_link = current_link.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end

end

l = LinkedList.new
l.insert(:first, 1)
l.insert(:second, 2)
l.insert(:third, 3)
