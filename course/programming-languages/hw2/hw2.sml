(* Dan Grossman, Coursera PL, HW2 Provided Code *)

(* if you use this function to compare two strings (returns true if the same
   string), then you avoid several of the functions in problem 1 having
   polymorphic types that may be confusing *)
fun same_string(s1 : string, s2 : string) =
    s1 = s2

(*
 * Returns NONE if the s is not in the list, SOME lst is identical to the
 * argument list except the s is not in it
 *)
fun all_except_option (s, xs) =
  case xs of
    [] => NONE
  | x::xs' => case all_except_option (s, xs') of
                NONE => if same_string (x,s) then SOME xs' else NONE
              | SOME lst => if same_string (x, s)
                            then SOME lst
                            else SOME (x::lst)

(*
 * Returns all elements of the list that are in some list in substitutions,
 * that also has s, but s itself should not be in the result.
 *)
fun get_substitutions1 ([], s) = [] (* string list list * string -> string list *)
  | get_substitutions1 (sub::xs', s) =
      let val r = get_substitutions1 (xs', s)
      in case all_except_option (s, sub) of
           NONE => r
         | SOME lst => lst @ r
      end

(*
 * Produces the same result as get_substitutions1 but uses a tail-recursion.
 *)
fun get_substitutions2 (subs, s) = (* string list list * string -> string list *)
  let fun aux (subs, s, acc) =
        case subs of
          [] => acc
        | sub::xs' => case all_except_option (s, sub) of
                        NONE => aux (xs', s, acc)
                      | SOME lst => aux (xs', s, acc @ lst)
  in
    aux (subs, s, [])
  end

(*
 * Returns all the full names that is possible to produce by substituting for the
 * first name (and only the first name). Aswer begins with the original name (and
 * have 0 or more other names).
 *)
fun similar_names (subs, person) =
  let
    val first_name = case person of {first=f, middle=m, last=l} => f
    val first_names = get_substitutions2 (subs, first_name)
    fun produce_names ([]) = []
      | produce_names (f::xs') =
          case person of
            {first=_, middle=m, last=l} => {first=f, middle=m, last=l}::produce_names (xs')
  in
    person :: produce_names (first_names)
  end

(* you may assume that Num is always used with values 2, 3, ..., 10
   though it will not really come up *)
datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw

exception IllegalMove

fun card_color card =
  case card of
    (Clubs, _) => Black
  | (Spades, _) => Black
  | (Diamonds, _) => Red
  | (Hearts, _) => Red

fun card_value card =
  case card of
    (_, Num i) => i
  | (_, Ace) => 11
  | _ => 10

fun remove_card (cs, c, e) =
  case cs of
    [] => raise  e
  | x::cs' => case x = c of
                true => cs'
              | false => x::remove_card (cs', c, e)

fun all_same_color [] = true
  | all_same_color (_::[]) = true
  | all_same_color (head::(neck::rest)) =
      card_color (head) = card_color (neck) andalso all_same_color (neck::rest)

fun sum_cards cards =
  let
    fun aux (cards, acc) =
      case cards of
        [] => acc
      | c::xs' => aux (xs', card_value (c) + acc)
  in
    aux (cards, 0)
  end

fun score (cards, goal) =
  let
    val sum = sum_cards (cards)
    fun preliminary_score (sum) =
      case sum > goal of
        true => 3 * (sum - goal)
      | false => goal - sum
    in
      case all_same_color (cards) of
        true => preliminary_score (sum) div 2
      | false => preliminary_score (sum)
    end

fun officiate (cards, moves, goal) =
  let
    fun game (card_list, moves, held_list) =
      case moves of
        [] => score (held_list, goal)
      | move::rest_moves =>
          case move of
            Discard card => game (cards, rest_moves,
                                  remove_card (held_list, card, IllegalMove))
          | Draw => case card_list of
                      [] => score (held_list, goal)
                    | c::rest_cards =>
                        let val new_held_list = c::held_list
                        in
                          case sum_cards(new_held_list) > goal of
                            true => score (new_held_list, goal)
                          | false => game (rest_cards, rest_moves, new_held_list)
                        end
  in
    game (cards, moves, [])
  end

