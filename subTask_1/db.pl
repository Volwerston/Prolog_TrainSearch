:- ensure_loaded([date_time]).

/* Trains */
train(1, 'Train1', lviv, kyiv, date_time(2018, 11, 10, 14, 0), date_time(2018, 11, 10, 22, 0)).
train(2, 'Train2', kyiv, kharkiv, date_time(2018, 11, 11, 12, 0), date_time(2018, 11, 11, 15, 0)).
train(3, 'Train3', kharkiv, chernigiv, date_time(2018, 11, 19, 13, 0), date_time(2018, 11, 12, 17, 0)).
train(4, 'Train4', kharkiv, sumy, date_time(2018, 11, 20, 12, 0), date_time(2018, 11, 20, 15, 30)).
train(5, 'Train5', kharkiv, dnipro, date_time(2018, 11, 20, 17, 15), date_time(2018, 11, 21, 8, 45)).
train(6, 'Train6', kyiv, mykolaiv, date_time(2018, 11, 21, 12, 30), date_time(2018, 11, 21, 17, 0)).
train(7, 'Train7', mykolaiv, odesa, date_time(2018, 11, 21, 18, 30), date_time(2018, 11, 22, 3, 20)).
train(8, 'Train8', odesa, chernivtsi, date_time(2018, 11, 22, 7, 0), date_time(2018, 11, 22, 12, 30)).
train(9, 'Train9', kyiv, rivne, date_time(2018, 11, 23, 15, 40), date_time(2018, 11, 23, 23, 55)).
train(10, 'Train10', kyiv, zhytomyr, date_time(2018, 11, 24, 11, 25), date_time(2018, 11, 24, 17, 5)).


/* Carriages */
hasCar(1, compartment, 52, 50, 14.00).
hasCar(1, platzkart, 100, 75, 7.00).

hasCar(2, compartment, 25, 0, 25.50).

hasCar(3, platzcart, 300, 117, 14.45).