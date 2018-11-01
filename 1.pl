:- use_module(library(lists)).

/* Custom DateTime implementation */
date_time(Year, Month, Date, Hour, Minute) :- 
    Year > 0,
    Month >= 1,
    Month =< 12,
    Date >= 1,
    Date =< 31,
    Hour >= 1,
    Hour < 24, 
    Minute >= 1, 
    Minute < 60.

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

/* Trains */
train(1, 'Train1', lviv, kyiv, 
    date_time(2018, 11, 10, 14, 0), date_time(2018, 11, 11, 7, 45), 
    [sub_station(ternopil, date_time(2018, 11, 10, 16, 30), date_time(2018, 11, 10, 16, 45), [car(compartment, 15), car(platzkart, 5)]),
     sub_station(vinnytsia, date_time(2018, 11, 10, 22, 45), date_time(2018, 11, 10, 23, 0), [car(compartment, 10), car(platzkart, 0)]),
     sub_station(zhytomyr, date_time(2018, 11, 11, 3, 45), date_time(2018, 11, 11, 5, 30), [car(compartment, 25), car(platzkart, 5)])]).

/* Print train info */
printTrainInfo(Num) :- 
    train(Num, Name, From, To, Departure, Arrival, Substations),
    write('[Number: '), 
    write(Num),
    write(' Name: '),
    write(Name),
    write(', From: '),
    write(From),
    write(', To: '),
    write(To),
    write(', Departure: '),
    write(Departure),
    write(', Arrival: '), 
    write(Arrival),
    write(', '),
    nl,
    write('   Substations: '),
    nl,
    print_list(Substations),
    write(']'),
    nl.

/* Print substations */

print_list([]).
print_list([Head|Tail]) :-
    write(Head),
    nl,
    print_list(Tail).

search_car(TrainNum, Location, Destination) :- 
    train(TrainNum, Name, From, To, Departure, Arrival, Substations),
    append([sub_station(From, default_date_time(1,1,1,1,1), default_date_time(1,1,1,1,1), [car(compartment,1), car(platzkart,1)])], Substations, Temp1),
    append(Temp1, [sub_station(To, default_date_time(1,1,1,1,1), default_date_time(1,1,1,1,1), [car(compartment,1), car(platzkart,1)])], Temp2),
    find_first_station(Temp2, Location, Destination).

station_equal(First, Second) :-
    First =.. Subitems,
    [_,Station|_] = Subitems,
    Second == Station.

find_first_station([Head|Tail], Location, Destination) :-
    (
        station_equal(Head,Location) -> iterate_carriages(Head, Tail, Destination)
    ;   find_first_station(Tail, Location, Destination)
    ).

check_place_count(Carriage, AllCarriages, NextStations, Destination) :- 
    (
        Carriage =.. Subitems,
        [CN,_,Places|_] = Subitems,
    write('Places: '), write(Places), write(' Carriage: '), write(CN), nl,
        Places == 0 -> false
        ; [A|B] = NextStations,
        A =.. Sub2,
        [_,NextStationName,_,_,Carriages|_] = Sub2,
        iterate_carriages_inner(AllCarriages, NextStationName, B, Destination)
        ).

iterate_carriages_inner([], CurrStation, NextStations, Destination).
iterate_carriages_inner([Head|Tail], StationName, NextStations, Destination) :-
    write('-----'),
    nl,
    write(Head),
    nl,
    write(Tail),
    nl,
    write(StationName),
    nl,
    write(NextStations),
    nl,
    write(Destination),
    nl,
    write('-----'),
    (
        StationName == Destination -> write('Can travel in car: '), write(Head)
    ;   append([Head], Tail, C), check_place_count(Head, C, NextStations, Destination)
    ),
            iterate_carriages_inner(Tail,StationName, NextStations, Destination).
    

iterate_carriages(Head, Tail, Destination) :-
    Head =.. Subitems,
    [_,StationName,_,_,Carriages|_] = Subitems,
    write('CARRIAGES: '),
    write(Carriages),
    nl,
    iterate_carriages_inner(Carriages,StationName,Tail,Destination),
    nl.
    
    

