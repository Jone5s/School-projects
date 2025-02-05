open System

type Coordinates = { Latitude: float; Longitude: float; }

let helsinkiLocation = { Latitude = 60.1708; Longitude = 24.9375; }
let londonLocation = { Latitude = 51.5072; Longitude = -0.1275; }

type City = { Name: string; Location: Coordinates; }

let helsinki = { Name = "Helsinki"
                 Location = { Latitude = 60.1708; Longitude = 24.9375; } }
let london = { Name = "London"
               Location = { Latitude = 51.5072; Longitude = -0.1275; } }

let degreesToRadians degrees = (Math.PI / 180.0) * degrees

let earthEquatorialRadius = 6378.137  // km

// Calculate the distance between two locations
// in kilometers using the Haversine formula.
let distanceBetween location1 location2 =
    let lat1 = degreesToRadians location1.Latitude
    let lon1 = degreesToRadians location1.Longitude

    let lat2 = degreesToRadians location2.Latitude
    let lon2 = degreesToRadians location2.Longitude

    let dlon = lon2 - lon1
    let dlat = lat2 - lat1

    let a = 
        pown (sin (dlat / 2.0)) 2 + 
        cos lat1 * cos lat2 * pown (sin (dlon / 2.0)) 2

    let c = 2.0 * atan2 (sqrt a) (sqrt (1.0 - a)) 

    earthEquatorialRadius * c

[<Literal>]
let foundingYear = 1958

type Country = { Code: string 
                 Name: string
                 Area: int
                 Population: int
                 Capital: City
                 Joined: DateOnly
                 Euro: DateOnly option
                 Schengen: DateOnly option
                 Exited: DateOnly option } with
    member this.PopulationDensity =
        this.Population / this.Area

let isCurrentMember country = country.Exited.IsNone
let isFoundingMember country = country.Joined.Year = foundingYear

let finland = { Code = "FI"
                Name = "Finland"
                Area = 338_472
                Population = 5_559_521
                Capital = { Name = "Helsinki"
                            Location = { Latitude = 60.1708; 
                                         Longitude = 24.9375; } }
                Joined = DateOnly(1995, 1, 1)
                Euro = Some(DateOnly(1999, 1, 1))
                Schengen = Some(DateOnly(2001, 3, 25))
                Exited = None }

let france = { Code = "FR"
               Name = "France"
               Area = 632_833
               Population = 67_897_000
               Capital = { Name = "Paris"
                           Location = { Latitude = 48.8567
                                        Longitude = 2.3508 } } 
               Joined = DateOnly(1958, 1, 1)
               Euro = Some(DateOnly(1999, 1, 1))
               Schengen = Some(DateOnly(1995, 3, 26))
               Exited = None }

printfn "%A" helsinkiLocation
printfn "%A" londonLocation
printfn "%f" (degreesToRadians 60.1708)

printfn "%A" helsinki
printfn "%A" london
printfn "The distance between %s and %s is about %.0f km."
    helsinki.Name london.Name
    (distanceBetween helsinki.Location london.Location)

printfn "%A" finland
printfn "The population density of Finland is %d persons / sq. km" 
    finland.PopulationDensity
if isCurrentMember finland then
    printfn "Finland is a current member of the European Union"
if isFoundingMember finland then
    printfn "Finland is a founding member of the European Union"
else
    printfn "Finland is not a founding member of the European Union"

printfn "%A" france
if isCurrentMember france then
    printfn "%s is a current member of the European Union" france.Name
if isFoundingMember france then
    printfn "%s is a founding member of the European Union" france.Name
else
    printfn "%s is not a founding member of the European Union" france.Name

