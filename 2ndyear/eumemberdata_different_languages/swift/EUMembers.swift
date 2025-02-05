import Foundation

struct Coordinate {
    var latitude: Double = 0.0
    var longitude: Double = 0.0
}

class City {
    var name: String
    var location: Coordinate

    init(name: String, location: Coordinate) {
        self.name = name
        self.location = location
    }
}

enum EventType {
    case joinedUnion
    case joinedEurozone
    case joinedSchengen
    case exitedUnion
}

struct Event: CustomStringConvertible {
    var country: Country
    var eventType: EventType
    var date: String

    var description: String {
        return "\(country.name) \(eventType) \(date)"
    }
}

protocol Member {
    var joinedUnionDate: String { get }
    var joinedEurozoneDate: String? { get }
    var joinedSchengenDate: String? { get }
    var exitedUnionDate: String? { get }
    func isFounder() -> Bool
}

class Country: Member, CustomStringConvertible {
    var code: String
    var name: String = "unknown"
    var capital: City?
    var area: Int = 0
    var population: Int = 0

    init(code: String, name: String, capital: City?, area: Int, population: Int,
        joined: String, exited: String? = nil) {
        self.code = code
        self.name = name
        self.capital = capital
        self.area = area
        self.population = population
        self.joinedUnionDate = joined
        self.exitedUnionDate = exited
    }

    var populationDensity: Int {
        guard area != 0 && population != 0 else {
            return 0
        }
        return population / area
    }

    var description: String {
        return self.name
    }

    //
    // MARK: - Member protocol implementation
    //
    var joinedUnionDate: String
    var joinedEurozoneDate: String? = nil
    var joinedSchengenDate: String? = nil
    var exitedUnionDate: String? = nil

    func isFounder() -> Bool {
        return self.joinedUnionDate == "1958-01-01"
    }
}

let officialLanguages = [
    "bg", "cs", "da", "de", "el", "en", "es", "et", "fi", "fr", "ga", "hr", "hu",
    "it", "lt", "lv", "mt", "nl", "pl", "pt", "ro", "sk", "sl", "sv"
]

