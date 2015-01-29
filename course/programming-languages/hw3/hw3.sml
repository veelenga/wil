(* Coursera Programming Languages, Homework 3, Provided Code *)

exception NoAnswer

datatype pattern =
    Wildcard
  | Variable of string
  | UnitP
  | ConstP of int
  | TupleP of pattern list
  | ConstructorP of string * pattern

datatype valu =
    Const of int
  | Unit
  | Tuple of valu list
  | Constructor of string * valu

fun g f1 f2 p =
  let
    val r = g f1 f2
  in
    case p of
      Wildcard          => f1 ()
    | Variable x        => f2 x
    | TupleP ps         => List.foldl (fn (p,i) => (r p) + i) 0 ps
    | ConstructorP(_,p) => r p
    | _                 => 0
  end

(**** for the challenge problem only ****)

datatype typ = Anything
  | UnitT
  | IntT
  | TupleT of typ list
  | Datatype of string

(**** you can put all your code here ****)

fun only_capitals xs =
  List.filter (fn x => Char.isUpper(String.sub(x, 0))) xs

fun longest_string1 xs =
  foldl (fn (x, y) => if String.size(x) > String.size(y) then x else y) "" xs

fun longest_string2 xs =
  foldl (fn (x, y) => if String.size(x) >= String.size(y) then x else y) "" xs

fun longest_string_helper f =
  foldl (fn (x, y) => if f (String.size x, String.size y) then x else y) ""

(*
fun longest_string3 xs =
  let fun more (x : int, y : int) =
            x > y
  in
    longest_string_helper more xs
  end

fun longest_string4 xs =
  let fun more (x : int, y : int) =
            x >= y
  in
    longest_string_helper more xs
  end
*)
fun longest_string3 xs = longest_string_helper (op >) xs
fun longest_string4 xs = longest_string_helper (op >=) xs

fun longest_capitalized xs = (longest_string1 o only_capitals) xs

fun rev_string s = (String.implode o List.rev o String.explode) s

fun first_answer f xs =
  case xs of
    [] => raise NoAnswer
  | x::xs' => case f x of
                NONE => first_answer f xs'
              | SOME v => v

fun all_answers f xs =
  let fun aux ([],     acc) = SOME acc
        | aux (x::xs', acc) =
          case f x of
            NONE => NONE
          | SOME lst => aux (xs', acc @ lst)
  in
    aux (xs, [])
  end

fun count_wildcards p = g (fn u => 1) (fn s => 0) p

fun count_wild_and_variable_lengths p = g (fn u => 1) (fn s => String.size s) p

fun count_some_var (s, p) = g (fn u => 0) (fn x => if x = s then 1 else 0) p

fun check_pat p =
  let
    fun all_strings p =
      case p of
        Variable x => [x]
      | ConstructorP (s, pn) => all_strings (pn)
      | TupleP ps => List.foldl (fn (p, l) => l @ all_strings(p)) [] ps
      | _ => []
    fun are_unique xs =
      case xs of
        [] => true
      | x::xs' => case List.exists (fn y => y = x) xs' of
                    true => false
                  | false => are_unique xs'
  in
    (are_unique o all_strings) p
  end

fun match (value, pattern) =
  case (value, pattern) of
    (_, Wildcard) => SOME []
  | (v, Variable s) => SOME [(s, v)]
  | (Unit, UnitP) => SOME[]
  | (Const x, ConstP y) => if x = y then SOME [] else NONE
  | (Tuple vs, TupleP ps) => if List.length vs <> List.length ps
                             then NONE
                             else all_answers (fn (v, p) => match (v, p)) (ListPair.zip (vs, ps))
  | (Constructor (s2, v), ConstructorP (s1, p)) => if s1 = s2
                                                   then match (v, p)
                                                   else NONE
  | _ => NONE

fun first_match value patterns =
  SOME (first_answer (fn p => match (value, p)) patterns)
    handle NoAnswer => NONE
