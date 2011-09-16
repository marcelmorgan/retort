class Fixnum
  def truth
    return [false,true][self] if (0..1).member? self
  end
end

class Float
  def percent_raw
    (self * 100).to_i
  end

  def percent
    "#{percent_raw}%"
  end
end

