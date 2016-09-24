require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  include Enumerable
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    @store[bucket(key)].include?(key)
  end

  def set(key, val)
    resize! if @count >= num_buckets

    @store[bucket(key)].insert(key, val)
    @count += 1
  end

  def get(key)
    linked_list = @store[bucket(key)]
    linked_list.get(key)
  end

  def delete(key)
    @store[bucket(key)].remove(key)
    @count -= 1
  end

  def each
    @store.each do |bucket|
      next if bucket.empty?
      bucket.each do |current_link|
        yield(current_link.key, current_link.val)
      end
    end
  end

  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    old_hash = self.dup
    @store = Array.new(num_buckets * 2){LinkedList.new}

    old_hash.each do |k, v|
      set(k,v)
      @count -= 1
    end
  end

  def bucket(key)
    key.hash % num_buckets
  end

end
