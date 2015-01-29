# University of Washington, Programming Languages, Homework 7,
# hw7testsprovided.rb

require "./hw7.rb"

#  Will not work completely until you implement all the classes and their methods

# Will print only if code has errors; prints nothing if all tests pass

# These tests do NOT cover all the various cases, especially for intersection

#Constants for testing
ZERO = 0.0
ONE = 1.0
TWO = 2.0
THREE = 3.0
FOUR = 4.0
FIVE = 5.0
SIX = 6.0
SEVEN = 7.0
TEN = 10.0

#Point Tests
a = Point.new(THREE,FIVE)
if not (a.x == THREE and a.y == FIVE)
	puts "Point is not initialized properly"
end
if not (a.eval_prog([]) == a)
	puts "Point eval_prog should return self"
end
if not (a.preprocess_prog == a)
	puts "Point preprocess_prog should return self"
end
a1 = a.shift(THREE,FIVE)
if not (a1.x == SIX and a1.y == TEN)
	puts "Point shift not working properly"
end
a1 = a1.shift(ZERO, ZERO)
if not (a1.x == SIX and a1.y == TEN)
	puts "Point shift not working properly"
end
if not (a.x == THREE and a.y == FIVE)
  puts "Point mutated"
end
a2 = a.intersect(Point.new(THREE,FIVE))
if not (a2.x == THREE and a2.y == FIVE)
	puts "Point intersect not working properly"
end
a3 = a.intersect(Point.new(FOUR,FIVE))
if not (a3.is_a? NoPoints)
	puts "Point intersect not working properly"
end
a4 = Point.new(3,3).intersect(Line.new(1, 0))
if not (a4.x == 3 and a4.y == 3)
	puts "Point intersect with Line not working properly"
end
a5 = Point.new(4,3).intersect(Line.new(1, 0))
if not (a5.is_a? NoPoints)
	puts "Point intersect with Line not working properly"
end
a6 = Point.new(4,3).intersect(VerticalLine.new(4))
if not (a6.x == 4 and a6.y == 3)
  puts "Point intersect with VerticalLine not working properly"
end
a7= Point.new(4,3).intersect(VerticalLine.new(3))
if not (a7.is_a? NoPoints)
  puts "Point intersect with VerticalLine not working properly"
end
a8 = Point.new(0,0).intersect(LineSegment.new(-1, -1, 1, 1))
if not (a8.x == 0 and a8.y == 0)
  puts "Point intersect with LineSegment not working properly"
end
a9 = Point.new(0,0).intersect(LineSegment.new(-1, -1, -2, -2))
if not (a9.is_a? NoPoints)
  puts "Point intersect with LineSegment not working properly"
end

#Line Tests
b = Line.new(THREE,FIVE)
if not (b.m == THREE and b.b == FIVE)
	puts "Line not initialized properly"
end
if not (b.eval_prog([]) == b)
	puts "Line eval_prog should return self"
end
if not (b.preprocess_prog == b)
	puts "Line preprocess_prog should return self"
end

b1 = b.shift(THREE,FIVE)
if not (b1.m == THREE and b1.b == ONE)
	puts "Line shift not working properly"
end
if not (b.m == THREE and b.b == FIVE)
  puts "Line mutated"
end
b2 = b.intersect(Line.new(THREE,FIVE))
if not (((b2.is_a? Line)) and b2.m == THREE and b2.b == FIVE)
	puts "Line intersect not working properly"
end
b3 = b.intersect(Line.new(THREE,FOUR))
if not ((b3.is_a? NoPoints))
	puts "Line intersect not working properly"
end
b4 = Line.new(3, 4).intersect(Line.new(3,4))
if not ((b4.is_a? Line))
  puts "Line intersect with Line not working properly"
end
b5 = Line.new(1, 0).intersect(Line.new(-1,0))
if not (b5.x == 0 and b5.y == 0)
  puts "Line intersect with Line not working properly"