let cityNames: [String: [String: String]] = [
    "amsterdam": [
        "bg": "Амстердам",
        "cs": "Amsterdam",
        "da": "Amsterdam",
        "de": "Amsterdam",
        "el": "Άμστερνταμ",
        "en": "Amsterdam",
        "es": "Ámsterdam",
        "et": "Amsterdam",
        "fi": "Amsterdam",
        "fr": "Amsterdam",
        "ga": "Amstardam",
        "hr": "Amsterdam",
        "hu": "Amszterdam",
        "it": "Amsterdam",
        "lt": "Amsterdamas",
        "lv": "Amsterdama",
        "mt": "Amsterdam",
        "nl": "Amsterdam",
        "pl": "Amsterdam",
        "pt": "Amesterdão",
        "ro": "Amsterdam",
        "sk": "Amsterdam",
        "sl": "Amsterdam",
        "sv": "Amsterdam"
    ],

    "brussels": [
        "bg": "Брюксел",
        "cs": "Brusel",
        "da": "Bruxelles",
        "de": "Brüssel",
        "el": "Βρυξέλλες",
        "en": "Brussels",
        "es": "Bruselas",
        "et": "Brüssel",
        "fi": "Brysseli",
        "fr": "Bruxelles",
        "ga": "an Bhruiséil",
        "hr": "Bruxelles",
        "hu": "Brüsszel",
        "it": "Bruxelles",
        "lt": "Briuselis",
        "lv": "Brisele",
        "mt": "Brussell",
        "nl": "Brussel",
        "pl": "Bruksela",
        "pt": "Bruxelas",
        "ro": "Bruxelles",
        "sk": "Brusel",
        "sl": "Bruselj",
        "sv": "Bryssel"
    ],

    "vienna": [
        "bg": "Виена",
        "cs": "Vídeň",
        "da": "Wien",
        "de": "Wien",
        "el": "Βιέννη",
        "en": "Vienna",
        "es": "Viena",
        "et": "Viin",
        "fi": "Wien",
        "fr": "Vienne",
        "ga": "Vín",
        "hr": "Beč",
        "hu": "Bécs",
        "it": "Vienna",
        "lt": "Viena",
        "lv": "Vīne",
        "mt": "Vjenna",
        "nl": "Wenen",
        "pl": "Wiedeń",
        "pt": "Viena",
        "ro": "Viena",
        "sk": "Viedeň",
        "sl": "Dunaj",
        "sv": "Wien"
    ],


    "zagreb": [
        "bg": "Загреб",
        "cs": "Záhřeb",
        "da": "Zagreb",
        "de": "Zagreb",
        "el": "Ζάγκρεμπ",
        "en": "Zagreb",
        "es": "Zagreb",
        "et": "Zagreb",
        "fi": "Zagreb",
        "fr": "Zagreb",
        "ga": "Ságrab",
        "hr": "Zagreb",
        "hu": "Zágráb",
        "it": "Zagabria",
        "lt": "Zagrebas",
        "lv": "Zagreba",
        "mt": "Żagreb",
        "nl": "Zagreb",
        "pl": "Zagrzeb",
        "pt": "Zagrebe",
        "ro": "Zagreb",
        "sk": "Záhreb",
        "sl": "Zagreb",
        "sv": "Zagreb"
    ],

    "nicosia": [
        "bg": "Никозия",
        "cs": "Nikósie",
        "da": "Nicosia",
        "de": "Nikosia",
        "el": "Λευκωσία",
        "en": "Nicosia",
        "es": "Nicosia",
        "et": "Nikosia",
        "fi": "Nikosia",
        "fr": "Nicosie",
        "ga": "an Niocóis",
        "hr": "Nikozija",
        "hu": "Nicosia",
        "it": "Nicosia",
        "lt": "Nikosija",
        "lv": "Nikozija",
        "mt": "Nikosija",
        "nl": "Nicosia",
        "pl": "Nikozja",
        "pt": "Nicósia",
        "ro": "Nicosia",
        "sk": "Nikózia",
        "sl": "Nikozija",
        "sv": "Nicosia"
    ],

    "prague": [
        "bg": "Прага",
        "cs": "Praha",
        "da": "Prag",
        "de": "Prag",
        "el": "Πράγα",
        "en": "Prague",
        "es": "Praga",
        "et": "Praha",
        "fi": "Praha",
        "fr": "Prague",
        "ga": "Prág",
        "hr": "Prag",
        "hu": "Prága",
        "it": "Praga",
        "lt": "Praha",
        "lv": "Prāga",
        "mt": "Praga",
        "nl": "Praag",
        "pl": "Praga",
        "pt": "Praga",
        "ro": "Praga",
        "sk": "Praha",
        "sl": "Praga",
        "sv": "Prag"
    ],

    "copenhagen": [
        "bg": "Копенхаген",
        "cs": "Kodaň",
        "da": "København",
        "de": "Kopenhagen",
        "el": "Κοπεγχάγη",
        "en": "Copenhagen",
        "es": "Copenhague",
        "et": "Kopenhaagen",
        "fi": "Kööpenhamina",
        "fr": "Copenhague",
        "ga": "Cóbanhávan",
        "hr": "Kopenhagen",
        "hu": "Koppenhága",
        "it": "Copenaghen",
        "lt": "Kopenhaga",
        "lv": "Kopenhāgena",
        "mt": "Kopenħagen",
        "nl": "Kopenhagen",
        "pl": "Kopenhaga",
        "pt": "Copenhaga",
        "ro": "Copenhaga",
        "sk": "Kodaň",
        "sl": "København",
        "sv": "Köpenhamn"
    ],

    "tallinn": [
        "bg": "Талин",
        "cs": "Tallinn",
        "da": "Tallinn",
        "de": "Tallinn",
        "el": "Ταλίν",
        "en": "Tallinn",
        "es": "Tallin",
        "et": "Tallinn",
        "fr": "Tallinn",
        "fi": "Tallinna",
        "ga": "Taillinn",
        "hr": "Tallinn",
        "hu": "Tallinn",
        "it": "Tallinn",
        "lt": "Talinas",
        "lv": "Tallina",
        "mt": "Talinn",
        "nl": "Tallinn",
        "pl": "Tallin",
        "pt": "Taline",
        "ro": "Tallinn",
        "sk": "Tallinn",
        "sl": "Talin",
        "sv": "Tallinn"
    ],

    "helsinki": [
        "bg": "Хелзинки",
        "cs": "Helsinky",
        "da": "Helsinki",
        "de": "Helsinki",
        "el": "Ελσίνκι",
        "en": "Helsinki",
        "es": "Helsinki",
        "et": "Helsingi",
        "fi": "Helsinki",
        "fr": "Helsinki",
        "ga": "Heilsincí",
        "hr": "Helsinki",
        "hu": "Helsinki",
        "it": "Helsinki",
        "lt": "Helsinkis",
        "lv": "Helsinki",
        "mt": "Ħelsinki",
        "nl": "Helsinki",
        "pl": "Helsinki",
        "pt": "Helsínquia",
        "ro": "Helsinki",
        "sk": "Helsinki",
        "sl": "Helsinki",
        "sv": "Helsingfors"
    ],

    "paris": [
        "bg": "Париж",
        "cs": "Paříž",
        "da": "Paris",
        "de": "Paris",
        "el": "Παρίσι",
        "en": "Paris",
        "es": "París",
        "et": "Pariis",
        "fi": "Pariisi",
        "fr": "Paris",
        "ga": "Páras",
        "hr": "Pariz",
        "hu": "Párizs",
        "it": "Parigi",
        "lt": "Paryžius",
        "lv": "Parīze",
        "mt": "Pariġi",
        "nl": "Parijs",
        "pl": "Paryż",
        "pt": "Paris",
        "ro": "Paris",
        "sk": "Paríž",
        "sl": "Pariz",
        "sv": "Paris"
    ],

    "berlin": [
        "bg": "Берлин",
        "cs": "Berlin",
        "da": "Berlin",
        "de": "Berlin",
        "el": "Βερολίνο",
        "en": "Berlin",
        "es": "Berlín",
        "et": "Berliin",
        "fi": "Berliini",
        "fr": "Berlin",
        "ga": "Beirlín",
        "hr": "Berlin",
        "hu": "Berlin",
        "it": "Berlino",
        "lt": "Berlynas",
        "lv": "Berlīne",
        "mt": "Berlin",
        "nl": "Berlijn",
        "pl": "Berlin",
        "pt": "Berlim",
        "ro": "Berlin",
        "sk": "Berlín",
        "sl": "Berlin",
        "sv": "Berlin"
    ],

    "athens": [
        "bg": "Атина",
        "cs": "Atény",
        "da": "Athen",
        "de": "Athen",
        "el": "Αθήνα",
        "en": "Athens",
        "es": "Atenas",
        "et": "Ateena",
        "fi": "Ateena",
        "fr": "Athènes",
        "ga": "An Aithin",
        "hr": "Atena",
        "hu": "Athén",
        "it": "Atene",
        "lt": "Atėnai",
        "lv": "Atēnas",
        "mt": "Ateni",
        "nl": "Athene",
        "pl": "Ateny",
        "pt": "Atenas",
        "ro": "Atena",
        "sk": "Atény",
        "sl": "Atene",
        "sv": "Aten"
    ],

    "budapest": [
        "bg": "Будапеща",
        "cs": "Budapešť",
        "da": "Budapest",
        "de": "Budapest",
        "el": "Βουδαπέστη",
        "en": "Budapest",
        "es": "Budapest",
        "et": "Budapest",
        "fi": "Budapest",
        "fr": "Budapest",
        "ga": "Búdaipeist",
        "hr": "Budimpešta",
        "hu": "Budapest",
        "it": "Budapest",
        "lt": "Budapeštas",
        "lv": "Budapešta",
        "mt": "Budapest",
        "nl": "Boedapest",
        "pl": "Budapeszt",
        "pt": "Budapeste",
        "ro": "Budapesta",
        "sk": "Budapešť",
        "sl": "Budimpešta",
        "sv": "Budapest"
    ],

    "dublin": [
        "bg": "Дъблин",
        "cs": "Dublin",
        "da": "Dublin",
        "de": "Dublin",
        "el": "Δουβλίνο",
        "en": "Dublin",
        "es": "Dublín",
        "et": "Dublin",
        "fi": "Dublin",
        "fr": "Dublin",
        "ga": "Baile Átha Cliath",
        "hr": "Dublin",
        "hu": "Dublin",
        "it": "Dublino",
        "lt": "Dublinas",
        "lv": "Dublina",
        "mt": "Dublin",
        "nl": "Dublin",
        "pl": "Dublin",
        "pt": "Dublin",
        "ro": "Dublin",
        "sk": "Dublin",
        "sl": "Dublin",
        "sv": "Dublin"
    ],

    "rome": [
        "bg": "Рим",
        "cs": "Řím",
        "da": "Rom",
        "de": "Rom",
        "el": "Ρώμη",
        "en": "Rome",
        "es": "Roma",
        "et": "Rooma",
        "fi": "Rooma",
        "fr": "Rome",
        "ga": "an Róimh",
        "hr": "Rim",
        "hu": "Róma",
        "it": "Roma",
        "lt": "Roma",
        "lv": "Roma",
        "mt": "Ruma",
        "nl": "Rome",
        "pl": "Rzym",
        "pt": "Roma",
        "ro": "Roma",
        "sk": "Rím",
        "sl": "Rim",
        "sv": "Rom"
    ],

    "riga": [
        "bg": "Рига",
        "cs": "Riga",
        "da": "Riga",
        "de": "Riga",
        "el": "Ρίγα",
        "en": "Riga",
        "es": "Riga",
        "et": "Riia",
        "fi": "Riika",
        "fr": "Riga",
        "ga": "Ríge",
        "hr": "Riga",
        "hu": "Riga",
        "it": "Riga",
        "lt": "Ryga",
        "lv": "Rīga",
        "mt": "Riga",
        "nl": "Riga",
        "pl": "Ryga",
        "pt": "Riga",
        "ro": "Riga",
        "sk": "Riga",
        "sl": "Riga",
        "sv": "Riga"
    ],

    "vilnius": [
        "bg": "Вилнюс",
        "cs": "Vilnius",
        "da": "Vilnius",
        "de": "Wilna (Vilnius)",
        "el": "Βίλνιους",
        "en": "Vilnius",
        "es": "Vilna",
        "et": "Vilnius",
        "fi": "Vilna",
        "fr": "Vilnius",
        "ga": "Vilnias",
        "hr": "Vilnius",
        "hu": "Vilnius",
        "it": "Vilnius",
        "lt": "Vilnius",
        "lv": "Viļņa",
        "mt": "Vilnjus",
        "nl": "Vilnius",
        "pl": "Wilno",
        "pt": "Vilnius",
        "ro": "Vilnius",
        "sk": "Vilnius",
        "sl": "Vilna",
        "sv": "Vilnius"
    ],

    "valletta": [
        "bg": "Валета",
        "cs": "Valetta",
        "da": "Valletta",
        "de": "Valletta",
        "el": "Βαλέτα",
        "en": "Valletta",
        "es": "La Valeta",
        "et": "Valletta",
        "fi": "Valletta",
        "fr": "La Valette",
        "ga": "Vaileite",
        "hr": "Valletta",
        "hu": "Valletta",
        "it": "La Valletta",
        "lt": "Valeta",
        "lv": "Valeta",
        "mt": "Valletta",
        "nl": "Valletta",
        "pl": "Valletta",
        "pt": "Valeta",
        "ro": "Valletta",
        "sk": "Valletta",
        "sl": "Valletta",
        "sv": "Valletta"
    ],

    "warsaw": [
        "bg": "Варшава",
        "cs": "Varšava",
        "da": "Warszawa",
        "de": "Warschau",
        "el": "Βαρσοβία",
        "en": "Warsaw",
        "es": "Varsovia",
        "et": "Varssavi",
        "fi": "Varsova",
        "fr": "Varsovie",
        "ga": "Vársá",
        "hr": "Varšava",
        "hu": "Varsó",
        "it": "Varsavia",
        "lt": "Varšuva",
        "lv": "Varšava",
        "mt": "Varsavja",
        "nl": "Warschau",
        "pl": "Warszawa",
        "pt": "Varsóvia",
        "ro": "Varșovia",
        "sk": "Varšava",
        "sl": "Varšava",
        "sv": "Warszawa"
    ],

    "lisbon": [
        "bg": "Лисабон",
        "cs": "Lisabon",
        "da": "Lissabon",
        "de": "Lissabon",
        "el": "Λισαβόνα",
        "en": "Lisbon",
        "es": "Lisboa",
        "et": "Lissabon",
        "fi": "Lissabon",
        "fr": "Lisbonne",
        "ga": "Liospóin",
        "hr": "Lisabon",
        "hu": "Lisszabon",
        "it": "Lisbona",
        "lt": "Lisabona",
        "lv": "Lisabona",
        "mt": "Lisbona",
        "nl": "Lissabon",
        "pl": "Lizbona",
        "pt": "Lisboa",
        "ro": "Lisabona",
        "sk": "Lisabon",
        "sl": "Lizbona",
        "sv": "Lissabon"
    ],

    "ljubljana": [
        "bg": "Любляна",
        "cs": "Lublaň",
        "da": "Ljubljana",
        "de": "Ljubljana",
        "el": "Λιουμπλιάνα",
        "en": "Ljubljana",
        "es": "Liubliana",
        "et": "Ljubljana",
        "fi": "Ljubljana",
        "fr": "Ljubljana",
        "ga": "Liúibleána",
        "hr": "Ljubljana",
        "hu": "Ljubljana",
        "it": "Lubiana",
        "lt": "Liubliana",
        "lv": "Ļubļana",
        "mt": "Ljubljana",
        "nl": "Ljubljana",
        "pl": "Lublana",
        "pt": "Liubliana",
        "ro": "Ljubljana",
        "sk": "Ljubljana",
        "sl": "Ljubljana",
        "sv": "Ľubľana"
    ],

    "luxembourg": [
        "bg": "Люксембург",
        "cs": "Lucemburk",
        "da": "Luxembourg",
        "de": "Luxemburg",
        "el": "Λουξεμβούργο",
        "en": "Luxembourg",
        "es": "Luxemburgo",
        "et": "Luxembourg",
        "fi": "Luxemburg",
        "fr": "Luxembourg",
        "ga": "Lucsamburg",
        "hr": "Luxembourg",
        "hu": "Luxembourg",
        "it": "Lussemburgo",
        "lt": "Liuksemburgas",
        "lv": "Luksemburga",
        "mt": "Il-Lussemburgu",
        "nl": "Luxemburg",
        "pl": "Luksemburg",
        "pt": "Luxemburgo",
        "ro": "Luxemburg",
        "sk": "Luxemburg",
        "sl": "Luxembourg",
        "sv": "Luxemburg"
    ],

    "bucharest": [
        "bg": "Букурещ",
        "cs": "Bukurešť",
        "da": "Bukarest",
        "de": "Bukarest",
        "el": "Βουκουρέστι",
        "en": "Bucharest",
        "es": "Bucarest",
        "et": "Bukarest",
        "fi": "Bukarest",
        "fr": "Bucarest",
        "ga": "Búcairist",
        "hr": "Bukurešt",
        "hu": "Bukarest",
        "it": "Bucharest",
        "lt": "Bukareštas",
        "lv": "Bukareste",
        "mt": "Bukarest",
        "nl": "Boekarest",
        "pl": "Bukareszt",
        "pt": "Bucareste",
        "ro": "București",
        "sk": "Bukurešť",
        "sl": "Bukarešta",
        "sv": "Bukarest"
    ],

    "bratislava": [
        "bg": "Братислава",
        "cs": "Bratislava",
        "da": "Bratislava",
        "de": "Bratislava",
        "el": "Μπρατισλάβα",
        "en": "Bratislava",
        "es": "Bratislava",
        "et": "Bratislava",
        "fi": "Bratislava",
        "fr": "Bratislava",
        "ga": "an Bhratasláiv",
        "hr": "Bratislava",
        "hu": "Pozsony",
        "it": "Bratislava",
        "lt": "Bratislava",
        "lv": "Bratislava",
        "mt": "Bratislava",
        "nl": "Bratislava",
        "pl": "Bratysława",
        "pt": "Bratislava",
        "ro": "Bratislava",
        "sk": "Bratislava",
        "sl": "Bratislava",
        "sv": "Bratislava"
    ],

    "madrid": [
        "bg": "Мадрид",
        "cs": "Madrid",
        "da": "Madrid",
        "de": "Madrid",
        "el": "Μαδρίτη",
        "en": "Madrid",
        "es": "Madrid",
        "et": "Madrid",
        "fi": "Madrid",
        "fr": "Madrid",
        "ga": "Maidrid",
        "hr": "Madrid",
        "hu": "Madrid",
        "it": "Madrid",
        "lt": "Madridas",
        "lv": "Madride",
        "mt": "Madrid",
        "nl": "Madrid",
        "pl": "Madryt",
        "pt": "Madrid",
        "ro": "Madrid",
        "sk": "Madrid",
        "sl": "Madrid",
        "sv": "Madrid"
    ],

    "stockholm": [
        "bg": "Стокхолм",
        "cs": "Stockholm",
        "da": "Stockholm",
        "de": "Stockholm",
        "el": "Στοκχόλμη",
        "en": "Stockholm",
        "es": "Estocolmo",
        "et": "Stockholm",
        "fi": "Tukholma",
        "fr": "Stockholm",
        "ga": "Stócólm",
        "hr": "Stockholm",
        "hu": "Stockholm",
        "it": "Stoccolma",
        "lt": "Stokholmas",
        "lv": "Stokholma",
        "mt": "Stokkolma",
        "nl": "Stockholm",
        "pl": "Sztokholm",
        "pt": "Estocolmo",
        "ro": "Stockholm",
        "sk": "Štokholm",
        "sl": "Stockholm",
        "sv": "Stockholm"
    ],

    "london": [
        "bg": "Лондон",
        "cs": "Londýn",
        "da": "London",
        "de": "London",
        "el": "Λονδίνο",
        "en": "London",
        "es": "Londres",
        "et": "London",
        "fi": "Lontoo",
        "fr": "Londres",
        "ga": "Londain",
        "hr": "London",
        "hu": "London",
        "it": "Londra",
        "lt": "Londonas",
        "lv": "Londona",
        "mt": "Londra",
        "nl": "Londen",
        "pl": "Londyn",
        "pt": "Londres",
        "ro": "Londra",
        "sk": "Londýn",
        "sl": "London",
        "sv": "London"
    ],

    "sofia": [
        "bg": "София",
        "cs": "Sofie",
        "da": "Sofia",
        "de": "Sofia",
        "el": "Σόφια",
        "en": "Sofia",
        "es": "Sofía",
        "et": "Sofia",
        "fi": "Sofia",
        "fr": "Sofia",
        "ga": "Sóifia",
        "hr": "Sofija",
        "hu": "Szófia",
        "it": "Sofia",
        "lt": "Sofija",
        "lv": "Sofija",
        "mt": "Sofia",
        "nl": "Sofia",
        "pl": "Sofia",
        "pt": "Sófia",
        "ro": "Sofia",
        "sk": "Sofia",
        "sl": "Sofija",
        "sv": "Sofia"
    ]
]

