require 'byebug'

class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    return 0.hash + nil.hash if self.empty?

    hash_array = []
    self.each_with_index do |el, i|
      hash_array += [el.hash + i]
    end
    hash_array.inject(&:^).hash
  end
end

class String
  def hash
    hash= []
    self.each_char.with_index do |char , i|
      hash << char.ord + i
    end
    hash.join('').to_i.hash
  end
end


class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    return 0.hash ^ nil.hash if self.empty?

    hash_array = []

    self.each do |k, v|
      hash_array += [k.hash, v.hash]
    end

    hash_array.inject(&:^).hash
  end
end
