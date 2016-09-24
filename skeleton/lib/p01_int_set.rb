class MaxIntSet
  def initialize(max)
    @store = Array.new(max+1) {false}
  end

  def insert(num)
    return @store[num] = true if is_valid?(num)
    raise "Out of bounds"
  end

  def remove(num)
    @store[num] = false if is_valid?(num)
  end

  def include?(num)
    @store[num] if is_valid?(num)
  end

  private

  def is_valid?(num)
    num.between?(0, (@store.length - 1))
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    unless include?(num)
      self[num] << num
    end
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].any? { |x| x == num}
  end

  private

  def bucket_num(num)
    num % num_buckets
  end
  #
  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    resize! if count >= num_buckets

    unless include?(num)
      self[num] << num
      @count += 1
    end
  end

  def remove(num)
    self[num].delete(num) if include?(num)
  end

  def include?(num)
    self[num].any? { |x| x == num}
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
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