let countryNames = [
    "AT": [
        "bg": "Австрия",
        "cs": "Rakousko",
        "da": "Østrig",
        "de": "Österreich",
        "el": "Αυστρία",
        "en": "Austria",
        "es": "Austria",
        "et": "Austria",
        "fi": "Itävalta",
        "fr": "Autriche",
        "ga": "An Ostair",
        "hr": "Austrija",
        "hu": "Ausztria",
        "it": "Austria",
        "lt": "Austrija",
        "lv": "Austrija",
        "mt": "L-Awstrija",
        "nl": "Oostenrijk",
        "pl": "Austria",
        "pt": "Áustria",
        "ro": "Austria",
        "sk": "Rakúsko",
        "sl": "Avstrija",
        "sv": "Österrike"
    ],

    "BE": [
        "bg": "Белгия",
        "cs": "Belgie",
        "da": "Belgien",
        "de": "Belgien",
        "el": "Βέλγιο",
        "en": "Belgium",
        "es": "Bélgica",
        "et": "Belgia",
        "fi": "Belgia",
        "fr": "Belgique",
        "ga": "An Bheilg",
        "hr": "Belgija",
        "hu": "Belgium",
        "it": "Belgio",
        "lt": "Belgija",
        "lv": "Beļģija",
        "mt": "Il-Belġju",
        "nl": "België",
        "pl": "Belgia",
        "pt": "Bélgica",
        "ro": "Belgia",
        "sk": "Belgicko",
        "sl": "Belgija",
        "sv": "Belgien"
    ],

    "BG": [
        "bg": "България",
        "cs": "Bulharsko",
        "da": "Bulgarien",
        "de": "Bulgarien",
        "el": "Βουλγαρία",
        "en": "Bulgaria",
        "es": "Bulgaria",
        "et": "Bulgaaria",
        "fi": "Bulgaria",
        "fr": "Bulgarie",
        "ga": "An Bhulgáir",
        "hr": "Bugarska",
        "hu": "Bulgária",
        "it": "Bulgaria",
        "lt": "Bulgarija",
        "lv": "Bulgārija",
        "mt": "Il-Bulgarija",
        "nl": "Bulgarije",
        "pl": "Bułgaria",
        "pt": "Bulgária",
        "ro": "Bulgaria",
        "sk": "Bulharsko",
        "sl": "Bolgarija",
        "sv": "Bulgarien"
    ],

    "CY": [
        "bg": "Кипър",
        "cs": "Kypr",
        "da": "Cypern",
        "de": "Zypern",
        "el": "Κύπρος",
        "en": "Cyprus",
        "es": "Chipre",
        "et": "Küpros",
        "fi": "Kypros",
        "fr": "Chypre",
        "ga": "An Chipir",
        "hr": "Cipar",
        "hu": "Ciprus",
        "it": "Cipro",
        "lt": "Kipras",
        "lv": "Kipra",
        "mt": "Ċipru",
        "nl": "Cyprus",
        "pl": "Cypr",
        "pt": "Chipre",
        "ro": "Cipru",
        "sk": "Cyprus",
        "sl": "Ciper",
        "sv": "Cypern"
    ],

    "CZ": [
        "bg": "Чешка република",
        "cs": "Česká republika",
        "da": "Tjekkiet",
        "de": "Tschechische Republik",
        "el": "Τσεχική Δημοκρατία",
        "en": "Czech Republic",
        "es": "República Checa",
        "et": "Tšehhi Vabariik",
        "fi": "Tšekki",
        "fr": "République tchèque",
        "ga": "Poblacht na Seice",
        "hr": "Češka",
        "hu": "Cseh Köztársaság",
        "it": "Repubblica ceca",
        "lt": "Čekija",
        "lv": "Čehija",
        "mt": "Ir-Repubblika Ċeka",
        "nl": "Tsjechië",
        "pl": "Czechy",
        "pt": "República Checa",
        "ro": "Republica Cehă",
        "sk": "Česká republika",
        "sl": "Češka",
        "sv": "Tjeckien"
    ],

    "DE": [
        "bg": "Германия",
        "cs": "Německo",
        "da": "Tyskland",
        "de": "Deutschland",
        "el": "Γερμανία",
        "en": "Germany",
        "es": "Alemania",
        "et": "Saksamaa",
        "fi": "Saksa",
        "fr": "Allemagne",
        "ga": "An Ghearmáin",
        "hr": "Njemačka",
        "hu": "Németország",
        "it": "Germania",
        "lt": "Vokietija",
        "lv": "Vācija",
        "mt": "Il-Ġermanja",
        "nl": "Duitsland",
        "pl": "Niemcy",
        "pt": "Alemanha",
        "ro": "Germania",
        "sk": "Nemecko",
        "sl": "Nemčija",
        "sv": "Tyskland"
    ],

    "DK": [
        "bg": "Дания",
        "cs": "Dánsko",
        "da": "Danmark",
        "de": "Dänemark",
        "el": "Δανία",
        "en": "Denmark",
        "es": "Dinamarca",
        "et": "Taani",
        "fi": "Tanska",
        "fr": "Danemark",
        "ga": "An Danmhairg",
        "hr": "Danska",
        "hu": "Dánia",
        "it": "Danimarca",
        "lt": "Danija",
        "lv": "Dānija",
        "mt": "Id-Danimarka",
        "nl": "Denemarken",
        "pl": "Dania",
        "pt": "Dinamarca",
        "ro": "Danemarca",
        "sk": "Dánsko",
        "sl": "Danska",
        "sv": "Danmark"
    ],

    "EE": [
        "bg": "Естония",
        "cs": "Estonsko",
        "da": "Estland",
        "de": "Estland",
        "el": "Εσθονία",
        "en": "Estonia",
        "es": "Estonia",
        "et": "Eesti",
        "fi": "Viro",
        "fr": "Estonie",
        "ga": "An Eastóin",
        "hr": "Estonija",
        "hu": "Észtország",
        "it": "Estonia",
        "lt": "Estija",
        "lv": "Igaunija",
        "mt": "L-Estonja",
        "nl": "Estland",
        "pl": "Estonia",
        "pt": "Estónia",
        "ro": "Estonia",
        "sk": "Estónsko",
        "sl": "Estonija",
        "sv": "Estland"
    ],

    "EL": [
        "bg": "Гърция",
        "cs": "Řecko",
        "da": "Grækenland",
        "de": "Griechenland",
        "el": "Ελλάδα",
        "en": "Greece",
        "es": "Grecia",
        "et": "Kreeka",
        "fi": "Kreikka",
        "fr": "Grèce",
        "ga": "An Ghréig",
        "hr": "Grčka",
        "hu": "Görögország",
        "it": "Grecia",
        "lt": "Graikija",
        "lv": "Grieķija",
        "mt": "Il-Greċja",
        "nl": "Griekenland",
        "pl": "Grecja",
        "pt": "Grécia",
        "ro": "Grecia",
        "sk": "Grécko",
        "sl": "Grčija",
        "sv": "Grekland"
    ],

    "ES": [
        "bg": "Испания",
        "cs": "Španělsko",
        "da": "Spanien",
        "de": "Spanien",
        "el": "Ισπανία",
        "en": "Spain",
        "es": "España",
        "et": "Hispaania",
        "fi": "Espanja",
        "fr": "Espagne",
        "ga": "An Spáinn",
        "hr": "Španjolska",
        "hu": "Spanyolország",
        "it": "Spagna",
        "lt": "Ispanija",
        "lv": "Spānija",
        "mt": "Spanja",
        "nl": "Spanje",
        "pl": "Hiszpania",
        "pt": "Espanha",
        "ro": "Spania",
        "sk": "Španielsko",
        "sl": "Španija",
        "sv": "Spanien"
    ],

    "FI": [
        "bg": "Финландия",
        "cs": "Finsko",
        "da": "Finland",
        "de": "Finnland",
        "el": "Φινλανδία",
        "en": "Finland",
        "es": "Finlandia",
        "et": "Soome",
        "fi": "Suomi",
        "fr": "Finlande",
        "ga": "An Fhionlainn",
        "hr": "Finska",
        "hu": "Finnország",
        "it": "Finlandia",
        "lt": "Suomija",
        "lv": "Somija",
        "mt": "Il-Finlandja",
        "nl": "Finland",
        "pl": "Finlandia",
        "pt": "Finlândia",
        "ro": "Finlanda",
        "sk": "Fínsko",
        "sl": "Finska",
        "sv": "Finland"
    ],

    "FR": [
        "bg": "Франция",
        "cs": "Francie",
        "da": "Frankrig",
        "de": "Frankreich",
        "el": "Γαλλία",
        "en": "France",
        "es": "Francia",
        "et": "Prantsusmaa",
        "fi": "Ranska",
        "fr": "France",
        "ga": "An Fhrainc",
        "hr": "Francuska",
        "hu": "Franciaország",
        "it": "Francia",
        "lt": "Prancūzija",
        "lv": "Francija",
        "mt": "Franza",
        "nl": "Frankrijk",
        "pl": "Francja",
        "pt": "França",
        "ro": "Franța",
        "sk": "Francúzsko",
        "sl": "Francija",
        "sv": "Frankrike"
    ],

    "GB": [
        "bg": "Обединено кралство",
        "cs": "Spojené království",
        "da": "Det Forenede Kongerige",
        "de": "Vereinigtes Königreich",
        "el": "Ηνωμένο Βασίλειο",
        "en": "United Kingdom",
        "es": "Reino Unido",
        "et": "Ühendkuningriik",
        "fi": "Yhdistynyt kuningaskunta",
        "fr": "Royaume-Uni",
        "ga": "An Ríocht Aontaithe",
        "hr": "Ujedinjena Kraljevina",
        "hu": "Egyesült Királyság",
        "it": "Regno Unito",
        "lt": "Jungtinė Karalystė",
        "lv": "Apvienotā Karaliste",
        "mt": "Ir-Renju Unit",
        "nl": "Verenigd Koninkrijk",
        "pl": "Zjednoczone Królestwo",
        "pt": "Reino Unido",
        "ro": "Regatul Unit",
        "sk": "Spojené kráľovstvo",
        "sl": "Združeno kraljestvo",
        "sv": "Storbritannien"
    ],

    "HR": [
        "bg": "Хърватия",
        "cs": "Chorvatsko",
        "da": "Kroatien",
        "de": "Kroatien",
        "el": "Κροατία",
        "en": "Croatia",
        "es": "Croacia",
        "et": "Horvaatia",
        "fi": "Kroatia",
        "fr": "Croatie",
        "ga": "An Chróit",
        "hr": "Hrvatska",
        "hu": "Horvátország",
        "it": "Croazia",
        "lt": "Kroatija",
        "lv": "Horvātija",
        "mt": "Il-Kroazja",
        "nl": "Kroatië",
        "pl": "Chorwacja",
        "pt": "Croácia",
        "ro": "Croația",
        "sk": "Chorvátsko",
        "sl": "Hrvaška",
        "sv": "Kroatien"
    ],

    "HU": [
        "bg": "Унгария",
        "cs": "Maďarsko",
        "da": "Ungarn",
        "de": "Ungarn",
        "el": "Ουγγαρία",
        "en": "Hungary",
        "es": "Hungría",
        "et": "Ungari",
        "fi": "Unkari",
        "fr": "Hongrie",
        "ga": "An Ungáir",
        "hr": "Mađarska",
        "hu": "Magyarország",
        "it": "Ungheria",
        "lt": "Vengrija",
        "lv": "Ungārija",
        "mt": "L-Ungerija",
        "nl": "Hongarije",
        "pl": "Węgry",
        "pt": "Hungria",
        "ro": "Ungaria",
        "sk": "Maďarsko",
        "sl": "Madžarska",
        "sv": "Ungern"
    ],

    "IE": [
        "bg": "Ирландия",
        "cs": "Irsko",
        "da": "Irland",
        "de": "Irland",
        "el": "Ιρλανδία",
        "en": "Ireland",
        "es": "Irlanda",
        "et": "Iirimaa",
        "fi": "Irlanti",
        "fr": "Irlande",
        "ga": "Éire",
        "hr": "Irska",
        "hu": "Írország",
        "it": "Irlanda",
        "lt": "Airija",
        "lv": "Īrija",
        "mt": "L-Irlanda",
        "nl": "Ierland",
        "pl": "Irlandia",
        "pt": "Irlanda",
        "ro": "Irlanda",
        "sk": "Írsko",
        "sl": "Irska",
        "sv": "Irland"
    ],

    "IT": [
        "bg": "Италия",
        "cs": "Itálie",
        "da": "Italien",
        "de": "Italien",
        "el": "Ιταλία",
        "en": "Italy",
        "es": "Italia",
        "et": "Itaalia",
        "fi": "Italia",
        "fr": "Italie",
        "ga": "An Iodáil",
        "hr": "Italija",
        "hu": "Olaszország",
        "it": "Italia",
        "lt": "Italija",
        "lv": "Itālija",
        "mt": "L-Italja",
        "nl": "Italië",
        "pl": "Włochy",
        "pt": "Itália",
        "ro": "Italia",
        "sk": "Taliansko",
        "sl": "Italija",
        "sv": "Italien"
    ],

    "LT": [
        "bg": "Литва",
        "cs": "Litva",
        "da": "Litauen",
        "de": "Litauen",
        "el": "Λιθουανία",
        "en": "Lithuania",
        "es": "Lituania",
        "et": "Leedu",
        "fi": "Liettua",
        "fr": "Lituanie",
        "ga": "An Liotuáin",
        "hr": "Litva",
        "hu": "Litvánia",
        "it": "Lituania",
        "lt": "Lietuva",
        "lv": "Lietuva",
        "mt": "Il-Litwanja",
        "nl": "Litouwen",
        "pl": "Litwa",
        "pt": "Lituânia",
        "ro": "Lituania",
        "sk": "Litva",
        "sl": "Litva",
        "sv": "Litauen"
    ],

    "LU": [
        "bg": "Люксембург",
        "cs": "Lucembursko",
        "da": "Luxembourg",
        "de": "Luxemburg",
        "el": "Λουξεμβούργο",
        "en": "Luxembourg",
        "es": "Luxemburgo",
        "et": "Luksemburg",
        "fi": "Luxemburg",
        "fr": "Luxembourg",
        "ga": "Lucsamburg",
        "hr": "Luksemburg",
        "hu": "Luxemburg",
        "it": "Lussemburgo",
        "lt": "Liuksemburgas",
        "lv": "Luksemburga",
        "mt": "Il-Lussemburgu",
        "nl": "Luxemburg",
        "pl": "Luksemburg",
        "pt": "Luxemburgo",
        "ro": "Luxemburg",
        "sk": "Luxembursko",
        "sl": "Luksemburg",
        "sv": "Luxemburg"
    ],

    "LV": [
        "bg": "Латвия",
        "cs": "Lotyšsko",
        "da": "Letland",
        "de": "Lettland",
        "el": "Λεττονία",
        "en": "Latvia",
        "es": "Letonia",
        "et": "Läti",
        "fi": "Latvia",
        "fr": "Lettonie",
        "ga": "An Laitvia",
        "hr": "Latvija",
        "hu": "Lettország",
        "it": "Lettonia",
        "lt": "Latvija",
        "lv": "Latvija",
        "mt": "Il-Latvja",
        "nl": "Letland",
        "pl": "Łotwa",
        "pt": "Letónia",
        "ro": "Letonia",
        "sk": "Lotyšsko",
        "sl": "Latvija",
        "sv": "Lettland"
    ],

    "MT": [
        "bg": "Малта",
        "cs": "Malta",
        "da": "Malta",
        "de": "Malta",
        "el": "Μάλτα",
        "en": "Malta",
        "es": "Malta",
        "et": "Malta",
        "fi": "Malta",
        "fr": "Malte",
        "ga": "Málta",
        "hr": "Malta",
        "hu": "Málta",
        "it": "Malta",
        "lt": "Malta",
        "lv": "Malta",
        "mt": "Malta",
        "nl": "Malta",
        "pl": "Malta",
        "pt": "Malta",
        "ro": "Malta",
        "sk": "Malta",
        "sl": "Malta",
        "sv": "Malta"
    ],

    "NL": [
        "bg": "Нидерландия",
        "cs": "Nizozemsko",
        "da": "Nederlandene",
        "de": "Niederlande",
        "el": "Κάτω Χώρες",
        "en": "Netherlands",
        "es": "Países Bajos",
        "et": "Madalmaad",
        "fi": "Alankomaat",
        "fr": "Pays-Bas",
        "ga": "An Ísiltír",
        "hr": "Nizozemska",
        "hu": "Hollandia",
        "it": "Paesi Bassi",
        "lt": "Nyderlandai",
        "lv": "Nīderlande",
        "mt": "Il-Pajjiżi l-Baxxi",
        "nl": "Nederland",
        "pl": "Holandia",
        "pt": "Países Baixos",
        "ro": "Țările de Jos",
        "sk": "Holandsko",
        "sl": "Nizozemska",
        "sv": "Nederländerna"
    ],

    "PL": [
        "bg": "Полша",
        "cs": "Polsko",
        "da": "Polen",
        "de": "Polen",
        "el": "Πολωνία",
        "en": "Poland",
        "es": "Polonia",
        "et": "Poola",
        "fi": "Puola",
        "fr": "Pologne",
        "ga": "An Pholainn",
        "hr": "Poljska",
        "hu": "Lengyelország",
        "it": "Polonia",
        "lt": "Lenkija",
        "lv": "Polija",
        "mt": "Il-Polonja",
        "nl": "Polen",
        "pl": "Polska",
        "pt": "Polónia",
        "ro": "Polonia",
        "sk": "Poľsko",
        "sl": "Poljska",
        "sv": "Polen"
    ],

    "PT": [
        "bg": "Португалия",
        "cs": "Portugalsko",
        "da": "Portugal",
        "de": "Portugal",
        "el": "Πορτογαλία",
        "en": "Portugal",
        "es": "Portugal",
        "et": "Portugal",
        "fi": "Portugali",
        "fr": "Portugal",
        "ga": "An Phortaingéil",
        "hr": "Portugal",
        "hu": "Portugália",
        "it": "Portogallo",
        "lt": "Portugalija",
        "lv": "Portugāle",
        "mt": "Il-Portugall",
        "nl": "Portugal",
        "pl": "Portugalia",
        "pt": "Portugal",
        "ro": "Portugalia",
        "sk": "Portugalsko",
        "sl": "Portugalska",
        "sv": "Portugal"
    ],

    "RO": [
        "bg": "Румъния",
        "cs": "Rumunsko",
        "da": "Rumænien",
        "de": "Rumänien",
        "el": "Ρουμανία",
        "en": "Romania",
        "es": "Rumanía",
        "et": "Rumeenia",
        "fi": "Romania",
        "fr": "Roumanie",
        "ga": "An Rómáin",
        "hr": "Rumunjska",
        "hu": "Románia",
        "it": "Romania",
        "lt": "Rumunija",
        "lv": "Rumānija",
        "mt": "Ir-Rumanija",
        "nl": "Roemenië",
        "pl": "Rumunia",
        "pt": "Roménia",
        "ro": "România",
        "sk": "Rumunsko",
        "sl": "Romunija",
        "sv": "Rumänien"
    ],

    "SE": [
        "bg": "Швеция",
        "cs": "Švédsko",
        "da": "Sverige",
        "de": "Schweden",
        "el": "Σουηδία",
        "en": "Sweden",
        "es": "Suecia",
        "et": "Rootsi",
        "fi": "Ruotsi",
        "fr": "Suède",
        "ga": "An tSualainn",
        "hr": "Švedska",
        "hu": "Svédország",
        "it": "Svezia",
        "lt": "Švedija",
        "lv": "Zviedrija",
        "mt": "L-Isvezja",
        "nl": "Zweden",
        "pl": "Szwecja",
        "pt": "Suécia",
        "ro": "Suedia",
        "sk": "Švédsko",
        "sl": "Švedska",
        "sv": "Sverige"
    ],

    "SK": [
        "bg": "Словакия",
        "cs": "Slovinsko",
        "da": "Slovakiet",
        "de": "Slowakei",
        "el": "Σλοβακία",
        "en": "Slovakia",
        "es": "Eslovaquia",
        "et": "Slovakkia",
        "fi": "Slovakia",
        "fr": "Slovaquie",
        "ga": "An tSlóvaic",
        "hr": "Slovačka",
        "hu": "Szlovákia",
        "it": "Slovacchia",
        "lt": "Slovakija",
        "lv": "Slovākija",
        "mt": "Is-Slovakkja",
        "nl": "Slowakije",
        "pl": "Słowacja",
        "pt": "Eslováquia",
        "ro": "Slovacia",
        "sk": "Slovensko",
        "sl": "Slovaška",
        "sv": "Slovakien"
    ],

    "SI": [
        "bg": "Словения",
        "cs": "Slovensko",
        "da": "Slovenien",
        "de": "Slovenia",
        "el": "Σλοβενία",
        "en": "Slovenia",
        "es": "Eslovenia",
        "et": "Sloveenia",
        "fi": "Slovenia",
        "fr": "Slovénie",
        "ga": "An tSlóivéin",
        "hr": "Slovenija",
        "hu": "Szlovénia",
        "it": "Slovenia",
        "lt": "Slovėnija",
        "lv": "Slovēnija",
        "mt": "Is-Slovenja",
        "nl": "Slovenië",
        "pl": "Słowenia",
        "pt": "Eslovénia",
        "ro": "Slovenia",
        "sk": "Slovinsko",
        "sl": "Slovenija",
        "sv": "Slovenien"
    ]
]

