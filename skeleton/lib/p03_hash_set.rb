require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    resize! if count >= num_buckets
    self[key] << key unless include?(key)
    @count += 1
  end

  def include?(key)
    self[key].include?(key)
  end

  def remove(key)
    self[key].delete(key) if include?(key)
  end

  private

  def [](key)
    @store[key.hash % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    old_store = @store.flatten
    @store = Array.new(num_buckets * 2){Array.new}

    old_store.each do |item|
      insert(item)
      @count -= 1
    end
  end
end