let countries = [
    { Code = "AT"
      Name = "Austria"
      Area = 83879
      Population = 9027999
      Capital = { Name = "Vienna"
                  Location = { Latitude = 48.2089
                               Longitude = 16.3725 } }
      Joined = DateOnly(1995, 1, 1)
      Euro = Some(DateOnly(1999, 1, 1))
      Schengen = Some(DateOnly(2007, 12, 1))
      Exited = None }

    { Code = "BE"
      Name = "Belgium"
      Area = 30528
      Population = 11584008
      Capital = { Name = "Brussels"
                  Location = { Latitude = 50.85
                               Longitude = 4.35 } }
      Joined = DateOnly(1958, 1, 1)
      Euro = Some(DateOnly(1999, 1, 1))
      Schengen = Some(DateOnly(1995, 3, 26))
      Exited = None }

    { Code = "BG"
      Name = "Bulgaria"
      Area = 111002
      Population = 6520314
      Capital = { Name = "Sofia"
                  Location = { Latitude = 42.7
                               Longitude = 23.3333 } }
      Joined = DateOnly(2007, 1, 1)
      Euro = None
      Schengen = None
      Exited = None }

    { Code = "CY"
      Name = "Cyprus"
      Area = 9251
      Population = 1244188
      Capital = { Name = "Nicosia"
                  Location = { Latitude = 35.1667
                               Longitude = 33.3667 } }
      Joined = DateOnly(2004, 5, 1)
      Euro = Some(DateOnly(2008, 1, 1))
      Schengen = None
      Exited = None }

    { Code = "CZ"
      Name = "Czechia"
      Area = 78867
      Population = 10524167
      Capital = { Name = "Prague"
                  Location = { Latitude = 50.0833
                               Longitude = 14.4167 } }
      Joined = DateOnly(2004, 5, 1)
      Euro = None
      Schengen = Some(DateOnly(2007, 12, 21))
      Exited = None }

    { Code = "DE"
      Name = "Germany"
      Area = 357340
      Population = 83695430
      Capital = { Name = "Berlin"
                  Location = { Latitude = 52.5167
                               Longitude = 13.3833 } }
      Joined = DateOnly(1958, 1, 1)
      Euro = Some(DateOnly(1999, 1, 1))
      Schengen = Some(DateOnly(1995, 3, 26))
      Exited = None }

    { Code = "DK"
      Name = "Denmark"
      Area = 42921
      Population = 5910577
      Capital = { Name = "Copenhagen"
                  Location = { Latitude = 55.6761
                               Longitude = 12.5683 } }
      Joined = DateOnly(1973, 1, 1)
      Euro = None
      Schengen = Some(DateOnly(2001, 3, 25))
      Exited = None }

    { Code = "EE"
      Name = "Estonia"
      Area = 45227
      Population = 1331824
      Capital = { Name = "Tallinn"
                  Location = { Latitude = 59.4372
                               Longitude = 24.7453 } }
      Joined = DateOnly(2004, 1, 1)
      Euro = Some(DateOnly(2011, 1, 1))
      Schengen = Some(DateOnly(2007, 12, 21))
      Exited = None }

    { Code = "EL"
      Name = "Greece"
      Area = 131957
      Population = 10432481
      Capital = { Name = "Athens"
                  Location = { Latitude = 37.9667
                               Longitude = 23.7167 } }
      Joined = DateOnly(1981, 1, 1)
      Euro = Some(DateOnly(2001, 1, 1))
      Schengen = Some(DateOnly(2000, 1, 1))
      Exited = None }

    { Code = "ES"
      Name = "Spain"
      Area = 505970
      Population = 47450795
      Capital = { Name = "Madrid"
                  Location = { Latitude = 40.3833
                               Longitude = -3.7167 } }
      Joined = DateOnly(1986, 1, 1)
      Euro = Some(DateOnly(1999, 1, 1))
      Schengen = Some(DateOnly(1995, 3, 26))
      Exited = None }

    { Code = "FI"
      Name = "Finland"
      Area = 338472
      Population = 5559521
      Capital = { Name = "Helsinki"
                  Location = { Latitude = 60.1708
                               Longitude = 24.9375 } }
      Joined = DateOnly(1995, 1, 1)
      Euro = Some(DateOnly(1999, 1, 1))
      Schengen = Some(DateOnly(2001, 3, 25))
      Exited = None }

    { Code = "GB"
      Name = "Great Britain"
      Area = 243610
      Population = 67791000
      Capital = { Name = "London"
                  Location = { Latitude = 51.5072
                               Longitude = -0.1275 } }
      Joined = DateOnly(1973, 1, 1)
      Euro = None
      Schengen = None
      Exited = Some(DateOnly(2020, 1, 31)) }

    { Code = "FR"
      Name = "France"
      Area = 632833
      Population = 67897000
      Capital = { Name = "Paris"
                  Location = { Latitude = 48.8567
                               Longitude = 2.3508 } }
      Joined = DateOnly(1958, 1, 1)
      Euro = Some(DateOnly(1999, 1, 1))
      Schengen = Some(DateOnly(1995, 3, 26))
      Exited = None }

    { Code = "HR"
      Name = "Croatia"
      Area = 56594
      Population = 3888529
      Capital = { Name = "Zagreb"
                  Location = { Latitude = 45.8167
                               Longitude = 15.9833 } }
      Joined = DateOnly(2013, 7, 1)
      Euro = Some(DateOnly(2023, 1, 1))
      Schengen = Some(DateOnly(2023, 1, 1))
      Exited = None }

    { Code = "HU"
      Name = "Hungary"
      Area = 93024
      Population = 9749763
      Capital = { Name = "Budapest"
                  Location = { Latitude = 47.4719
                               Longitude = 19.0503 } }
      Joined = DateOnly(2004, 1, 1)
      Euro = None
      Schengen = Some(DateOnly(2007, 12, 21))
      Exited = None }

    { Code = "IE"
      Name = "Ireland"
      Area = 69797
      Population = 5123536
      Capital = { Name = "Dublin"
                  Location = { Latitude = 53.3478
                               Longitude = -6.2597 } }
      Joined = DateOnly(1973, 1, 1)
      Euro = Some(DateOnly(1999, 1, 1))
      Schengen = None
      Exited = None }

    { Code = "IT"
      Name = "Italy"
      Area = 302073
      Population = 58983000
      Capital = { Name = "Rome"
                  Location = { Latitude = 41.9
                               Longitude = 12.5 } }
      Joined = DateOnly(1958, 1, 1)
      Euro = Some(DateOnly(1999, 1, 1))
      Schengen = Some(DateOnly(1997, 10, 26))
      Exited = None }

    { Code = "LT"
      Name = "Lithuania"
      Area = 65300
      Population = 2832718
      Capital = { Name = "Vilnius"
                  Location = { Latitude = 54.6833
                               Longitude = 25.2833 } }
      Joined = DateOnly(2004, 5, 1)
      Euro = Some(DateOnly(2015, 1, 1))
      Schengen = Some(DateOnly(2007, 12, 21))
      Exited = None }

    { Code = "LU"
      Name = "Luxembourg"
      Area = 2586
      Population = 645397
      Capital = { Name = "Luxembourg"
                  Location = { Latitude = 49.6117
                               Longitude = 6.13 } }
      Joined = DateOnly(1958, 1, 1)
      Euro = Some(DateOnly(1999, 1, 1))
      Schengen = Some(DateOnly(1995, 3, 26))
      Exited = None }

    { Code = "LV"
      Name = "Latvia"
      Area = 64573
      Population = 1907675
      Capital = { Name = "Riga"
                  Location = { Latitude = 56.9489
                               Longitude = 24.1064 } }
      Joined = DateOnly(2004, 5, 1)
      Euro = Some(DateOnly(2014, 1, 1))
      Schengen = Some(DateOnly(2007, 12, 21))
      Exited = None }

    { Code = "MT"
      Name = "Malta"
      Area = 316
      Population = 519562
      Capital = { Name = "Valletta"
                  Location = { Latitude = 35.8978
                               Longitude = 14.5125 } }
      Joined = DateOnly(2004, 5, 1)
      Euro = Some(DateOnly(2008, 1, 1))
      Schengen = Some(DateOnly(2007, 12, 21))
      Exited = None }

    { Code = "NL"
      Name = "Netherlands"
      Area = 41540
      Population = 17740000
      Capital = { Name = "Amsterdam"
                  Location = { Latitude = 52.3731
                               Longitude = 4.8922 } }
      Joined = DateOnly(1958, 1, 1)
      Euro = Some(DateOnly(1999, 1, 1))
      Schengen = Some(DateOnly(1995, 3, 26))
      Exited = None }

    { Code = "PL"
      Name = "Poland"
      Area = 312679
      Population = 38179800
      Capital = { Name = "Warsaw"
                  Location = { Latitude = 52.2333
                               Longitude = 21.0167 } }
      Joined = DateOnly(2004, 5, 1)
      Euro = None
      Schengen = Some(DateOnly(2007, 12, 21))
      Exited = None }

    { Code = "PT"
      Name = "Portugal"
      Area = 92225
      Population = 10344802
      Capital = { Name = "Lisbon"
                  Location = { Latitude = 38.7136
                               Longitude = -9.1392 } }
      Joined = DateOnly(1986, 1, 1)
      Euro = Some(DateOnly(1999, 1, 1))
      Schengen = Some(DateOnly(1995, 3, 26))
      Exited = None }

    { Code = "RO"
      Name = "Romania"
      Area = 238391
      Population = 19038098
      Capital = { Name = "Bucharest"
                  Location = { Latitude = 44.4325
                               Longitude = 26.1039 } }
      Joined = DateOnly(2007, 1, 1)
      Euro = None
      Schengen = None
      Exited = None }

    { Code = "SE"
      Name = "Sweden"
      Area = 438574
      Population = 10481937
      Capital = { Name = "Stockholm"
                  Location = { Latitude = 59.3294
                               Longitude = 18.0686 } }
      Joined = DateOnly(1995, 1, 1)
      Euro = None
      Schengen = Some(DateOnly(2001, 3, 25))
      Exited = None }

    { Code = "SK"
      Name = "Slovakia"
      Area = 49035
      Population = 5460185
      Capital = { Name = "Bratislava"
                  Location = { Latitude = 48.1439
                               Longitude = 17.1097 } }
      Joined = DateOnly(2004, 5, 1)
      Euro = Some(DateOnly(2009, 1, 1))
      Schengen = Some(DateOnly(2007, 12, 21))
      Exited = None }

    { Code = "SI"
      Name = "Slovenia"
      Area = 20273
      Population = 2108708
      Capital = { Name = "Ljubljana"
                  Location = { Latitude = 46.0556
                               Longitude = 14.5083 } }
      Joined = DateOnly(2004, 5, 1)
      Euro = Some(DateOnly(2007, 1, 1))
      Schengen = Some(DateOnly(2007, 12, 21))
      Exited = None }
]

