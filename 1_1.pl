/* Custom DateTime implementation */
myDate(Year, Month, Date, Hour, Minute) :- Year > 0,Month >= 1,Month =< 12,Date >= 1,Date =< 31, Hour >= 1, Hour < 24, Minute >= 1, Minute < 60.

isBiggerThan(Dt1, Dt2) :-
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

default_myDate(Dt) :-
    Dt =.. List,
    [_,Year1,Month1,Date1,Hour1,Minute1|_]=List,
    Year1 == 1,
    Month1 == 1,
    Date1 == 1,
    Hour1 == 1,
    Minute1 == 1.

/* Trains */
train(1, 'Train1', lviv, kyiv, myDate(2018, 11, 10, 14, 0), myDate(2018, 11, 10, 22, 0)).
train(2, 'Train2', kyiv, kharkiv, myDate(2018, 11, 11, 12, 0), myDate(2018, 11, 11, 15, 0)).
train(3, 'Train3', kharkiv, chernigiv, myDate(2018, 11, 19, 13, 0), myDate(2018, 11, 12, 17, 0)).
train(4, 'Train4', kharkiv, sumy, myDate(2018, 11, 20, 12, 0), myDate(2018, 11, 20, 15, 30)).
train(5, 'Train5', kharkiv, dnipro, myDate(2018, 11, 20, 17, 15), myDate(2018, 11, 21, 8, 45)).
train(6, 'Train6', kyiv, mykolaiv, myDate(2018, 11, 21, 12, 30), myDate(2018, 11, 21, 17, 0)).
train(7, 'Train7', mykolaiv, odesa, myDate(2018, 11, 21, 18, 30), myDate(2018, 11, 22, 3, 20)).
train(8, 'Train8', odesa, chernivtsi, myDate(2018, 11, 22, 7, 0), myDate(2018, 11, 22, 12, 30)).
train(9, 'Train9', kyiv, rivne, myDate(2018, 11, 23, 15, 40), myDate(2018, 11, 23, 23, 55)).
train(10, 'Train10', kyiv, zhytomyr, myDate(2018, 11, 24, 11, 25), myDate(2018, 11, 24, 17, 5)).


/* Carriages */
addCarriage(1, compartment, 52, 50, 14.00).
addCarriage(1, platzkart, 100, 75, 7.00).

addCarriage(2, compartment, 25, 0, 25.50).

addCarriage(3, platzcart, 300, 117, 14.45).

/* Print train info */
showTrain(Num) :- 
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
showCarriage(TrainNum, CarType, Places, FreePlaces, Price) :- 
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
search(X, Y) :- searchWay(X, Y, myDate(1, 1, 1, 1, 1)).

searchWay(Y, Y, AllowedDeparture).
searchWay(X, Y, AllowedDeparture) :- 
    train(Num, _, X, Z, Departure, Arrival),
    (default_myDate(AllowedDeparture); isBiggerThan(Departure, AllowedDeparture)),
    searchWay(Z, Y, Arrival),
    showTrain(Num).

/* If contains car of type CarType */
addCarriage(TrainNum, CarType) :- 
    addCarriage(TrainNum, CarType, Places, FreePlaces, Price). 

searchCarriage(TrainNum, CarType) :-
    addCarriage(TrainNum, CarType, Places, FreePlaces, Price),
    showCarriage(TrainNum, CarType, Places, FreePlaces, Price).

/* If contains car with price lower than X */
findCheaperThan(TrainNum, Price) :-
    addCarriage(TrainNum, CarType, Places, FreePlaces, X),
    X < Price,
    showCarriage(TrainNum, CarType, Places, FreePlaces, X).
    
/* If contains route with 1 transfer */

hasMiddleStation(X, Y) :- 
    train(Num1, _, X, Z, _, Arrival1),
    train(Num2, _, Z, Y, Departure2, _),
    isBiggerThan(Departure2, Arrival1),
    showTrain(Num1),
    showTrain(Num2).