enum Malfunction: Error {
    case powerFailure
    case initialization
    case outOfOrder
}

func backwards(_ s1: String, _ s2: String) -> Bool {
    return s1 > s2
}

func sortCityNames() {
    let cityNames = ["Vienna", "Brussels", "Zagreb", "Nicosia", "Prague",
                     "Copenhagen", "Tallinn", "Helsinki", "Paris", "Berlin",
                     "Athens", "Budapest", "Dublin", "Rome", "Riga",
                     "Vilnius", "Luxembourg", "Valletta", "Amsterdam", "Warsaw",
                     "Lisbon", "Bucharest", "Bratislava", "Ljubljana", "Madrid",
                     "Stockholm", "London"]
    let sortedNames = cityNames.sorted()
    print(sortedNames)

    var rev = cityNames.sorted(by: backwards)
    print("Passing a function: \(rev)")

    //rev = cityNames.sorted(by: { s1, s2 in return s1 > s2 })
    //rev = cityNames.sorted(by: { s1, s2 in s1 > s2 })
    //rev = cityNames.sorted(by: { $0 > $1 } )
    rev = cityNames.sorted(by: >)
    print("With a closure: \(rev)")
}

func printOriginalTimeline(_ countries: [Country]) {
    var joinsByDate = Dictionary<String, [String]>()
    for country in countries {
        //print("\(country.joinedUnionDate) \(country.name!)")
        if joinsByDate[country.joinedUnionDate] != nil {
            joinsByDate[country.joinedUnionDate]!.append(country.name)
        }
        else {
            joinsByDate[country.joinedUnionDate] = [country.name]
        }
    }

    print("Timeline:")
    let joinDates = Array(joinsByDate.keys).sorted()
    for date in joinDates {
        let joinedCountries = joinsByDate[date]!.sorted()
        var countryPart = ""
        switch joinedCountries.count {
        case 0:
            countryPart = "***ERROR***"
        case 1:
            countryPart = joinedCountries[0]
        case 2:
            countryPart = joinedCountries.joined(separator: " and ")
        default:
            let lastIndex = joinedCountries.count - 1
            countryPart += joinedCountries[..<lastIndex].joined(separator: ", ")
            countryPart += " and " + joinedCountries.last!
        }

        print("\(date): \(countryPart) joined the EU")
    }

/*
    print("\nTotal number of countries: \(countries.count)")

    let totalPopulation = countries.map({$0.population}).reduce(0, +)
    print("Total population: \(totalPopulation)")

    print("Finland, pop = \(finland.population)")
*/
}

