# University of Washington, Programming Languages, Homework 7, hw7.rb
# (See also ML code)

# a little language for 2D geometry objects

# each subclass of GeometryExpression, including subclasses of GeometryValue,
#  needs to respond to messages preprocess_prog and eval_prog
#
# each subclass of GeometryValue additionally needs:
#   * shift
#   * intersect, which uses the double-dispatch pattern
#   * intersectPoint, intersectLine, and intersectVerticalLine for
#       for being called by intersect of appropriate clases and doing
#       the correct intersection calculuation
#   * (We would need intersectNoPoints and intersectLineSegment, but these
#      are provided by GeometryValue and should not be overridden.)
#   *  intersectWithSegmentAsLineResult, which is used by
#      intersectLineSegment as described in the assignment
#
# you can define other helper methods, but will not find much need to

# Note: geometry objects should be immutable: assign to fields only during
#       object construction

# Note: For eval_prog, represent environments as arrays of 2-element arrays
# as described in the assignment

class GeometryExpression
  # do *not* change this class definition
  Epsilon = 0.00001
end

class GeometryValue
  # do *not* change methods in this class definition
  # you can add methods if you wish

  private
  # some helper methods that may be generally useful
  def real_close(r1,r2)
    (r1 - r2).abs < GeometryExpression::Epsilon
  end
  def real_close_point(x1,y1,x2,y2)
    real_close(x1,x2) && real_close(y1,y2)
  end
  # two_points_to_line could return a Line or a VerticalLine
  def two_points_to_line(x1,y1,x2,y2)
    if real_close(x1,x2)
      VerticalLine.new x1
    else
      m = (y2 - y1).to_f / (x2 - x1)
      b = y1 - m * x1
      Line.new(m,b)
    end
  end

  public
  # we put this in this class so all subclasses can inherit it:
  # the intersection of self with a NoPoints is a NoPoints object
  def intersectNoPoints np
    np # could also have NoPoints.new here instead
  end

  # we put this in this class so all subclasses can inhert it:
  # the intersection of self with a LineSegment is computed by
  # first intersecting with the line containing the segment and then
  # calling the result's intersectWithSegmentAsLineResult with the segment
  def intersectLineSegment seg
    line_result = intersect(two_points_to_line(seg.x1,seg.y1,seg.x2,seg.y2))
    line_result.intersectWithSegmentAsLineResult seg
  end

  def eval_prog env
    self # all values evaluate to self
  end
  def preprocess_prog
    self # no pre-processing to do here
  end
  def shift(dx,dy)
    self # shifting no-points is no-points
  end
end

class NoPoints < GeometryValue
  # do *not* change this class definition: everything is done for you
  # (although this is the easiest class, it shows what methods every subclass
  # of geometry values needs)

  def intersect other
    other.intersectNoPoints self # will be NoPoints but follow double-dispatch
  end
  def intersectPoint p
    self # intersection with point and no-points is no-points
  end
  def intersectLine line
    self # intersection with line and no-points is no-points
  end
  def intersectVerticalLine vline
    self # intersection with line and no-points is no-points
  end
  # if self is the intersection of (1) some shape s and (2)
  # the line containing seg, then we return the intersection of the
  # shape s and the seg.  seg is an instance of LineSegment
  def intersectWithSegmentAsLineResult seg
    self
  end
end


class Point < GeometryValue
  attr_reader :x, :y
  def initialize(x,y)
    @x = x
    @y = y
  end

  def shift(dx, dy)
    Point.new(@x + dx, @y + dy)
  end
  def intersect other
    other.intersectPoint self
  end
  def intersectPoint other
    return self if real_close_point(@x, @y, other.x, other.y)
    NoPoints.new
  end
  def intersectLine other
    return self if real_close(@y, other.m * @x + other.b)
    NoPoints.new
  end
  def intersectVerticalLine other
    return self if real_close(@x, other.x)
    NoPoints.new
  end
  def intersectWithSegmentAsLineResult seg
    if inbetween(@x, seg.x1, seg.x2) and inbetween(@y, seg.y1, seg.y2)
        return self
    end
    NoPoints.new
  end

  private
  def inbetween(v, end1, end2)
    e = GeometryExpression::Epsilon
    (end1 - e <= v and v <= end2 + e) or (end2 - e <= v and v <= end1 + e)
  end
end