end
b6 = Line.new(1, 0).intersect(VerticalLine.new(1))
if not (b6.x == 1 and b6.y == 1)
  puts "Line intersect with VerticalLine not working properly"
end
b7 = Line.new(1, 0).intersect(LineSegment.new(-1, -1, 0, 0))
if not (b7.x1 == -1 and b7.y1 == -1 and b7.x2 == 0 and b7.y2 == 0)
  puts "Line intersect with LineSegment not working properly"
end
b8 = Line.new(1, 0).intersect(LineSegment.new(-2, -2, -1, -1))
if not (b8.x1 == -2 and b8.y1 == -2 and b8.x2 == -1 and b8.y2 == -1)
  puts "Line intersect with LineSegment not working properly"
end
b9 = Line.new(1, 1).intersect(LineSegment.new(-2, -2, -1, -1))
if not (b9.is_a? NoPoints)
  puts "Line intersect with LineSegment not working properly"
end

#VerticalLine Tests
c = VerticalLine.new(THREE)
if not (c.x == THREE)
	puts "VerticalLine not initialized properly"
end
if not (c.eval_prog([]) == c)
	puts "VerticalLine eval_prog should return self"
end
if not (c.preprocess_prog == c)
	puts "VerticalLine preprocess_prog should return self"
end
c1 = c.shift(THREE,FIVE)
if not (c1.x == SIX)
	puts "VerticalLine shift not working properly"
end
if not (c.x == THREE)
  puts "VerticalLine mutated"
end
c2 = c.intersect(VerticalLine.new(THREE))
if not ((c2.is_a? VerticalLine) and c2.x == THREE )
	puts "VerticalLine intersect not working properly"
end
c3 = c.intersect(VerticalLine.new(FOUR))
if not ((c3.is_a? NoPoints))
	puts "VerticalLine intersect not working properly"
end
c4 = VerticalLine.new(1).intersect(LineSegment.new(1, -1, 1, 20))
if not (c4.x1 == 1 and c4.y1 == -1 and c4.x2 == 1 and c4.y2 == 20)
  puts "VerticalLine intersect with LineSegment not working properly"
end
c5 = VerticalLine.new(2).intersect(LineSegment.new(1, -1, 1, 20))
if not (c5.is_a? NoPoints)
  puts "VerticalLine intersect with LineSegment not working properly"
end

#LineSegment Tests
d = LineSegment.new(ONE,TWO,-THREE,-FOUR)
if not (d.eval_prog([]) == d)
	puts "LineSegement eval_prog should return self"
end
d1 = LineSegment.new(ONE,TWO,ONE,TWO)
d2 = d1.preprocess_prog
if not ((d2.is_a? Point)and d2.x == ONE and d2.y == TWO)
	puts "LineSegment preprocess_prog should convert to a Point"
	puts "if ends of segment are real_close"
end

d2 = LineSegment.new(-THREE, TWO, -THREE, ONE).preprocess_prog
if not (d2.x1 == -THREE and d2.y1 == ONE and d2.x2 == -THREE and d2.y2 == TWO)
	puts "LineSegment preprocess_prog should make x1 and y1"
	puts "on the left of x2 and y2"
end

d2 = LineSegment.new(-THREE, TWO, -THREE, THREE).preprocess_prog
if not (d2.x1 == -THREE and d2.y1 == TWO and d2.x2 == -THREE and d2.y2 == THREE)
	puts "LineSegment preprocess_prog should make x1 and y1"
	puts "on the left of x2 and y2"
end

d2 = LineSegment.new(THREE, TWO, -ONE, THREE).preprocess_prog
if not (d2.x1 == -ONE and d2.y1 == THREE and d2.x2 == THREE and d2.y2 == TWO)
	puts "LineSegment preprocess_prog should make x1 and y1"
	puts "on the left of x2 and y2"
end

