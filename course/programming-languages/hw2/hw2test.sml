(* Homework2 Simple Test *)
(* These are basic test cases. Passing these tests does not guarantee that your code will pass the actual homework grader *)
(* To run the test, add a new line to the top of this file: use "homeworkname.sml"; *)
(* All the tests should evaluate to true. For example, the REPL should say: val test1 = true : bool *)

use "hw2.sml";

val test100 = all_except_option("s", ["s"]) = SOME []
val test101 = all_except_option("s", ["s", "s1"]) = SOME ["s1"]
val test102 = all_except_option("s", ["s", "s1", "s2"]) = SOME ["s1", "s2"]
val test103 = all_except_option("s", ["s1", "s", "s", "s2"]) = SOME ["s1", "s2"]
val test104 = all_except_option("s", ["s1", "s", "s2"]) = SOME ["s1", "s2"]
val test105 = all_except_option("s", ["s1", "s", "s"]) = SOME ["s1"]
val test106 = all_except_option("s", ["s", "s", "s2"]) = SOME ["s2"]
val test107 = all_except_option("s", ["s1", "s2", "s"]) = SOME ["s1", "s2"]
val test108 = all_except_option("s", ["s", "s", "s"]) = SOME []
val test109 = all_except_option("s", ["s1", "s2", "s3"]) = NONE
val test110 = all_except_option("s", []) = NONE

val test200 = get_substitutions1 ([["foo"],["there"]], "foo") = []
val test201 = get_substitutions1 ([["Fred","Fredrick"],
                                   ["Elizabeth","Betty"],
                                   ["Freddie","Fred","F"]], "Fred") = ["Fredrick", "Freddie", "F"]
val test202 = get_substitutions1 ([["Fred","Fredrick"],
                                   ["Jeff","Jeffrey"],
                                   ["Geoff","Jeff","Jeffrey"]], "Jeff") =  ["Jeffrey","Geoff","Jeffrey"]
val test203 = get_substitutions1 ([["1","2","3"], ["3"], []], "3" ) = ["1", "2"]
val test204 = get_substitutions1 ([["1","2","3"], ["3"], []], "4" ) = []
val test205 = get_substitutions1 ([["1","2"], ["1", "2"], ["2"], ["1"], ["3"]], "1" ) = ["2", "2"]
val test206 = get_substitutions1 ([], "1" ) = []
val test207 = get_substitutions1 ([[""]], "1" ) = []
val test208 = get_substitutions1 ([["1"]], "1" ) = []
val test209 = get_substitutions1 ([["2"]], "1" ) = []
val test210 = get_substitutions1 ([["2", "1", "2"]], "1" ) = ["2", "2"] (* not defined by task *)

val test300 = get_substitutions2 ([["foo"],["there"]], "foo") = []
val test301 = get_substitutions2 ([["Fred","Fredrick"],
                                   ["Elizabeth","Betty"],
                                   ["Freddie","Fred","F"]], "Fred") = ["Fredrick", "Freddie", "F"]
val test302 = get_substitutions2 ([["Fred","Fredrick"],
                                   ["Jeff","Jeffrey"],
                                   ["Geoff","Jeff","Jeffrey"]], "Jeff") =  ["Jeffrey","Geoff","Jeffrey"]
val test303 = get_substitutions2 ([["1","2","3"], ["3"], []], "3" ) = ["1", "2"]
val test304 = get_substitutions2 ([["1","2","3"], ["3"], []], "4" ) = []
val test305 = get_substitutions2 ([["1","2"], ["1", "2"], ["2"], ["1"], ["3"]], "1" ) = ["2", "2"]
val test306 = get_substitutions2 ([], "1" ) = []
val test307 = get_substitutions2 ([[""]], "1" ) = []
val test308 = get_substitutions2 ([["1"]], "1" ) = []
val test309 = get_substitutions2 ([["2"]], "1" ) = []
val test310 = get_substitutions2 ([["2", "1", "2"]], "1" ) = ["2", "2"] (* not defined by task *)

val test400 = similar_names ([["Fred","Fredrick"], ["Elizabeth","Betty"], ["Freddie","Fred","F"]],
                             {first="Fred", middle="W", last="Smith"}) = [{first="Fred", last="Smith", middle="W"},
                                                                          {first="Fredrick", last="Smith", middle="W"},
                                                                          {first="Freddie", last="Smith", middle="W"},
                                                                          {first="F", last="Smith", middle="W"}]
val test401 = similar_names([["Fred", "F1", "F2"], ["F1", "F2", "F3"]],
                             {first="Fred", middle="M", last="L"}) =  [{first="Fred", last="L", middle="M"},
                                                                       {first="F1", last="L", middle="M"},
                                                                       {first="F2", last="L", middle="M"}]
val test402 = similar_names([["Fred", "F1", "F2"]],
                             {first="Fred", middle="M", last="L"}) =  [{first="Fred", last="L", middle="M"},
                                                                       {first="F1", last="L", middle="M"},
                                                                       {first="F2", last="L", middle="M"}]
val test403 = similar_names([["F0", "F1", "F2"]],
                             {first="Fred", middle="M", last="L"}) =  [{first="Fred", last="L", middle="M"}]

val test500 = card_color((Clubs, Num 2)) = Black
val test501 = card_color((Spades, Ace)) = Black
val test502 = card_color((Diamonds, Num 2)) = Red
val test503 = card_color((Hearts, King)) = Red

val test600 = card_value((Clubs, Num 2)) = 2
val test601 = card_value((Clubs, Num 10)) = 10
val test602 = card_value((Clubs, Ace)) = 11
val test603 = card_value((Clubs, King)) = 10
val test604 = card_value((Clubs, Queen)) = 10
val test605 = card_value((Clubs, Jack)) = 10