func greeting1(name: String? = nil) -> String {
    guard let whoToGreet = name else {
        return "Hello, stranger!"
    }
    return "Hello, \(whoToGreet)!"
}

func greeting2(name: String? = nil) -> String {
    var text = "Hello, stranger!"
    if let whoToGreet = name {
        text = "Hello, \(whoToGreet)!"
    }
    return text
}

func printCityNames() {
    var nameCount = 0
    let cities = [
        "amsterdam", "athens", "berlin", "bratislava", "brussels", "bucharest",
        "budapest",  "copenhagen", "dublin", "helsinki", "lisbon", "ljubljana",
        "london", "luxembourg", "madrid", "nicosia", "paris", "prague", "riga",
        "rome", "sofia", "stockholm", "tallinn", "valletta", "vienna", "vilnius",
        "warsaw", "zagreb"
    ]
    for city in cities {
        print("\(city): ")
        let names = cityNames[city]!
        //assert(names.count == officialLanguages.count)
        print("\(names.count) -- \(officialLanguages.count)")
        for lang in officialLanguages {
            let name = names[lang]!
            print(name)
            nameCount += 1
        }
    }

    print("Total city name count = \(nameCount)")
}

func printCountryNames() {
    var nameCount = 0
    let countries = [
        "AT", "BE", "BG", "CY", "CZ", "DE", "DK", "EE", "EL", "ES", "FI", "FR", "GB", "HR",
        "HU", "IE", "IT", "LT", "LU", "LV", "MT", "NL", "PL", "PT", "RO", "SE", "SK", "SI"
    ]
    for country in countries {
        print("\(country):")
        let names = countryNames[country]!
        print("\(names.count) -- \(officialLanguages.count)")
        for lang in officialLanguages {
            let name = names[lang]!
            print(name)
            nameCount += 1
        }
    }
    print("Total country name count = \(nameCount)")
}

