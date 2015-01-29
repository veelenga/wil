(* Homework3 Simple Test*)
(* These are basic test cases. Passing these tests does not guarantee that your code will pass the actual homework grader *)
(* To run the test, add a new line to the top of this file: use "homeworkname.sml"; *)
(* All the tests should evaluate to true. For example, the REPL should say: val test1 = true : bool *)

use "hw3.sml";

val test100 = only_capitals ["A","B","C"] = ["A","B","C"]
val test101 = only_capitals ["ABC","bCA","cAb"] = ["ABC"]
val test102 = only_capitals ["aBC","bCA","cAb"] = []
val test103 = only_capitals ["aBC","BCA","CAb"] = ["BCA", "CAb"]

val test200 = longest_string1 ["A","bc","C"] = "bc"
val test201 = longest_string1 ["A","bc","Ccc"] = "Ccc"
val test202 = longest_string1 ["Aaa","bc","C"] = "Aaa"
val test203 = longest_string1 ["Aa","bc","C"] = "Aa"
val test204 = longest_string1 ["Aa","bc","Cc"] = "Aa"
val test205 = longest_string1 ["Aa","bcc","cccc"] = "cccc"
val test206 = longest_string1 [] = ""

val test300 = longest_string2 ["A","bc","C"] = "bc"
val test301 = longest_string2 ["A","bc","TTT"] = "TTT"
val test302 = longest_string2 ["AA","bc","TTT"] = "TTT"
val test303 = longest_string2 ["AA","bc","TT"] = "TT"
val test304 = longest_string2 ["AA","bc","T"] = "bc"

val test400a = longest_string3 ["A","bc","C"] = longest_string1 ["A","bc","C"]
val test401a = longest_string3 ["A","bc","Ccc"] = longest_string1 ["A","bc","Ccc"]
val test402a = longest_string3 ["Aaa","bc","C"] = longest_string1 ["Aaa","bc","C"]
val test403a = longest_string3 ["Aa","bc","C"] = longest_string1 ["Aa","bc","C"]
val test404a = longest_string3 ["Aa","bc","Cc"] = longest_string1 ["Aa","bc","Cc"]
val test405a = longest_string3 ["Aa","bcc","cccc"] = longest_string1 ["Aa","bcc","cccc"]
val test406a = longest_string3 [] = longest_string1 []

val test400b = longest_string4 ["A","B","C"] = longest_string2 ["A","B","C"]
val test401b = longest_string4 ["A","bc","TTT"] = longest_string2 ["A","bc","TTT"]
val test402b = longest_string4 ["AA","bc","TTT"] = longest_string2 ["AA","bc","TTT"]
val test403b = longest_string4 ["AA","bc","TT"] = longest_string2 ["AA","bc","TT"]
val test404b = longest_string4 ["AA","bc","T"] = longest_string2 ["AA","bc","T"]

val test500 = longest_capitalized ["A","bc","C"] = "A"
val test501 = longest_capitalized ["A","bc","CC"] = "CC"
val test502 = longest_capitalized ["A","Bc","CC"] = "Bc"
val test503 = longest_capitalized ["Aa","Bc","CC"] = "Aa"
val test504 = longest_capitalized ["aaa","B","cc"] = "B"
val test505 = longest_capitalized ["aaa","b","cc"] = ""
val test506 = longest_capitalized [] = ""

val test600 = rev_string "abc" = "cba"
val test601 = rev_string "aaa" = "aaa"
val test602 = rev_string "a" = "a"
val test603 = rev_string "" = ""

val test700 = first_answer (fn x => if x > 3 then SOME x else NONE) [1,2,3,4,5] = 4
val test701 = first_answer (fn x => if x <> 2 then SOME x else NONE) [1,2,3,4,5] = 1
val test702 = first_answer (fn x => if x <> 1 then SOME x else NONE) [1,2,3,4,5] = 2
val test703 = ((first_answer (fn x => if false then SOME x else NONE) [1,2,3,4,5]; false)
              handle NoAnswer => true)

