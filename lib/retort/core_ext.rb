class Fixnum
  def truth
    return [false,true][self] if (0..1).member? self
  end
end

class Float
  def percent
    (self * 100).to_i
  end
end