func initData() -> [Country] {
   let finland = Country(
        code: "FI",
        name: "Finland",
        capital: City(
            name: "Helsinki",
            location: Coordinate(latitude: 60.1708, longitude: 24.9375)),
        area: 338_435,
        population: 5_503_297,
        joined: "1995-01-01")

    let sweden = Country(
        code: "SE",
        name: "Sweden",
        capital: City(
            name: "Stockholm",
            location: Coordinate(latitude: 59.3294, longitude: 18.0686)),
        area: 438_574,
        population: 9_644_864,
        joined: "1995-01-01")

    let belgium = Country(
        code: "BE",
        name: "Belgium",
        capital: City(
            name: "Brussels",
            location: Coordinate(latitude: 50.85, longitude: 4.35)),
        area: 30528,
        population: 11_203_992,
        joined: "1958-01-01")

    let austria = Country(
        code: "AT",
        name: "Austria",
        capital: City(
            name: "Vienna",
            location: Coordinate(latitude: 48.2089, longitude: 16.3725)),
        area: 83879,
        population: 8507786,
        joined: "1995-01-01")

    let czechRepublic = Country(
        code: "CZ",
        name: "Czech Republic",
        capital: City(
            name: "Prague",
            location: Coordinate(latitude: 50.0833, longitude: 14.4167)),
        area: 78867,
        population: 10512419,
        joined: "2004-05-01")

    let netherlands = Country(
        code: "NL",
        name: "Netherlands",
        capital: City(
            name: "Amsterdam",
            location: Coordinate(latitude: 52.3731, longitude: 4.8922)),
        area: 41540,
        population: 16829289,
        joined: "1958-01-01")

    let bulgaria = Country(
        code: "BG",
        name: "Bulgaria",
        capital: City(
            name: "Sofia",
            location: Coordinate(latitude: 42.7, longitude: 23.3333)),
        area: 111002,
        population: 7245677,
        joined: "2007-01-01")

    let greece = Country(
        code: "EL",
        name: "Greece",
        capital: City(
            name: "Athens",
            location: Coordinate(latitude: 37.9667, longitude: 23.7167)),
        area: 131957,
        population: 10992589,
        joined: "1981-01-01")

    let cyprus = Country(
        code: "CY",
        name: "Cyprus",
        capital: City(
            name: "Nicosia",
            location: Coordinate(latitude: 35.1667, longitude: 33.3667)),
        area: 9251,
        population: 858000,
        joined: "2004-05-01")

    let denmark = Country(
        code: "DK",
        name: "Denmark",
        capital: City(
            name: "Copenhagen",
            location: Coordinate(latitude: 55.6761, longitude: 12.5683)),
        area: 42921,
        population: 5627235,
        joined: "1973-01-01")

    let estonia = Country(
        code: "EE",
        name: "Estonia",
        capital: City(
            name: "Tallinn",
            location: Coordinate(latitude: 59.4372, longitude: 24.7453)),
        area: 45227,
        population: 1315819,
        joined: "2004-01-01")

    let france = Country(
        code: "FR",
        name: "France",
        capital: City(
            name: "Paris",
            location: Coordinate(latitude: 48.8567, longitude: 2.3508)),
        area: 632833,
        population: 65856609,
        joined: "1958-01-01")

    let germany = Country(
        code: "DE",
        name: "Germany",
        capital: City(
            name: "Berlin",
            location: Coordinate(latitude: 52.5167, longitude: 13.3833)),
        area: 357340,
        population: 80780000,
        joined: "1958-01-01")

    let hungary = Country(
        code: "HU",
        name: "Hungary",
        capital: City(
            name: "Budapest",
            location: Coordinate(latitude: 47.4719, longitude: 19.0503)),
        area: 93024,
        population: 9879000,
        joined: "2004-01-01")

    let ireland = Country(
        code: "IE",
        name: "Ireland",
        capital: City(
            name: "Dublin",
            location: Coordinate(latitude: 53.3478, longitude: -6.2597)),
        area: 69797,
        population: 4604029,
        joined: "1973-01-01")

    let latvia = Country(
        code: "LV",
        name: "Latvia",
        capital: City(
            name: "Riga",
            location: Coordinate(latitude: 56.9489, longitude: 24.1064)),
        area: 64573,
        population: 2001468,
        joined: "2004-05-01")

    let lithuania = Country(
        code: "LT",
        name: "Lithuania",
        capital: City(
            name: "Vilnius",
            location: Coordinate(latitude: 54.6833, longitude: 25.2833)),
        area: 65300,
        population: 2943472,
        joined: "2004-05-01")

    let luxembourg = Country(
        code: "LU",
        name: "Luxembourg",
        capital: City(
            name: "Luxembourg",
            location: Coordinate(latitude: 49.6117, longitude: 6.13)),
        area: 2586,
        population: 549680,
        joined: "2004-05-01")

    let malta = Country(
        code: "MT",
        name: "Malta",
        capital: City(
            name: "Valletta",
            location: Coordinate(latitude: 35.8978, longitude: 14.5125)),
        area: 316,
        population: 425384,
        joined: "2004-05-01")

    let poland = Country(
        code: "PL",
        name: "Poland",
        capital: City(
            name: "Warsaw",
            location: Coordinate(latitude: 52.2333, longitude: 21.0167)),
        area: 312679,
        population: 38495659,
        joined: "2004-05-01")

    let portugal = Country(
        code: "PT",
        name: "Portugal",
        capital: City(
            name: "Lisbon",
            location: Coordinate(latitude: 38.7136, longitude: -9.1392)),
        area: 92225,
        population: 10427301,
        joined: "1986-01-01")

    let romania = Country(
        code: "RO",
        name: "Romania",
        capital: City(
            name: "Bucharest",
            location: Coordinate(latitude: 44.4325, longitude: 26.1039)),
        area: 238391,
        population: 19942642,
        joined: "2007-01-01")

    let slovakia = Country(
        code: "SK",
        name: "Slovakia",
        capital: City(
            name: "Bratislava",
            location: Coordinate(latitude: 48.1439, longitude: 17.1097)),
        area: 49035,
        population: 5415949,
        joined: "2004-05-01")

    let slovenia = Country(
        code: "SI",
        name: "Slovenia",
        capital: City(
            name: "Ljubljana",
            location: Coordinate(latitude: 46.0556, longitude: 14.5083)),
        area: 20273,
        population: 2061085,
        joined: "2004-05-01")

    let unitedKingdom = Country(
        code: "GB",
        name: "United Kingdom",
        capital: City(
            name: "London",
            location: Coordinate(latitude: 51.5072, longitude: -0.1275)),
        area: 248528,
        population: 64308261,
        joined: "1973-01-01",
        exited: "2020-01-31")

    let croatia = Country(
        code: "HR",
        name: "Croatia",
        capital: City(
            name: "Zagreb",
            location: Coordinate(latitude: 45.8167, longitude: 15.9833)),
        area: 56594,
        population: 4246700,
        joined: "2013-07-01")

    let italy = Country(
        code: "IT",
        name: "Italy",
        capital: City(
            name: "Rome",
            location: Coordinate(latitude: 41.9, longitude: 12.5)),
        area: 302073,
        population: 60782668,
        joined: "1958-01-01")

    let spain = Country(
        code: "ES",
        name: "Spain",
        capital: City(
            name: "Madrid",
            location: Coordinate(latitude: 40.3833, longitude: -3.7167)),
        area: 505970,
        population: 46507760,
        joined: "1986-01-01")

    let countries = [finland, sweden, czechRepublic, belgium, austria,
            netherlands, bulgaria, greece, cyprus, denmark,
            estonia, france, germany, hungary, ireland,
            latvia, lithuania, luxembourg, malta, poland,
            portugal, romania, slovakia, slovenia, unitedKingdom,
            croatia, italy, spain]

    let eurozoneJoins: [String: [Country]] = [
        "1999-01-01": [austria, belgium, finland, france, germany, ireland, italy, luxembourg, netherlands, portugal, spain],
        "2001-01-01": [greece],
        "2007-01-01": [slovenia],
        "2008-01-01": [cyprus, malta],
        "2009-01-01": [slovakia],
        "2011-01-01": [estonia],
        "2014-01-01": [latvia],
        "2015-01-01": [lithuania]
    ]

    for euroDate in eurozoneJoins.keys {
        let countries = eurozoneJoins[euroDate]!
        for country in countries {
            country.joinedEurozoneDate = euroDate
        }
    }

    let schengenJoins: [String: [Country]] = [
        "1995-03-26": [belgium, france, germany, luxembourg, netherlands, portugal, spain],
        "1997-10-26": [italy],
        "2000-01-01": [greece],
        "2001-03-25": [denmark, finland, sweden],
        "2007-12-01": [austria, czechRepublic, estonia, hungary, latvia, lithuania, malta, poland, slovakia, slovenia]
    ]

    for schengenDate in schengenJoins.keys {
        let countries = schengenJoins[schengenDate]!
        for country in countries {
            country.joinedSchengenDate = schengenDate
        }
    }

    return countries
}