val test800 = all_answers (fn x => if x = 1 then SOME [x] else NONE) [2,3,4,5,6,7] = NONE
val test801 = all_answers (fn x => if x = 1 then NONE else SOME [x]) [2,3,4] = SOME [2,3,4]
val test802 = all_answers (fn x => if x = 1 then NONE else SOME [x]) [2,1,3,4] = NONE
val test803 = all_answers (fn x => if x = 1 then NONE else SOME [1]) [2,3,4] = SOME [1,1,1]
val test804 = all_answers (fn x => if x = 1 then NONE else SOME [x]) [] = SOME []

val test900a = count_wildcards Wildcard = 1
val test901a = count_wildcards (TupleP [Wildcard, Wildcard]) = 2
val test902a = count_wildcards (TupleP [Wildcard, Variable "s", ConstP 10, TupleP [ConstP 1, Wildcard]]) = 2
val test903a = count_wildcards (TupleP [ConstP 1, ConstructorP ("", Wildcard), Wildcard]) = 2

val test900b = count_wild_and_variable_lengths (Variable("a")) = 1
val test901b = count_wild_and_variable_lengths (Variable("abc")) = 3
val test902b = count_wild_and_variable_lengths (TupleP [Wildcard, Variable("abc")]) = 4
val test903b = count_wild_and_variable_lengths (TupleP [Wildcard, Variable("abc"), ConstP 10]) = 4
val test904b = count_wild_and_variable_lengths (TupleP [Wildcard, Variable("abc"), Variable("10")]) = 6
val test905b = count_wild_and_variable_lengths (TupleP [Wildcard, Variable("abc"), ConstructorP("123", Wildcard)]) = 5
val test906b = count_wild_and_variable_lengths (TupleP [ConstructorP ("123", UnitP), ConstP 10]) = 0

val test900c = count_some_var ("x", Variable("x")) = 1
val test901c = count_some_var ("xxx", Variable("x")) = 0
val test902c = count_some_var ("x", TupleP[Variable("x"), Variable("x"), Wildcard, Variable("xx")]) = 2

val test1001 = check_pat (Variable("x")) = true
val test1002 = check_pat (TupleP[Variable("x")]) = true
val test1003 = check_pat (TupleP[Variable("x"), Variable("xx"), Wildcard]) = true
val test1004 = check_pat (TupleP[Variable("xx"), Variable("xx"), Wildcard]) = false
val test1005 = check_pat (TupleP[Wildcard, Variable("xx"), Variable("xxx"), Wildcard]) = true
val test1006 = check_pat (Variable("")) = true
val test1007 = check_pat (TupleP[Wildcard, Variable("xx"), TupleP[ConstP 10, Variable("xxx")], Variable("xxx"), Wildcard]) = false
val test1008 = check_pat (ConstructorP ("hi", TupleP [Variable "x",Variable "x"])) = false
val test1009 = check_pat (ConstructorP ("hi", TupleP [Variable "x",ConstructorP ("yo",TupleP[Variable "x",UnitP])])) = false


val test1100 = match (Const(1), UnitP) = NONE
val test1101 = match (Const(1), Wildcard) = SOME []
val test1102 = match (Unit, UnitP) = SOME []
val test1103 = match (Constructor ("s", Unit), Variable "val") = SOME [("val", Constructor("s", Unit))]
val test1105 = match (Const 17, ConstP 17) = SOME []
val test1106 = match (Const 17, ConstP 16) = NONE
val test1107 = match (Tuple [Const 11, Unit, Constructor ("val", Const 0)], TupleP [ConstP 11, UnitP, ConstructorP ("val", Variable "any")]) = SOME [("any", Const 0)]
val test1108 = match (Tuple [Const 1, Const 2, Unit], TupleP [ConstP 1, ConstP 3, UnitP]) = NONE
val test1109 = match (Tuple [Const 1, Const 2, Unit], TupleP [ConstP 1, Variable "any", UnitP]) = SOME [("any", Const 2)]

val test1200 = first_match Unit [UnitP] = SOME []
val test1201 = first_match Unit [ConstP 10] = NONE
val test1202 = first_match (Tuple [Const 1, Const 2, Unit]) [Variable "any"] = SOME [("any", Tuple [Const 1, Const 2, Unit])]
val test1203 = first_match (Constructor ("x", Unit)) [UnitP, ConstructorP ("x", Variable "any")] = SOME [("any", Unit)]
