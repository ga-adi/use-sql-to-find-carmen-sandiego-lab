-- Clue #1: We recently got word that someone fitting Carmen Sandiego's description has been
-- traveling through Southern Europe. She's most likely traveling someplace where she won't be noticed,
-- so find the least populated country in Southern Europe, and we'll start looking for her there.
code: 
select * from country where region like '%southern europe%' order by population asc;
result:
VAT|Holy See (Vatican City State)|Europe|Southern Europe|0.40000001|1929|1000||9|\N|Santa Sede/Citt� del Vaticano|Independent Church State|Johannes Paavali II|3538|VA

-- Clue #2: Now that we're here, we have insight that Carmen was seen attending language classes in
-- this country's officially recognized language. Check our databases and find out what language is
-- spoken in this country, so we can call in a translator to work with you.

code: 
select * from countrylanguage where countrycode = "VAT";
result:
VAT|Italian|t|0.0


-- Clue #3: We have new news on the classes Carmen attended – our gumshoes tell us she's moved on
-- to a different country, a country where people speak only the language she was learning. Find out which
--  nearby country speaks nothing but that language.

code (process):
select * from countrylanguage where "language" like '%italian%' order by countrycode;
result:
ARG|Italian|f|1.7
AUS|Italian|f|2.2
BEL|Italian|f|2.4000001
BRA|Italian|f|0.40000001
CAN|Italian|f|1.7
CHE|Italian|t|7.6999998
DEU|Italian|f|0.69999999
FRA|Italian|f|0.40000001
ITA|Italian|t|94.099998
LIE|Italian|f|2.5
LUX|Italian|f|4.5999999
MCO|Italian|f|16.1
SMR|Italian|t|100.0
USA|Italian|f|0.60000002
VAT|Italian|t|0.0

eliminating the "f" ones, we have left
CHE|Italian|t|7.6999998
ITA|Italian|t|94.099998
SMR|Italian|t|100.0
VAT|Italian|t|0.0

select * from countrylanguage where countrycode = "CHE";   // <-- not this one!
CHE|French|t|19.200001
CHE|German|t|63.599998
CHE|Italian|t|7.6999998
CHE|Romansh|t|0.60000002

select * from countrylanguage where countrycode = "ITA";  // <-- not this one!
ITA|Albaniana|f|0.2
ITA|French|f|0.5
ITA|Friuli|f|1.2
ITA|German|f|0.5
ITA|Italian|t|94.099998
ITA|Romani|f|0.2
ITA|Sardinian|f|2.7
ITA|Slovene|f|0.2

select * from countrylanguage where countrycode = "SMR";  // <-- YES, This one!
SMR|Italian|t|100.0

select * from countrylanguage where countrycode = "VAT";  // <-- not this one because she moved to a different country
VAT|Italian|t|0.0

result:  SMR|Italian|t|100.0

-- Clue #4: We're booking the first flight out – maybe we've actually got a chance to catch her this time.
 -- There are only two cities she could be flying to in the country. One is named the same as the country – that
 -- would be too obvious. We're following our gut on this one; find out what other city in that country she might
 --  be flying to.

code process:
select * from city where countrycode = "SMR";
3170|Serravalle|SMR|Serravalle/Dogano|4802
3171|San Marino|SMR|San Marino|2294

result:  Serravalle

-- Clue #5: Oh no, she pulled a switch – there are two cities with very similar names, but in totally different
-- parts of the globe! She's headed to South America as we speak; go find a city whose name is like the one we were
-- headed to, but doesn't end the same. Find out the city, and do another search for what country it's in. Hurry!

code process:
select * from city where name like '%serra%';
265|Serra|BRA|Esp�rito Santo|302666
310|Tabo�o da Serra|BRA|S�o Paulo|197550
370|Itapecerica da Serra|BRA|S�o Paulo|126672
3170|Serravalle|SMR|Serravalle/Dogano|4802

select * from country where code = "BRA";
BRA|Brazil|South America|South America|8547403.0|1822|170115000|62.900002|776739|804108|Brasil|Federal Republic|Fernando Henrique Cardoso|211|BR

result:  BRAZIL 



-- Clue #6: We're close! Our South American agent says she just got a taxi at the airport, and is headed towards
 -- the capital! Look up the country's capital, and get there pronto! Send us the name of where you're headed and we'll
 -- follow right behind you!

select * from country where name = "Brazil";
BRA|Brazil|South America|South America|8547403.0|1822|170115000|62.900002|776739|804108|Brasil|Federal Republic|Fernando Henrique Cardoso|211|BR

capital code#211

select * from city where id = 211;
211|Bras�lia|BRA|Distrito Federal|1969868

name of city : Brasília


-- Clue #7: She knows we're on to her – her taxi dropped her off at the international airport, and she beat us to
 -- the boarding gates. We have one chance to catch her, we just have to know where she's heading and beat her to the
 -- landing dock.

-- Clue #8: Lucky for us, she's getting cocky. She left us a note, and I'm sure she thinks she's very clever, but
-- if we can crack it, we can finally put her where she belongs – behind bars.

-- Our play date of late has been unusually fun –
-- As an agent, I'll say, you've been a joy to outrun.
-- And while the food here is great, and the people – so nice!
-- I need a little more sunshine with my slice of life.
-- So I'm off to add one to the population I find
-- In a city of ninety-one thousand and now, eighty five.  91,084

code process:
select * from city where population = 91084;

4060|Santa Monica|USA|California|91084

result: Santa Monica, CA USA



-- We're counting on you, gumshoe. Find out where she's headed, send us the info, and we'll be sure to meet her at the gates with bells on.



-- She's in _____Santa Monica, CA USA_______________________!