func getAllEvents(_ countries: [Country]) -> [Event] {
    var events = [Event]()

    for country in countries {
        events.append(Event(country: country, eventType: .joinedUnion, date: country.joinedUnionDate))
        if let date = country.joinedEurozoneDate {
            events.append(Event(country: country, eventType: .joinedEurozone, date: date))
        }
        if let date = country.joinedSchengenDate {
            events.append(Event(country: country, eventType: .joinedSchengen, date: date))
        }
        if let date = country.exitedUnionDate {
            events.append(Event(country: country, eventType: .exitedUnion, date: date))
        }
    }

    return events.sorted { $0.date < $1.date }
}

func printAllEvents(_ events: [Event]) {
    for event in events {
        print(event)
    }
}

func printTimeline(events: [Event]) {
    print("Timeline:")
    let eventsByDate = Dictionary(grouping: events, by: { $0.date })
    //print(eventsByDate)

    for date in eventsByDate.keys.sorted() {
        var line = "\(date): "
        let eventList = eventsByDate[date]!
        let eventsByType = Dictionary(grouping: eventList, by: { $0.eventType })
        for eventType in eventsByType.keys {
            let events = eventsByType[eventType]!
            var names = events.map { $0.country.name }.sorted()
            if names.count >= 2 {
                let lastName = names.removeLast()
                line += names.joined(separator: ", ")
                line += " and \(lastName)"
            }
            else {
                line += names.joined(separator: ", ")
            }
            var eventDescription = ""
            switch eventType {
            case .joinedUnion:
                eventDescription = "joined the EU"
            case .joinedSchengen:
                eventDescription = "joined the Schengen agreement"
            case .joinedEurozone:
                eventDescription = "joined the Eurozone"
            case .exitedUnion:
                eventDescription = "exited the EU"
            }
            line += " \(eventDescription). "
        }
        print(line)
    }
}

func main() {
    let countries = initData()
    //printOriginalTimeline(countries)

/*
    print(greeting1())
    print(greeting1(name: "world"))

    print(greeting2())
    print(greeting2(name: "world"))

    //sortCityNames()
*/

    //printCityNames()
    //printCountryNames()
    let events = getAllEvents(countries)
    //printAllEvents(events)
    printTimeline(events: events)
}

main()
exit(EXIT_SUCCESS)
