:- ensure_loaded([date_time]).
:- ensure_loaded([db]).

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