(* Homework1 Simple Test *)
(* These are basic test cases. Passing these tests does not guarantee that your code will pass the actual homework grader *)
(* To run the test, add a new line to the top of this file: use "homeworkname.sml"; *)
(* All the tests should evaluate to true. For example, the REPL should say: val test1 = true : bool *)

use "hw1.sml";

val test11 = is_older((1,2,3),(2,3,4)) = true
val test12 = is_older((2012, 2, 28), (2012, 3, 29)) = true
val test13 = is_older((2012, 2, 28), (2012, 2, 29)) = true
val test14 = is_older((2012, 2, 28), (2012, 2, 28)) = false
val test15 = is_older((2013, 3, 29), (2012, 2, 28)) = false
val test16 = is_older((2013, 3, 29), (2013, 2, 28)) = false
val test17 = is_older((2013, 3, 29), (2013, 3, 28)) = false
val test18 = is_older((2012, 2, 28), (2011, 8, 29)) = false

val test21 = number_in_month([(2012, 2, 28), (2013, 12, 1)], 2) = 1
val test22 = number_in_month([(2012, 2, 28), (2013, 2, 1)],  2) = 2
val test23 = number_in_month([(2012, 3, 28), (2013, 4, 1)],  2) = 0

val test31 = number_in_months([(2012,2,28), (2013,12,1), (2011,3,31), (2011,4,28)], [2,3,4]    ) = 3
val test32 = number_in_months([(2012,2,28), (2013,12,1), (2011,3,31), (2011,4,28)], [12,13,14] ) = 1
val test33 = number_in_months([(2012,2,28), (2013,12,1), (2011,3,31), (2011,4,28)], [112,13,14]) = 0
val test34 = number_in_months([(2012,2,28), (2013,12,1), (2011,2,31), (2011,2,28)], [2]        ) = 3
val test35 = number_in_months([(2012,2,28), (2013,12,1), (2011,2,31), (2011,2,28)], [8]        ) = 0
val test36 = number_in_months([(2012,2,28), (2013,12,1), (2011,2,31), (2011,2,28)], []         ) = 0

val test41 = dates_in_month([(2012,2,28), (2013,12,1)], 2) = [(2012,2,28)]
val test42 = dates_in_month([(2012,2,28), (2013,2,11)], 2) = [(2012,2,28), (2013,2,11)]
val test43 = dates_in_month([(2012,2,28), (2013,12,1)], 3) = []
val test44 = dates_in_month([(2012,2,28), (2013,12,1), (2010,2,18)], 2) = [(2012,2,28), (2010,2,18)]
val test45 = dates_in_month([], 2) = []

val test51 = dates_in_months([(2012,2,28), (2013,12,1), (2011,3,31), (2011,4,28)], [2,3,4]) = [(2012,2,28), (2011,3,31), (2011,4,28)]
val test52 = dates_in_months([(2012,1,11), (2012,1,12), (2012,1,14)], [1,2]) = [(2012,1,11), (2012,1,12), (2012,1,14)]
val test53 = dates_in_months([(2012,1,11), (2012,1,12), (2012,2,14)], [3,4]) = []
val test54 = dates_in_months([(2012,1,11), (2012,1,12), (2012,2,14)], []) = []
val test55 = dates_in_months([], [1, 2]) = []
val test56 = dates_in_months([], []) = []

val test61 = get_nth(["hi", "there", "how", "are", "you"], 2) = "there"
val test62 = get_nth(["hi", "there", "how", "are", "you"], 1) = "hi"
val test63 = get_nth(["hi", "there", "how", "are", "you"], 5) = "you"

val test71 = date_to_string((2013, 6, 1)) = "June 1, 2013"
val test72 = date_to_string((2013, 12, 1)) = "December 1, 2013"
val test73 = date_to_string((2013, 1, 1)) = "January 1, 2013"

val test81 = number_before_reaching_sum(10, [1,2,3,4,5]) = 3
val test82 = number_before_reaching_sum(10, [1,2,3,3,5]) = 4
val test83 = number_before_reaching_sum(10, [2,2,3,4,5]) = 3
val test84 = number_before_reaching_sum(10, [10,2,3,4,5]) = 0
val test85 = number_before_reaching_sum(10, [2,2,2,2,2,2]) = 4
val test86 = number_before_reaching_sum(5, [6, 6]) = 0
val test87 = number_before_reaching_sum(6, [6, 6]) = 0
val test88 = number_before_reaching_sum(7, [6, 6]) = 1

