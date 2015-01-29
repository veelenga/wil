(* University of Washington, Programming Languages, Homework 7
   hw7testsprovided.sml *)
(* Will not compile until you implement preprocess and eval_prog *)

(* These tests do NOT cover all the various cases, especially for intersection *)

use "hw7.sml";

(* Must implement preprocess_prog and Shift before running these tests *)

fun real_equal(x,y) = Real.compare(x,y) = General.EQUAL;

(* Preprocess tests *)
let
  val Point(a,b) = preprocess_prog(LineSegment(3.2,4.1,3.2,4.1))
  val Point(c,d) = Point(3.2,4.1)
in
  if real_equal(a,c) andalso real_equal(b,d)
  then (print "TEST1: ok\n")
  else (print "TEST1: =====> FAIL <=====\n")
end;

let
  val LineSegment(a,b,c,d) = preprocess_prog (LineSegment(3.2,4.1,~3.2,~4.1))
  val LineSegment(e,f,g,h) = LineSegment(~3.2,~4.1,3.2,4.1)
in
  if real_equal(a,e) andalso real_equal(b,f) andalso real_equal(c,g) andalso real_equal(d,h)
  then (print "TEST2: ok\n")
  else (print "TEST2: =====> FAIL <=====\n")
end;

let
  val LineSegment(a,b,c,d) = preprocess_prog (LineSegment(3.0,4.0,~4.0,~5.0))
  val LineSegment(e,f,g,h) = LineSegment(~4.0,~5.0,3.0,4.0)
in
  if real_equal(a,e) andalso real_equal(b,f) andalso real_equal(c,g) andalso real_equal(d,h)
  then (print "TEST3: ok\n")
  else (print "TEST3: =====> FAIL <=====\n")
end;

let
  val LineSegment(a,b,c,d) = preprocess_prog (LineSegment(3.0,4.0,~4.0,4.0))
  val LineSegment(e,f,g,h) = LineSegment(~4.0,4.0,3.0,4.0)
in
  if real_equal(a,e) andalso real_equal(b,f) andalso real_equal(c,g) andalso real_equal(d,h)
  then (print "TEST4: ok\n")
  else (print "TEST4: =====> FAIL <=====\n")
end;

let
  val LineSegment(a,b,c,d) = preprocess_prog (LineSegment(3.0,4.0,3.0,2.0))
  val LineSegment(e,f,g,h) = LineSegment(3.0,2.0,3.0,4.0)
in
  if real_equal(a,e) andalso real_equal(b,f) andalso real_equal(c,g) andalso real_equal(d,h)
  then (print "TEST5: ok\n")
  else (print "TEST5: =====> FAIL <=====\n")
end;

let
  val LineSegment(a,b,c,d) = preprocess_prog (LineSegment(3.0,4.0,3.0,4.1))
  val LineSegment(e,f,g,h) = LineSegment(3.0,4.0,3.0,4.1)
in
  if real_equal(a,e) andalso real_equal(b,f) andalso real_equal(c,g) andalso real_equal(d,h)
  then (print "TEST6: ok\n")
  else (print "TEST6: =====> FAIL <=====\n")
end;

let
  val Point(x1, y1) = eval_prog (preprocess_prog (Intersect
                            (LineSegment (~1.0, ~1.0, 1.0, 1.0),
                             LineSegment (0.0, 0.0, 0.0, 0.0))), [])
  val Point(x2, y2) = Point(0.0, 0.0)
in
  if real_equal(x1, x2) andalso real_equal(y1, y2)
  then (print "TEST7: ok\n")
  else (print "TEST7: =====> FAIL <=====\n")
end;

let
  val Point(a,b) = (eval_prog (preprocess_prog (Shift(3.0, 4.0, Point(4.0,4.0))), []))
  val Point(c,d) = Point(7.0,8.0)
in
  if real_equal(a,c) andalso real_equal(b,d)
  then (print "TEST8: ok\n")
  else (print "TEST8: =====> FAIL <=====\n")
end;

let
  val Point(a,b) = (eval_prog (Shift(3.0,4.0,Var "a"), [("a",Point(4.0,4.0))]))
  val Point(c,d) = Point(7.0,8.0)
in
  if real_equal(a,c) andalso real_equal(b,d)
  then (print "TEST9: ok\n")
  else (print "TEST9 FAIL <=====\n")
end;

let
  val Point(a,b) = (eval_prog (Shift(3.0,4.0,Var "a"), [("a",Point(4.0,4.0)),("a",Point(1.0,1.0))]))
  val Point(c,d) = Point(7.0,8.0)
in
  if real_equal(a,c) andalso real_equal(b,d)
  then (print "TEST10: ok\n")
  else (print "TEST10 FAIL <=====\n")
end;

let
  val Point(a,b) = preprocess_prog(eval_prog (Shift(3.0,4.0,Var "a"),
                                            [("a", LineSegment(2.0, 3.0, 2.0, 3.0))]))
  val Point(c,d) = Point(5.0,7.0)

in
  if real_equal(a,c) andalso real_equal(b,d)
  then (print "TEST11: ok\n")
  else (print "TEST11 FAIL <=====\n")
end;

let
  val Line(a,b) = eval_prog ((Shift(2.0,10.3,Line (3.0, 5.0))), [])
  val Line(c,d) = Line(3.0,9.3)

in
  if real_equal(a,c) andalso real_equal(b,d)
  then (print "TEST12: ok\n")
  else (print "TEST12 FAIL <=====\n")
end;
