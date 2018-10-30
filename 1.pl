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

/* Trains */
train(1, 'Train1', lviv, kyiv, date_time(2018, 11, 10, 14, 0), date_time(2018, 11, 10, 22, 0)).
train(2, 'Train2', kyiv, kharkiv, date_time(2018, 11, 11, 12, 0), date_time(2018, 11, 11, 15, 0)).
train(3, 'Train3', kharkiv, chernigiv, date_time(2018, 11, 19, 13, 0), date_time(2018, 11, 12, 17, 0)).

/* Carriages */
hasCar(1, compartment, 52, 50, 14.00).
hasCar(1, platzkart, 100, 75, 7.00).

hasCar(2, compartment, 25, 0, 25.50).

hasCar(3, platzcart, 300, 117, 14.45).

/* Print train info */
printTrainInfo(Num) :- 
    train(Num, Name, From, To, Departure, Arrival),
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
    write(']'),
    nl.

/* Print compartment info */
printCarInfo(TrainNum, CarType, Places, FreePlaces, Price) :- 
    write('[Train number: '),
    write(TrainNum),
    write(', Car type: '),
    write(CarType),
    write(', Overall places: '),
    write(Places),
    write(', Free places: '),
    write(FreePlaces),
    write(', Price: '),
    write(Price),
    write(']'),
    nl.

/* Find train from station A to B */
findCompositeRoute(X, Y) :- findRoute(X, Y, date_time(1, 1, 1, 1, 1)).

findRoute(Y, Y, AllowedDeparture).
findRoute(X, Y, AllowedDeparture) :- 
    train(Num, _, X, Z, Departure, Arrival),
    (default_date_time(AllowedDeparture); later(Departure, AllowedDeparture)),
    findRoute(Z, Y, Arrival),
    printTrainInfo(Num).

/* If contains car of type CarType */
hasCar(TrainNum, CarType) :- 
    hasCar(TrainNum, CarType, Places, FreePlaces, Price). 

findCar(TrainNum, CarType) :-
    hasCar(TrainNum, CarType, Places, FreePlaces, Price),
    printCarInfo(TrainNum, CarType, Places, FreePlaces, Price).

/* If contains car with price lower than X */
findPriceLowerThan(TrainNum, Price) :-
    hasCar(TrainNum, CarType, Places, FreePlaces, X),
    X < Price,
    printCarInfo(TrainNum, CarType, Places, FreePlaces, X).
    
/* If contains route with 1 transfer */

hasOneTransfer(X, Y) :- 
    train(Num1, _, X, Z, _, Arrival1),
    train(Num2, _, Z, Y, Departure2, _),
    later(Departure2, Arrival1),
    printTrainInfo(Num1),
    printTrainInfo(Num2).