d2 = d.preprocess_prog
if not (d2.x1 == -THREE and d2.y1 == -FOUR and d2.x2 == ONE and d2.y2 == TWO)
	puts "LineSegment preprocess_prog should make x1 and y1"
	puts "on the left of x2 and y2"
end

d3 = d2.shift(THREE,FIVE)
if not (d3.x1 == ZERO and d3.y1 == ONE and d3.x2 == FOUR and d3.y2 == SEVEN)
	puts "LineSegment shift not working properly"
end
if not (d.x1 == ONE and d.y1 == TWO and d.x2 == -THREE and d.y2 == -FOUR)
  puts d.x1
  puts "LineSegment mutated"
end

d4 =  LineSegment.new(-THREE, -FOUR, ONE, TWO).intersect(LineSegment.new(-THREE,-FOUR,ONE,TWO))
if not (((d4.is_a? LineSegment)) and d4.x1 == -THREE and d4.y1 == -FOUR and d4.x2 == ONE and d4.y2 == TWO)
	puts "LineSegment intersect not working properly1"
end
d5 =  LineSegment.new(-THREE, -FOUR, ONE, TWO).intersect(LineSegment.new(TWO,THREE,FOUR,FIVE))
if not ((d5.is_a? NoPoints))
	puts "LineSegment intersect not working properly2"
end

#Intersect Tests
i = Intersect.new(LineSegment.new(-ONE,-TWO,THREE,FOUR), LineSegment.new(THREE,FOUR,-ONE,-TWO))
i1 = i.preprocess_prog.eval_prog([])
if not (i1.x1 == -ONE and i1.y1 == -TWO and i1.x2 == THREE and i1.y2 == FOUR)
	puts "Intersect eval_prog should return the intersect between e1 and e2"
end

#Var Tests
v = Var.new("a")
v1 = v.eval_prog([["a", Point.new(THREE,FIVE)]])
if not ((v1.is_a? Point) and v1.x == THREE and v1.y == FIVE)
	puts "Var eval_prog is not working properly"
end
if not (v1.preprocess_prog == v1)
	puts "Var preprocess_prog should return self"
end

#Let Tests
l = Let.new("a", LineSegment.new(-ONE,-TWO,THREE,FOUR), Shift.new(ONE, ONE, Var.new("a")));
l1 = l.eval_prog([])
if not (l1.x1 == ZERO and l1.y1 == -ONE and l1.x2 == FOUR and l1.y2 == FIVE)
	puts "Let eval_prog should evaluate e2 after adding [s, e1] to the environment"
end
l = Let.new("a", LineSegment.new(-ONE,-TWO,THREE,FOUR),
             Intersect.new(Var.new("a"),LineSegment.new(THREE,FOUR,-ONE,-TWO)))
l1 = l.preprocess_prog.eval_prog([])
if not (l1.x1 == -ONE and l1.y1 == -TWO and l1.x2 == THREE and l1.y2 == FOUR)
	puts "Let eval_prog should evaluate e2 after adding [s, e1] to the environment"
end
#Let Variable Shadowing Test
l2 = Let.new("a", LineSegment.new(-ONE, -TWO, THREE, FOUR),
              Let.new("b", LineSegment.new(THREE,FOUR,-ONE,-TWO), Intersect.new(Var.new("a"),Var.new("b"))))
l2 = l2.preprocess_prog.eval_prog([["a",Point.new(0,0)]])
if not (l2.x1 == -ONE and l2.y1 == -TWO and l2.x2 == THREE and l2.y2 == FOUR)
	puts "Let eval_prog should evaluate e2 after adding [s, e1] to the environment"
end

#Shift Tests
s = Shift.new(THREE,FIVE,LineSegment.new(-ONE,-TWO,THREE,FOUR))
s1 = s.preprocess_prog.eval_prog([])
if not (s1.x1 == TWO and s1.y1 == THREE and s1.x2 == SIX and s1.y2 == 9)
	puts "Shift should shift e by dx and dy"
end