val test91 = what_month(70) = 3
val test92 = what_month(30) = 1
val test93 = what_month(1) = 1
val test94 = what_month(32) = 2
val test95 = what_month(365) = 12
val test96 = what_month(364) = 12

val test110 = month_range(31, 34) = [1,2,2,2]
val test111 = month_range(10, 11) = [1,1]
val test112 = month_range(10, 15) = [1,1,1,1,1,1]
val test113 = month_range(364, 365) = [12,12]
val test114 = month_range(28, 32) = [1,1,1,1,2]
val test115 = month_range(100, 99) = []

val test211 = oldest([(2012,2,28),(2011,3,31),(2011,4,28)]) = SOME (2011,3,31)
val test212 = oldest([(2012,2,28),(2011,3,31),(2011,12,28)]) = SOME (2011,3,31)
val test213 = oldest([(2012,2,28)]) = SOME (2012,2,28)
val test214 = oldest([]) = NONE

val test310 = without_duplicates([1,1]) = [1]
val test311 = without_duplicates([1,2]) = [1, 2]
val test312 = without_duplicates([1,2,1]) = [2, 1]
val test313 = without_duplicates([1,1,1]) = [1]
val test314 = without_duplicates([1,2,3]) = [1,2,3]
val test315 = without_duplicates([1]) = [1]

val test410 = number_in_months_challenge([(2012,2,28), (2013,12,1), (2011,3,31), (2011,4,28)], [2,3,4]) = 3
val test411 = number_in_months_challenge([(2012,2,28), (2013,12,1), (2011,3,31), (2011,4,28)], [2,2,2,3,4]) = 3
val test412 = number_in_months_challenge([(2012,2,28), (2013,12,1), (2011,3,31), (2011,4,28)], [2,3,3,3,4]) = 3
val test413 = number_in_months_challenge([(2012,2,28), (2013,12,1), (2011,3,31), (2011,4,28)], [2,2,3,3,4,4]) = 3
val test414 = number_in_months_challenge([(2012,2,28), (2013,12,1), (2011,3,31), (2011,2,28)], [2]) = 2

val test510 = dates_in_months_challenge([(2012,2,28), (2013,12,1), (2011,3,31), (2011,4,28)], [2,3,4]) = [(2012,2,28), (2011,3,31), (2011,4,28)]
val test511 = dates_in_months_challenge([(2012,2,28), (2013,12,1), (2011,3,31), (2011,4,28)], [2,2,2,3,4]) = [(2012,2,28), (2011,3,31), (2011,4,28)]
val test512 = dates_in_months_challenge([(2012,2,28), (2013,12,1), (2011,3,31), (2011,4,28)], [2,2,3,3,4]) = [(2012,2,28), (2011,3,31), (2011,4,28)]
val test513 = dates_in_months_challenge([(2012,2,28), (2013,12,1), (2011,3,31), (2011,4,28)], [2,2,3,3,4,4]) = [(2012,2,28), (2011,3,31), (2011,4,28)]
val test514 = dates_in_months_challenge([(2012,2,28), (2013,12,1), (2011,3,31), (2011,2,28)], [2]) = [(2012,2,28), (2011,2,28)]

val test610 = reasonable_date (2014, 10, 14) = true
val test611 = reasonable_date (2014, 10, 31) = true
val test612 = reasonable_date (2014, 10, 32) = false
val test613 = reasonable_date (2014, 2, 28) = true
val test614 = reasonable_date (2014, 2, 29) = false
val test615 = reasonable_date (2014, 13, 2) = false
val test616 = reasonable_date (2016, 2, 28) = true
val test617 = reasonable_date (2016, 2, 29) = true
val test618 = reasonable_date (2016, 2, 30) = false
val test619 = reasonable_date (0, 2, 30) = false
val test620 = reasonable_date (2012, 0, 30) = false
val test621 = reasonable_date (2012, 1, 0) = false
val test622 = reasonable_date (2014, 11, 31) = false
val test623 = reasonable_date (2014, 11, 30) = true