printfn "countries has %d elements" countries.Length

// Check out https://fsharpforfunandprofit.com/posts/list-module-functions/

let founders = countries |> Seq.filter (fun c -> isFoundingMember c)
printfn "Founders (joined in %d):" foundingYear
for country in founders do
    printfn "    %s" country.Name 

let smallCountries = countries |> Seq.filter (fun c -> c.Area < 10_000)
printfn "Small countries (area less than 10,000 km\xB2):"
for country in smallCountries do
    printfn "    %s" country.Name

let mostPopulousCountry = 
    countries |> Seq.sortByDescending (fun c -> c.Population) |> Seq.item 0
printfn "The most populous country is %s with %d inhabitants" 
    mostPopulousCountry.Name mostPopulousCountry.Population

let startingWithS = 
    countries |> Seq.filter (fun c -> c.Name.StartsWith('S'))
printfn "Countries that start with an S:"
for country in startingWithS do
    printfn "    %s" country.Name

printfn "Countries that end with 'ia': %s" 
    (String.concat " " (countries 
                       |> Seq.filter (fun c -> c.Name.EndsWith("ia")) 
                       |> Seq.map (fun c -> c.Name) 
                       |> Seq.toList))

let currentMembers = countries |> List.filter (fun c -> isCurrentMember c)
printfn "Total population of the current %d members is %d"
    currentMembers.Length
    (currentMembers |> List.sumBy (fun c -> c.Population))