class Line < GeometryValue
  attr_reader :m, :b
  def initialize(m,b)
    @m = m
    @b = b
  end

  def shift(dx, dy)
    Line.new(@m, @b + dy - @m * dx)
  end
  def intersect other
    other.intersectLine self
  end
  def intersectPoint other
    other.intersectLine self
  end
  def intersectLine other
    if real_close(@m, other.m) then
      if real_close(@b, other.b) then
        self
      else
        NoPoints.new
      end
    else
      x = (other.b - @b) / (@m - other.m)
      y = @m * x + @b
      Point.new(x, y)
    end
  end
  def intersectVerticalLine other
    Point.new(other.x, @m * other.x + @b)
  end
  def intersectWithSegmentAsLineResult seg
    seg
  end
end

class VerticalLine < GeometryValue
  attr_reader :x
  def initialize x
    @x = x
  end

  def shift(dx, dy)
    VerticalLine.new(@x + dx)
  end
  def intersect other
    other.intersectVerticalLine self
  end
  def intersectPoint other
    other.intersectVerticalLine self
  end
  def intersectLine other
    other.intersectVerticalLine self
  end
  def intersectVerticalLine other
    return self if real_close(@x, other.x)
    NoPoints.new
  end
  def intersectWithSegmentAsLineResult seg
    seg
  end
end

class LineSegment < GeometryValue
  attr_reader :x1, :y1, :x2, :y2
  def initialize (x1,y1,x2,y2)
    @x1 = x1
    @y1 = y1
    @x2 = x2
    @y2 = y2
  end

  def preprocess_prog
    c1 = real_close(@x1, @x2); c2 = real_close(@y1, @y2)
    return Point.new(@x1, @y1) if c1 and c2
    return LineSegment.new(x2, y2, x1, y1) if (x2 < x1) or (c1 and y2 < y1)
    self
  end
  def shift(dx, dy)
    LineSegment.new(@x1 + dx, @y1 + dy, @x2 + dx, @y2 + dy)
  end
  def intersect other
    other.intersectLineSegment self
  end
  def intersectPoint other
    other.intersectLineSegment self
  end
  def intersectLine other
    other.intersectLineSegment self
  end
  def intersectVerticalLine other
    other.intersectLineSegment self
  end
  def intersectWithSegmentAsLineResult seg
    if real_close(@x1,@x2)
      tseg1,tseg2 = @y1 < seg.y1 ? [self,seg] : [seg,self]
      case
        when real_close(tseg1.y2, tseg2.y1) then Point.new(tseg1.x2,tseg1.y2)
        when tseg1.y2 < tseg2.y1 then NoPoints.new
        when tseg1.y2 > tseg2.y2 then LineSegment.new(tseg2.x1,tseg2.y1,tseg2.x2,tseg2.y2)
        else LineSegment.new(tseg2.x1,tseg2.y1,tseg1.x2,tseg1.y2)
      end
    else
      tseg1,tseg2 = @x1 < seg.x1 ? [self,seg] : [seg,self]
      case
        when real_close(tseg1.x2,tseg2.x1) then Point.new(tseg1.x2,tseg1.y2)
        when tseg1.x2 < tseg2.x1 then NoPoints.new
        when tseg1.x2 > tseg2.x2 then LineSegment.new(tseg2.x1,tseg2.y1,tseg2.x2,tseg2.y2)
        else LineSegment.new(tseg2.x1,tseg2.y1,tseg1.x2,tseg1.y2)
      end
    end
  end
end

# Note: there is no need for getter methods for the non-value classes
class Intersect < GeometryExpression
  def initialize(e1,e2)
    @e1 = e1
    @e2 = e2
  end
  def preprocess_prog
    Intersect.new(@e1.preprocess_prog, @e2.preprocess_prog)
  end
  def eval_prog env
    @e1.eval_prog(env).intersect(@e2.eval_prog(env))
  end
end

class Let < GeometryExpression
  def initialize(s,e1,e2)
    @s = s
    @e1 = e1
    @e2 = e2
  end

  def preprocess_prog
    Let.new(@s, @e1.preprocess_prog, @e2.preprocess_prog)
  end
  def eval_prog env
    @e2.eval_prog([[@s, @e1.eval_prog(env)]] + env)
  end
end

class Var < GeometryExpression
  def initialize s
    @s = s
  end
  def preprocess_prog
    self
  end
  def eval_prog env
    pr = env.assoc @s
    raise "undefined variable" if pr.nil?
    pr[1]
  end
end

class Shift < GeometryExpression
  def initialize(dx,dy,e)
    @dx = dx
    @dy = dy
    @e = e
  end
  def preprocess_prog
    Shift.new(@dx, @dy, @e.preprocess_prog)
  end
  def eval_prog env
    @e.eval_prog(env).shift(@dx, @dy)
  end
end
