train(1, 'Train1', lviv, kyiv, date(2018, 11, 10, 14, 0, 0, -, -), date(2018, 11, 10, 22, 0, 0, -, -)).
train(2, 'Train2', kyiv, kharkiv, date(2018, 11, 11, 12, 0, 0, -, -), date(2018, 11, 11, 15, 0, 0, -, -)).
train(3, 'Train3', kharkiv, chernigiv, date(2018, 11, 12, 13, 30, -, -), date(2018, 11, 12, 17, 45, -, -)).

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
findRoute(Y, Y).
findRoute(X, Y) :- 
    train(Num, _, X, Z, _, _),
    findRoute(Z, Y),
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
    train(Num1, _, X, Z, _, _),
    train(Num2, _, Z, Y, _, _),
    printTrainInfo(Num1),
    printTrainInfo(Num2).