val test700 = remove_card([(Hearts, Ace)], (Hearts, Ace), IllegalMove) = []
val test701 = remove_card([(Hearts, Ace), (Clubs, Num 2)], (Hearts, Ace), IllegalMove) = [(Clubs, Num 2)]
val test702 = remove_card([(Hearts, King), (Hearts, Ace), (Clubs, Num 2)],
                           (Hearts, Ace), IllegalMove) = [(Hearts, King), (Clubs, Num 2)]
val test703 = remove_card([(Hearts, King), (Clubs, Num 2), (Hearts, Ace)],
                           (Hearts, Ace), IllegalMove) = [(Hearts, King), (Clubs, Num 2)]
val test704 = remove_card([(Hearts, King), (Hearts, Ace), (Clubs, Num 2), (Hearts, Ace)],
                           (Hearts, Ace), IllegalMove) = [(Hearts, King), (Clubs, Num 2), (Hearts, Ace)]
val test705 = remove_card([(Hearts, Ace), (Hearts, Ace)], (Hearts, Ace), IllegalMove) = [(Hearts, Ace)]
val test706 = (remove_card([(Hearts, King), (Hearts, Jack)], (Hearts, Ace), IllegalMove)
              handle IllegalMove => [(Clubs, Num 20)]) = [(Clubs, Num 20)]
val test707 = (remove_card([], (Hearts, Ace), IllegalMove)
              handle IllegalMove => [(Clubs, Num 20)]) = [(Clubs, Num 20)]

val test800 = all_same_color([(Hearts, Ace), (Hearts, Ace)]) = true
val test801 = all_same_color([(Hearts, Ace), (Diamonds, King)]) = true
val test802 = all_same_color([(Spades, Num 10), (Diamonds, King)]) = false
val test803 = all_same_color([(Spades, Num 10), (Clubs, King), (Spades, Jack)]) = true
val test804 = all_same_color([(Spades, Num 10), (Clubs, King), (Diamonds, Jack)]) = false
val test805 = all_same_color([(Spades, Num 10), (Diamonds, King), (Spades, Jack)]) = false
val test806 = all_same_color([]) = true
val test807 = all_same_color([(Spades, Queen)]) = true

val test900 = sum_cards([(Clubs, Num 2),(Clubs, Num 2)]) = 4
val test901 = sum_cards([(Clubs, Ace),(Spades, Num 8), (Diamonds, Jack)]) = 29
val test902 = sum_cards([]) = 0

val test903 = score([(Hearts, Num 2),(Clubs, Num 4)],10) = 4
val test904 = score([(Hearts, Num 2),(Clubs, Num 4), (Spades, Num 4)],10) = 0
val test905 = score([(Hearts, Num 1),(Clubs, Ace)],10) = 6
val test907 = score([(Hearts, Num 1),(Clubs, Ace),(Spades, Jack)],10) = 36
val test908 = score([(Hearts, Num 1),(Diamonds, Ace),(Diamonds, Jack)],10) = 18
val test909 = score([(Hearts, Num 1),(Diamonds, Num 2),(Diamonds, Num 1)],10) = 3
val test910 = score([(Hearts, Num 2),(Diamonds, Num 2),(Diamonds, Num 1)],10) = 2
val test911 = score([(Hearts, Ace),(Diamonds, King)],10) = 16
val test912 = score([],10) = 5

val test913 = officiate([(Hearts, Num 2),(Clubs, Num 4)],[Draw], 15) = 6
val test914 = officiate([(Clubs,Ace),(Spades,Ace),(Clubs,Ace),(Spades,Ace)], [Draw,Draw,Draw,Draw,Draw], 42) = 3
val test915 = ((officiate([(Clubs,Jack),(Spades,Num(8))], [Draw,Discard(Hearts,Jack)], 42); false)
              handle IllegalMove => true)
val test916 = officiate([(Clubs,Ace),(Spades,Ace),(Clubs,Ace),(Spades,Ace)], [Draw,Discard(Clubs, Ace)], 42) = 21
val test917 = officiate([], [Draw], 42) = 21
val test918 = officiate([(Clubs,King),(Spades,King),(Diamonds,King),(Hearts,King)],
             [Draw,Draw,Draw,Draw,Discard(Hearts,King),Discard(Spades,King),Discard(Diamonds,King),Discard(Clubs,King)],
             42) = 21
val test919 = officiate([(Clubs,King),(Spades,King),(Diamonds,King),(Hearts,King)],
             [Draw,Draw,Draw,Draw,Discard(Hearts,King),Discard(Spades,King),Discard(Diamonds,King),Discard(Clubs,King)],
             39) = score([(Clubs,King),(Spades,King),(Diamonds,King),(Hearts,King)], 39)
val test920 = officiate([(Clubs,King),(Spades,King),(Diamonds,King),(Hearts,King)],
             [Draw,Draw,Draw,Draw,Discard(Hearts,King),Discard(Spades,King),Discard(Diamonds,King),Discard(Clubs,King)],
             29) = score([(Clubs,King),(Spades,King),(Diamonds,King)], 29)
val test921 = officiate([(Clubs,Num 10),(Spades,Num 9),(Diamonds,Num 8),(Hearts,Num 7)],
             [Draw,Draw,Discard(Clubs,Num 10),Draw,Draw],
             20) = score([(Clubs,Num 9), (Diamonds, Num 8), (Hearts, Num 7)], 20)
val test922 = ((officiate([(Clubs,King)], [Discard(Clubs,King)], 10); false)
              handle IllegalMove => true)
