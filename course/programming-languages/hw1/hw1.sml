(* Returns: true - if first date comes before the second date, false - otherwise.
* If the two dates are the same, the result is false.
*)
fun is_older (d1: int * int * int, d2: int * int * int) =
  (#1 d1 < #1 d2) orelse
  (#1 d1 = #1 d2 andalso #2 d1 < #2 d2) orelse
  (#1 d1 = #1 d2 andalso #2 d1 = #2 d2 andalso #3 d1 < #3 d2)

(* Parameters: dates - list of dates, month - a month.
 * Returns: number of dates in the list are in the given month.
 *)
fun number_in_month (dates : (int * int * int) list, month : int) =
  if null dates
  then 0
  else let val n = number_in_month (tl dates, month)
       in
         if #2 (hd dates) = month
         then n + 1
         else n
       end

(* Parameters: dates - list of dates, months - list of months
 * Returns: number of dates in the list of dates that in any of the months in the list of months.
 *)
fun number_in_months (dates : (int * int * int) list, months : (int) list) =
  if null dates orelse null months
  then 0
  else number_in_month (dates, hd months) + number_in_months (dates, tl months)

(* Parameters: dates - list of dates, month - a month.
 * Returns: list holding the dates from the argument list of dates that are in the month.
 * Returned list contains dates in the order they were originally given.
 *)
fun dates_in_month (dates : (int * int * int) list, month : int) =
  if null dates
  then []
  else let val ds = dates_in_month (tl dates, month)
       in
         if #2 (hd dates) = month
         then (hd dates)::ds
         else ds
       end

(* Parameters: dates - list of dates, months - list of months.
 * Returns: list holding the dates from the argument list of dates that are in any of the months
 * in the list of months.
 *)
fun dates_in_months (dates : (int * int * int) list, months : (int) list) =
  if null dates orelse null months
  then []
  else (dates_in_month (dates, hd months)) @ (dates_in_months (dates, tl months))

(* Parameters: sl - list of strings, n - nth element.
 * Returns: nth element of list of strings, where the dead of the list is list.
 *)
fun get_nth (sl: (string) list, n : int) =
  if n = 1
  then hd (sl)
  else get_nth (tl sl, n - 1)

(* Parameters: date - list of dates.
 * Returns: formatted date ("January 20, 2013", for example).
 *)
fun date_to_string (date: int * int * int) =
  let
    val months = ["January", "February", "March", "April", "May", "June", "July",
                  "August", "September", "October", "November", "December"]
  in
    get_nth (months, #2 date) ^ " " ^ Int.toString (#3 date) ^ ", " ^ Int.toString (#1 date)
  end

(* Parameters: sum - sum to be reached, l - list of int.
 * Returns: position before whick sum is reached.
 *)
fun number_before_reaching_sum (sum : int, l : (int) list) =
  if sum <= hd l
  then 0
  else 1 + number_before_reaching_sum (sum - (hd l), tl l)

(* Parameters: day - day of the year, i.e 1..365.
 * Returns: month if this day
 *)
fun what_month (day : int) =
  let
    val days_in_month = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
  in
    number_before_reaching_sum (day, days_in_month) + 1
  end

(* Parameters: d1 - day one, d2 -day two.
 * Returns: list of monthes.
 *)
fun month_range (d1 : int, d2: int) =
  if d1 > d2
  then []
  else if d1 = d2 + 1
       then [what_month(d2)]
       else what_month (d1) :: month_range (d1 + 1, d2)

(* Parameters: dates - list of dates.
 * Returns: the oldest date in list of dates
 *)
fun oldest (dates : (int * int * int) list) =
  if null dates
  then NONE
  else let
         fun oldest_nonempty (dates : (int * int * int) list) =
           if null (tl dates)
           then hd dates
           else let val tl_ans = oldest_nonempty (tl dates)
                in
                  if is_older (hd dates, tl_ans)
                  then hd dates
                  else tl_ans
                end
       in
         SOME (oldest_nonempty dates)
       end

(* CHALANGE problems *)
fun without_duplicates (l : (int) list) =
  if null l
  then []
  else let fun has (x : int, l : (int) list) =
             if null l
             then false
             else if hd l = x
                  then true
                  else has (x, tl l)
       in
         if has (hd l, tl l)
         then without_duplicates (tl l)
         else hd l :: without_duplicates (tl l)
       end

fun number_in_months_challenge(dates : (int * int * int) list, months : (int) list) =
  if null dates
  then 0
  else let fun number_in_months_not_null (months : (int) list) =
             if null months
             then 0
             else number_in_month (dates, hd months) + number_in_months_not_null (tl months)
       in
         number_in_months_not_null (without_duplicates (months))
       end


fun dates_in_months_challenge (dates : (int * int * int) list, months : (int) list) =
  if null dates
  then []
  else let fun dates_in_months_not_null (months : (int) list) =
             if null months
             then []
             else dates_in_month (dates, hd months) @ dates_in_months_not_null (tl months)
       in
         dates_in_months_not_null (without_duplicates (months))
       end

fun reasonable_date (date : (int * int * int)) =
  let
    val days_in_month = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
  in
    let fun leap_year (year : int) =
          (year mod 400 = 0 orelse year mod 4 = 0) andalso year mod 100 <> 0
    in
      (#1 date > 0) andalso
      (#2 date >= 1 andalso #2 date <= 12) andalso
      (#3 date > 0) andalso
      let val nth = List.nth (days_in_month, (#2 date) - 1)
      in
        if leap_year (#1 date) andalso #2 date = 2 (* leap day found *)
        then #3 date <= nth + 1
        else #3 date <= nth
      end
    end
  end
