/* Custom DateTime implementation */
date_time(Year, Month, Date, Hour, Minute) :- Year > 0,Month >= 1,Month =< 12,Date >= 1,Date =< 31, Hour >= 1, Hour < 24, Minute >= 1, Minute < 60.

later(Dt1, Dt2) :-
  Dt1 =.. List1,
  Dt2 =.. List2, 
  [_,Year1,Month1,Date1,Hour1,Minute1|_]=List1,
  [_,Year2,Month2,Date2,Hour2,Minute2|_]=List2,
  (
  	Year1 > Year2;
    (Year1 == Year2,Month1 > Month2);
    (Year1 == Year2,Month1 == Month2,Date1 > Date2);
    (Year1 == Year2,Month1 == Month2,Date1 == Date2,Hour1 > Hour2);
    (Year1 == Year2,Month1 == Month2,Date1 == Date2,Hour1 == Hour2,Minute1 > Minute2)
  ).

default_date_time(Dt) :-
    Dt =.. List,
    [_,Year1,Month1,Date1,Hour1,Minute1|_]=List,
    Year1 == 1,
    Month1 == 1,
    Date1 == 1,
    Hour1 == 1,
    Minute1 == 1.