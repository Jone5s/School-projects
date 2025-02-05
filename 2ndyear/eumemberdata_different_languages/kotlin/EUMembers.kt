data class Coordinate(val latitude: Double, val longitude: Double)

class City constructor(name: String, location: Coordinate) { }

interface Member {
    val joinedUnionDate: String   // abstract property
    var joinedSchengenDate: String? 
    var joinedEurozoneDate: String?
    var exitedUnionDate: String? 
    fun isFounder(): Boolean
}

class Country(val code: String, val name: String, val capital: City?, val area: Long = 0L, val population: Long = 0L, joined: String): Member {
    override val joinedUnionDate: String
    override var joinedSchengenDate: String? = null
    override var joinedEurozoneDate: String? = null
    override var exitedUnionDate: String? = null

    override fun isFounder(): Boolean {
        return joinedUnionDate == "1958-01-01"
    }

    init {
        joinedUnionDate = joined
    }

    val populationDensity get() = if (area != 0L && population != 0L) population / area else 0L

    override fun toString(): String {
        return this.name
    }
}

enum class EventType {
    JOINED_UNION,
    JOINED_EUROZONE,
    JOINED_SCHENGEN,
    EXITED_UNION
}

class Event(val country: Country, val eventType: EventType, val date: String) {
    override fun toString(): String {
        return "${country.name} $eventType $date" 
    }
}

val officialLanguages = listOf(
    "bg", "cs", "da", "de", "el", "en", "es", "et", "fi", "fr", "ga", "hr", "hu", 
    "it", "lt", "lv", "mt", "nl", "pl", "pt", "ro", "sk", "sl", "sv"
)

val cityNames = mapOf(
    "amsterdam" to mapOf(
        "bg" to "Амстердам",
        "cs" to "Amsterdam",
        "da" to "Amsterdam",
        "de" to "Amsterdam",
        "el" to "Άμστερνταμ",
        "en" to "Amsterdam",
        "es" to "Ámsterdam",
        "et" to "Amsterdam",
        "fi" to "Amsterdam",
        "fr" to "Amsterdam",
        "ga" to "Amstardam",
        "hr" to "Amsterdam",
        "hu" to "Amszterdam",
        "it" to "Amsterdam",
        "lt" to "Amsterdamas",
        "lv" to "Amsterdama",
        "mt" to "Amsterdam",
        "nl" to "Amsterdam",
        "pl" to "Amsterdam",
        "pt" to "Amesterdão",
        "ro" to "Amsterdam",
        "sk" to "Amsterdam",
        "sl" to "Amsterdam",
        "sv" to "Amsterdam"
    ),

    "athens" to mapOf(
        "bg" to "Атина",
        "cs" to "Atény",
        "da" to "Athen",
        "de" to "Athen",
        "el" to "Αθήνα",
        "en" to "Athens",
        "es" to "Atenas",
        "et" to "Ateena",
        "fi" to "Ateena",
        "fr" to "Athènes",
        "ga" to "An Aithin",
        "hr" to "Atena",
        "hu" to "Athén",
        "it" to "Atene",
        "lt" to "Atėnai",
        "lv" to "Atēnas",
        "mt" to "Ateni",
        "nl" to "Athene",
        "pl" to "Ateny",
        "pt" to "Atenas",
        "ro" to "Atena",
        "sk" to "Atény",
        "sl" to "Atene",
        "sv" to "Aten"
    ),

    "berlin" to mapOf(
        "bg" to "Берлин",
        "cs" to "Berlin",
        "da" to "Berlin",
        "de" to "Berlin",
        "el" to "Βερολίνο",
        "en" to "Berlin",
        "es" to "Berlín",
        "et" to "Berliin",
        "fi" to "Berliini",
        "fr" to "Berlin",
        "ga" to "Beirlín",
        "hr" to "Berlin",
        "hu" to "Berlin",
        "it" to "Berlino",
        "lt" to "Berlynas",
        "lv" to "Berlīne",
        "mt" to "Berlin",
        "nl" to "Berlijn",
        "pl" to "Berlin",
        "pt" to "Berlim",
        "ro" to "Berlin",
        "sk" to "Berlín",
        "sl" to "Berlin",
        "sv" to "Berlin"
    ),

    "bratislava" to mapOf(
        "bg" to "Братислава",
        "cs" to "Bratislava",
        "da" to "Bratislava",
        "de" to "Bratislava",
        "el" to "Μπρατισλάβα",
        "en" to "Bratislava",
        "es" to "Bratislava",
        "et" to "Bratislava",
        "fi" to "Bratislava",
        "fr" to "Bratislava",
        "ga" to "an Bhratasláiv",
        "hr" to "Bratislava",
        "hu" to "Pozsony",
        "it" to "Bratislava",
        "lt" to "Bratislava",
        "lv" to "Bratislava",
        "mt" to "Bratislava",
        "nl" to "Bratislava",
        "pl" to "Bratysława",
        "pt" to "Bratislava",
        "ro" to "Bratislava",
        "sk" to "Bratislava",
        "sl" to "Bratislava",
        "sv" to "Bratislava"
    ),

    "brussels" to mapOf(
        "bg" to "Брюксел",
        "cs" to "Brusel",
        "da" to "Bruxelles",
        "de" to "Brüssel",
        "el" to "Βρυξέλλες",
        "en" to "Brussels",
        "es" to "Bruselas",
        "et" to "Brüssel",
        "fi" to "Brysseli",
        "fr" to "Bruxelles",
        "ga" to "an Bhruiséil",
        "hr" to "Bruxelles",
        "hu" to "Brüsszel",
        "it" to "Bruxelles",
        "lt" to "Briuselis",
        "lv" to "Brisele",
        "mt" to "Brussell",
        "nl" to "Brussel",
        "pl" to "Bruksela",
        "pt" to "Bruxelas",
        "ro" to "Bruxelles",
        "sk" to "Brusel",
        "sl" to "Bruselj",
        "sv" to "Bryssel"
    ),

    "bucharest" to mapOf(
        "bg" to "Букурещ",
        "cs" to "Bukurešť",
        "da" to "Bukarest",
        "de" to "Bukarest",
        "el" to "Βουκουρέστι",
        "en" to "Bucharest",
        "es" to "Bucarest",
        "et" to "Bukarest",
        "fi" to "Bukarest",
        "fr" to "Bucarest",
        "ga" to "Búcairist",
        "hr" to "Bukurešt",
        "hu" to "Bukarest",
        "it" to "Bucharest",
        "lt" to "Bukareštas",
        "lv" to "Bukareste",
        "mt" to "Bukarest",
        "nl" to "Boekarest",
        "pl" to "Bukareszt",
        "pt" to "Bucareste",
        "ro" to "București",
        "sk" to "Bukurešť",
        "sl" to "Bukarešta",
        "sv" to "Bukarest"
    ),

    "budapest" to mapOf(
        "bg" to "Будапеща",
        "cs" to "Budapešť",
        "da" to "Budapest",
        "de" to "Budapest",
        "el" to "Βουδαπέστη",
        "en" to "Budapest",
        "es" to "Budapest",
        "et" to "Budapest",
        "fi" to "Budapest",
        "fr" to "Budapest",
        "ga" to "Búdaipeist",
        "hr" to "Budimpešta",
        "hu" to "Budapest",
        "it" to "Budapest",
        "lt" to "Budapeštas",
        "lv" to "Budapešta",
        "mt" to "Budapest",
        "nl" to "Boedapest",
        "pl" to "Budapeszt",
        "pt" to "Budapeste",
        "ro" to "Budapesta",
        "sk" to "Budapešť",
        "sl" to "Budimpešta",
        "sv" to "Budapest"
    ),
    
    "copenhagen" to mapOf(
        "bg" to "Копенхаген",
        "cs" to "Kodaň",
        "da" to "København",
        "de" to "Kopenhagen",
        "el" to "Κοπεγχάγη",
        "en" to "Copenhagen",
        "es" to "Copenhague",
        "et" to "Kopenhaagen",
        "fi" to "Kööpenhamina",
        "fr" to "Copenhague",
        "ga" to "Cóbanhávan",
        "hr" to "Kopenhagen",
        "hu" to "Koppenhága",
        "it" to "Copenaghen",
        "lt" to "Kopenhaga",
        "lv" to "Kopenhāgena",
        "mt" to "Kopenħagen",
        "nl" to "Kopenhagen",
        "pl" to "Kopenhaga",
        "pt" to "Copenhaga",
        "ro" to "Copenhaga",
        "sk" to "Kodaň",
        "sl" to "København",
        "sv" to "Köpenhamn"
    ),

    "dublin" to mapOf(
        "bg" to "Дъблин",
        "cs" to "Dublin",
        "da" to "Dublin",
        "de" to "Dublin",
        "el" to "Δουβλίνο",
        "en" to "Dublin",
        "es" to "Dublín",
        "et" to "Dublin",
        "fi" to "Dublin",
        "fr" to "Dublin",
        "ga" to "Baile Átha Cliath",
        "hr" to "Dublin",
        "hu" to "Dublin",
        "it" to "Dublino",
        "lt" to "Dublinas",
        "lv" to "Dublina",
        "mt" to "Dublin",
        "nl" to "Dublin",
        "pl" to "Dublin",
        "pt" to "Dublin",
        "ro" to "Dublin",
        "sk" to "Dublin",
        "sl" to "Dublin",
        "sv" to "Dublin"
    ),

    "helsinki" to mapOf(
        "bg" to "Хелзинки",
        "cs" to "Helsinky",
        "da" to "Helsinki",
        "de" to "Helsinki",
        "el" to "Ελσίνκι",
        "en" to "Helsinki",
        "es" to "Helsinki",
        "et" to "Helsingi",
        "fi" to "Helsinki",
        "fr" to "Helsinki",
        "ga" to "Heilsincí",
        "hr" to "Helsinki",
        "hu" to "Helsinki",
        "it" to "Helsinki",
        "lt" to "Helsinkis",
        "lv" to "Helsinki",
        "mt" to "Ħelsinki",
        "nl" to "Helsinki",
        "pl" to "Helsinki",
        "pt" to "Helsínquia",
        "ro" to "Helsinki",
        "sk" to "Helsinki",
        "sl" to "Helsinki",
        "sv" to "Helsingfors"
    ),

    "lisbon" to mapOf(
        "bg" to "Лисабон",
        "cs" to "Lisabon",
        "da" to "Lissabon",
        "de" to "Lissabon",
        "el" to "Λισαβόνα",
        "en" to "Lisbon",
        "es" to "Lisboa",
        "et" to "Lissabon",
        "fi" to "Lissabon",
        "fr" to "Lisbonne",
        "ga" to "Liospóin",
        "hr" to "Lisabon",
        "hu" to "Lisszabon",
        "it" to "Lisbona",
        "lt" to "Lisabona",
        "lv" to "Lisabona",
        "mt" to "Lisbona",
        "nl" to "Lissabon",
        "pl" to "Lizbona",
        "pt" to "Lisboa",
        "ro" to "Lisabona",
        "sk" to "Lisabon",
        "sl" to "Lizbona",
        "sv" to "Lissabon"
    ),

    "ljubljana" to mapOf(
        "bg" to "Любляна",
        "cs" to "Lublaň",
        "da" to "Ljubljana",
        "de" to "Ljubljana",
        "el" to "Λιουμπλιάνα",
        "en" to "Ljubljana",
        "es" to "Liubliana",
        "et" to "Ljubljana",
        "fi" to "Ljubljana",
        "fr" to "Ljubljana",
        "ga" to "Liúibleána",
        "hr" to "Ljubljana",
        "hu" to "Ljubljana",
        "it" to "Lubiana",
        "lt" to "Liubliana",
        "lv" to "Ļubļana",
        "mt" to "Ljubljana",
        "nl" to "Ljubljana",
        "pl" to "Lublana",
        "pt" to "Liubliana",
        "ro" to "Ljubljana",
        "sk" to "Ljubljana",
        "sl" to "Ljubljana",
        "sv" to "Ľubľana"
    ),

    "london" to mapOf(
        "bg" to "Лондон",
        "cs" to "Londýn",
        "da" to "London",
        "de" to "London",
        "el" to "Λονδίνο",
        "en" to "London",
        "es" to "Londres",
        "et" to "London",
        "fi" to "Lontoo",
        "fr" to "Londres",
        "ga" to "Londain",
        "hr" to "London",
        "hu" to "London",
        "it" to "Londra",
        "lt" to "Londonas",
        "lv" to "Londona",
        "mt" to "Londra",
        "nl" to "Londen",
        "pl" to "Londyn",
        "pt" to "Londres",
        "ro" to "Londra",
        "sk" to "Londýn",
        "sl" to "London",
        "sv" to "London"
    ),

    "luxembourg" to mapOf(
        "bg" to "Люксембург",
        "cs" to "Lucemburk",
        "da" to "Luxembourg",
        "de" to "Luxemburg",
        "el" to "Λουξεμβούργο",
        "en" to "Luxembourg",
        "es" to "Luxemburgo",
        "et" to "Luxembourg",
        "fi" to "Luxemburg",
        "fr" to "Luxembourg",
        "ga" to "Lucsamburg",
        "hr" to "Luxembourg",
        "hu" to "Luxembourg",
        "it" to "Lussemburgo",
        "lt" to "Liuksemburgas",
        "lv" to "Luksemburga",
        "mt" to "Il-Lussemburgu",
        "nl" to "Luxemburg",
        "pl" to "Luksemburg",
        "pt" to "Luxemburgo",
        "ro" to "Luxemburg",
        "sk" to "Luxemburg",
        "sl" to "Luxembourg",
        "sv" to "Luxemburg"
    ),

    "madrid" to mapOf(
        "bg" to "Мадрид",
        "cs" to "Madrid",
        "da" to "Madrid",
        "de" to "Madrid",
        "el" to "Μαδρίτη",
        "en" to "Madrid",
        "es" to "Madrid",
        "et" to "Madrid",
        "fi" to "Madrid",
        "fr" to "Madrid",
        "ga" to "Maidrid",
        "hr" to "Madrid",
        "hu" to "Madrid",
        "it" to "Madrid",
        "lt" to "Madridas",
        "lv" to "Madride",
        "mt" to "Madrid",
        "nl" to "Madrid",
        "pl" to "Madryt",
        "pt" to "Madrid",
        "ro" to "Madrid",
        "sk" to "Madrid",
        "sl" to "Madrid",
        "sv" to "Madrid"
    ),

    "nicosia" to mapOf(
        "bg" to "Никозия",
        "cs" to "Nikósie",
        "da" to "Nicosia",
        "de" to "Nikosia",
        "el" to "Λευκωσία",
        "en" to "Nicosia",
        "es" to "Nicosia",
        "et" to "Nikosia",
        "fi" to "Nikosia",
        "fr" to "Nicosie",
        "ga" to "an Niocóis",
        "hr" to "Nikozija",
        "hu" to "Nicosia",
        "it" to "Nicosia",
        "lt" to "Nikosija",
        "lv" to "Nikozija",
        "mt" to "Nikosija",
        "nl" to "Nicosia",
        "pl" to "Nikozja",
        "pt" to "Nicósia",
        "ro" to "Nicosia",
        "sk" to "Nikózia",
        "sl" to "Nikozija",
        "sv" to "Nicosia"
    ),

    "paris" to mapOf(
        "bg" to "Париж",
        "cs" to "Paříž",
        "da" to "Paris",
        "de" to "Paris",
        "el" to "Παρίσι",
        "en" to "Paris",
        "es" to "París",
        "et" to "Pariis",
        "fi" to "Pariisi",
        "fr" to "Paris",
        "ga" to "Páras",
        "hr" to "Pariz",
        "hu" to "Párizs",
        "it" to "Parigi",
        "lt" to "Paryžius",
        "lv" to "Parīze",
        "mt" to "Pariġi",
        "nl" to "Parijs",
        "pl" to "Paryż",
        "pt" to "Paris",
        "ro" to "Paris",
        "sk" to "Paríž",
        "sl" to "Pariz",
        "sv" to "Paris"
    ),
    
    "prague" to mapOf(
        "bg" to "Прага",
        "cs" to "Praha",
        "da" to "Prag",
        "de" to "Prag",
        "el" to "Πράγα",
        "en" to "Prague",
        "es" to "Praga",
        "et" to "Praha",
        "fi" to "Praha",
        "fr" to "Prague",
        "ga" to "Prág",
        "hr" to "Prag",
        "hu" to "Prága",
        "it" to "Praga",
        "lt" to "Praha",
        "lv" to "Prāga",
        "mt" to "Praga",
        "nl" to "Praag",
        "pl" to "Praga",
        "pt" to "Praga",
        "ro" to "Praga",
        "sk" to "Praha",
        "sl" to "Praga",
        "sv" to "Prag"
    ),

    "riga" to mapOf(
        "bg" to "Рига",
        "cs" to "Riga",
        "da" to "Riga",
        "de" to "Riga",
        "el" to "Ρίγα",
        "en" to "Riga",
        "es" to "Riga",
        "et" to "Riia",
        "fi" to "Riika",
        "fr" to "Riga",
        "ga" to "Ríge",
        "hr" to "Riga",
        "hu" to "Riga",
        "it" to "Riga",
        "lt" to "Ryga",
        "lv" to "Rīga",
        "mt" to "Riga",
        "nl" to "Riga",
        "pl" to "Ryga",
        "pt" to "Riga",
        "ro" to "Riga",
        "sk" to "Riga",
        "sl" to "Riga",
        "sv" to "Riga"
    ),

    "rome" to mapOf(
        "bg" to "Рим",
        "cs" to "Řím",
        "da" to "Rom",
        "de" to "Rom",
        "el" to "Ρώμη",
        "en" to "Rome",
        "es" to "Roma",
        "et" to "Rooma",
        "fi" to "Rooma",
        "fr" to "Rome",
        "ga" to "an Róimh",
        "hr" to "Rim",
        "hu" to "Róma",
        "it" to "Roma",
        "lt" to "Roma",
        "lv" to "Roma",
        "mt" to "Ruma",
        "nl" to "Rome",
        "pl" to "Rzym",
        "pt" to "Roma",
        "ro" to "Roma",
        "sk" to "Rím",
        "sl" to "Rim",
        "sv" to "Rom"
    ),

    "sofia" to mapOf(
        "bg" to "София",
        "cs" to "Sofie",
        "da" to "Sofia",
        "de" to "Sofia",
        "el" to "Σόφια",
        "en" to "Sofia",
        "es" to "Sofía",
        "et" to "Sofia",
        "fi" to "Sofia",
        "fr" to "Sofia",
        "ga" to "Sóifia",
        "hr" to "Sofija",
        "hu" to "Szófia",
        "it" to "Sofia",
        "lt" to "Sofija",
        "lv" to "Sofija",
        "mt" to "Sofia",
        "nl" to "Sofia",
        "pl" to "Sofia",
        "pt" to "Sófia",
        "ro" to "Sofia",
        "sk" to "Sofia",
        "sl" to "Sofija",
        "sv" to "Sofia"
    ),

    "stockholm" to mapOf(
        "bg" to "Стокхолм",
        "cs" to "Stockholm",
        "da" to "Stockholm",
        "de" to "Stockholm",
        "el" to "Στοκχόλμη",
        "en" to "Stockholm",
        "es" to "Estocolmo",
        "et" to "Stockholm",
        "fi" to "Tukholma",
        "fr" to "Stockholm",
        "ga" to "Stócólm",
        "hr" to "Stockholm",
        "hu" to "Stockholm",
        "it" to "Stoccolma",
        "lt" to "Stokholmas",
        "lv" to "Stokholma",
        "mt" to "Stokkolma",
        "nl" to "Stockholm",
        "pl" to "Sztokholm",
        "pt" to "Estocolmo",
        "ro" to "Stockholm",
        "sk" to "Štokholm",
        "sl" to "Stockholm",
        "sv" to "Stockholm"
    ),

    "tallinn" to mapOf(
        "bg" to "Талин",
        "cs" to "Tallinn",
        "da" to "Tallinn",
        "de" to "Tallinn",
        "el" to "Ταλίν",
        "en" to "Tallinn",
        "es" to "Tallin",
        "et" to "Tallinn",
        "fr" to "Tallinn",
        "fi" to "Tallinna",
        "ga" to "Taillinn",
        "hr" to "Tallinn",
        "hu" to "Tallinn",
        "it" to "Tallinn",
        "lt" to "Talinas",
        "lv" to "Tallina",
        "mt" to "Talinn",
        "nl" to "Tallinn",
        "pl" to "Tallin",
        "pt" to "Taline",
        "ro" to "Tallinn",
        "sk" to "Tallinn",
        "sl" to "Talin",
        "sv" to "Tallinn"
    ),

    "valletta" to mapOf(
        "bg" to "Валета",
        "cs" to "Valetta",
        "da" to "Valletta",
        "de" to "Valletta",
        "el" to "Βαλέτα",
        "en" to "Valletta",
        "es" to "La Valeta",
        "et" to "Valletta",
        "fi" to "Valletta",
        "fr" to "La Valette",
        "ga" to "Vaileite",
        "hr" to "Valletta",
        "hu" to "Valletta",
        "it" to "La Valletta",
        "lt" to "Valeta",
        "lv" to "Valeta",
        "mt" to "Valletta",
        "nl" to "Valletta",
        "pl" to "Valletta",
        "pt" to "Valeta",
        "ro" to "Valletta",
        "sk" to "Valletta",
        "sl" to "Valletta",
        "sv" to "Valletta"
    ),

    "vienna" to mapOf(
        "bg" to "Виена",
        "cs" to "Vídeň",
        "da" to "Wien",
        "de" to "Wien",
        "el" to "Βιέννη",
        "en" to "Vienna",
        "es" to "Viena",
        "et" to "Viin",
        "fi" to "Wien",
        "fr" to "Vienne",
        "ga" to "Vín",
        "hr" to "Beč",
        "hu" to "Bécs",
        "it" to "Vienna",
        "lt" to "Viena",
        "lv" to "Vīne",
        "mt" to "Vjenna",
        "nl" to "Wenen",
        "pl" to "Wiedeń",
        "pt" to "Viena",
        "ro" to "Viena",
        "sk" to "Viedeň",
        "sl" to "Dunaj",
        "sv" to "Wien"
    ),

    "vilnius" to mapOf(
        "bg" to "Вилнюс",
        "cs" to "Vilnius",
        "da" to "Vilnius",
        "de" to "Wilna (Vilnius)",
        "el" to "Βίλνιους",
        "en" to "Vilnius",
        "es" to "Vilna",
        "et" to "Vilnius",
        "fi" to "Vilna",
        "fr" to "Vilnius",
        "ga" to "Vilnias",
        "hr" to "Vilnius",
        "hu" to "Vilnius",
        "it" to "Vilnius",
        "lt" to "Vilnius",
        "lv" to "Viļņa",
        "mt" to "Vilnjus",
        "nl" to "Vilnius",
        "pl" to "Wilno",
        "pt" to "Vilnius",
        "ro" to "Vilnius",
        "sk" to "Vilnius",
        "sl" to "Vilna",
        "sv" to "Vilnius"
    ),
    
    "warsaw" to mapOf(
        "bg" to "Варшава",
        "cs" to "Varšava",
        "da" to "Warszawa",
        "de" to "Warschau",
        "el" to "Βαρσοβία",
        "en" to "Warsaw",
        "es" to "Varsovia",
        "et" to "Varssavi",
        "fi" to "Varsova",
        "fr" to "Varsovie",
        "ga" to "Vársá",
        "hr" to "Varšava",
        "hu" to "Varsó",
        "it" to "Varsavia",
        "lt" to "Varšuva",
        "lv" to "Varšava",
        "mt" to "Varsavja",
        "nl" to "Warschau",
        "pl" to "Warszawa",
        "pt" to "Varsóvia",
        "ro" to "Varșovia",
        "sk" to "Varšava",
        "sl" to "Varšava",
        "sv" to "Warszawa"
    ),

    "zagreb" to mapOf(
        "bg" to "Загреб",
        "cs" to "Záhřeb",
        "da" to "Zagreb",
        "de" to "Zagreb",
        "el" to "Ζάγκρεμπ",
        "en" to "Zagreb",
        "es" to "Zagreb",
        "et" to "Zagreb",
        "fi" to "Zagreb",
        "fr" to "Zagreb",
        "ga" to "Ságrab",
        "hr" to "Zagreb",
        "hu" to "Zágráb",
        "it" to "Zagabria",
        "lt" to "Zagrebas",
        "lv" to "Zagreba",
        "mt" to "Żagreb",
        "nl" to "Zagreb",
        "pl" to "Zagrzeb",
        "pt" to "Zagrebe",
        "ro" to "Zagreb",
        "sk" to "Záhreb",
        "sl" to "Zagreb",
        "sv" to "Zagreb"
    )
)

fun printCityNames() {
    var nameCount = 0
    val cities = listOf(
        "amsterdam", "athens", "berlin", "bratislava", "brussels", "bucharest", 
        "budapest",  "copenhagen", "dublin", "helsinki", "lisbon", "ljubljana", 
        "london", "luxembourg", "madrid", "nicosia", "paris", "prague", "riga", 
        "rome", "sofia", "stockholm", "tallinn", "valletta", "vienna", "vilnius", 
        "warsaw", "zagreb"
    )
    for (city in cities) {
        println("$city: ")
        val names = cityNames[city]!!
        println("${names.count()} -- ${officialLanguages.count()}")
        for (lang in officialLanguages) {
            val name = names[lang]!!
            println(name)
            nameCount += 1
        }
    }

    println("Total city name count = $nameCount")
}

val countryNames = mapOf(
    "AT" to mapOf(
        "bg" to "Австрия",
        "cs" to "Rakousko",
        "da" to "Østrig",
        "de" to "Österreich",
        "el" to "Αυστρία",
        "en" to "Austria",
        "es" to "Austria",
        "et" to "Austria",
        "fi" to "Itävalta",
        "fr" to "Autriche",
        "ga" to "An Ostair",
        "hr" to "Austrija",
        "hu" to "Ausztria",
        "it" to "Austria",
        "lt" to "Austrija",
        "lv" to "Austrija",
        "mt" to "L-Awstrija",
        "nl" to "Oostenrijk",
        "pl" to "Austria",
        "pt" to "Áustria",
        "ro" to "Austria",
        "sk" to "Rakúsko",
        "sl" to "Avstrija",
        "sv" to "Österrike"
    ),
    
    "BE" to mapOf(
        "bg" to "Белгия",
        "cs" to "Belgie",
        "da" to "Belgien",
        "de" to "Belgien",
        "el" to "Βέλγιο",
        "en" to "Belgium",
        "es" to "Bélgica",
        "et" to "Belgia",
        "fi" to "Belgia",
        "fr" to "Belgique",
        "ga" to "An Bheilg",
        "hr" to "Belgija",
        "hu" to "Belgium",
        "it" to "Belgio",
        "lt" to "Belgija",
        "lv" to "Beļģija",
        "mt" to "Il-Belġju",
        "nl" to "België",
        "pl" to "Belgia",
        "pt" to "Bélgica",
        "ro" to "Belgia",
        "sk" to "Belgicko",
        "sl" to "Belgija",
        "sv" to "Belgien"
    ),
    
    "BG" to mapOf(
        "bg" to "България",
        "cs" to "Bulharsko",
        "da" to "Bulgarien",
        "de" to "Bulgarien",
        "el" to "Βουλγαρία",
        "en" to "Bulgaria",
        "es" to "Bulgaria",
        "et" to "Bulgaaria",
        "fi" to "Bulgaria",
        "fr" to "Bulgarie",
        "ga" to "An Bhulgáir",
        "hr" to "Bugarska",
        "hu" to "Bulgária",
        "it" to "Bulgaria",
        "lt" to "Bulgarija",
        "lv" to "Bulgārija",
        "mt" to "Il-Bulgarija",
        "nl" to "Bulgarije",
        "pl" to "Bułgaria",
        "pt" to "Bulgária",
        "ro" to "Bulgaria",
        "sk" to "Bulharsko",
        "sl" to "Bolgarija",
        "sv" to "Bulgarien"
    ),
    
    "CY" to mapOf(
        "bg" to "Кипър",
        "cs" to "Kypr",
        "da" to "Cypern",
        "de" to "Zypern",
        "el" to "Κύπρος",
        "en" to "Cyprus",
        "es" to "Chipre",
        "et" to "Küpros",
        "fi" to "Kypros",
        "fr" to "Chypre",
        "ga" to "An Chipir",
        "hr" to "Cipar",
        "hu" to "Ciprus",
        "it" to "Cipro",
        "lt" to "Kipras",
        "lv" to "Kipra",
        "mt" to "Ċipru",
        "nl" to "Cyprus",
        "pl" to "Cypr",
        "pt" to "Chipre",
        "ro" to "Cipru",
        "sk" to "Cyprus",
        "sl" to "Ciper",
        "sv" to "Cypern"
    ),
    
    "CZ" to mapOf(
        "bg" to "Чешка република",
        "cs" to "Česká republika",
        "da" to "Tjekkiet",
        "de" to "Tschechische Republik",
        "el" to "Τσεχική Δημοκρατία",
        "en" to "Czech Republic",
        "es" to "República Checa",
        "et" to "Tšehhi Vabariik",
        "fi" to "Tšekki",
        "fr" to "République tchèque",
        "ga" to "Poblacht na Seice",
        "hr" to "Češka",
        "hu" to "Cseh Köztársaság",
        "it" to "Repubblica ceca",
        "lt" to "Čekija",
        "lv" to "Čehija",
        "mt" to "Ir-Repubblika Ċeka",
        "nl" to "Tsjechië",
        "pl" to "Czechy",
        "pt" to "República Checa",
        "ro" to "Republica Cehă",
        "sk" to "Česká republika",
        "sl" to "Češka",
        "sv" to "Tjeckien"
    ),
    
    "DE" to mapOf(
        "bg" to "Германия",
        "cs" to "Německo",
        "da" to "Tyskland",
        "de" to "Deutschland",
        "el" to "Γερμανία",
        "en" to "Germany",
        "es" to "Alemania",
        "et" to "Saksamaa",
        "fi" to "Saksa",
        "fr" to "Allemagne",
        "ga" to "An Ghearmáin",
        "hr" to "Njemačka",
        "hu" to "Németország",
        "it" to "Germania",
        "lt" to "Vokietija",
        "lv" to "Vācija",
        "mt" to "Il-Ġermanja",
        "nl" to "Duitsland",
        "pl" to "Niemcy",
        "pt" to "Alemanha",
        "ro" to "Germania",
        "sk" to "Nemecko",
        "sl" to "Nemčija",
        "sv" to "Tyskland"
    ),
    
    "DK" to mapOf(
        "bg" to "Дания",
        "cs" to "Dánsko",
        "da" to "Danmark",
        "de" to "Dänemark",
        "el" to "Δανία",
        "en" to "Denmark",
        "es" to "Dinamarca",
        "et" to "Taani",
        "fi" to "Tanska",
        "fr" to "Danemark",
        "ga" to "An Danmhairg",
        "hr" to "Danska",
        "hu" to "Dánia",
        "it" to "Danimarca",
        "lt" to "Danija",
        "lv" to "Dānija",
        "mt" to "Id-Danimarka",
        "nl" to "Denemarken",
        "pl" to "Dania",
        "pt" to "Dinamarca",
        "ro" to "Danemarca",
        "sk" to "Dánsko",
        "sl" to "Danska",
        "sv" to "Danmark"
    ),
    
    "EE" to mapOf(
        "bg" to "Естония",
        "cs" to "Estonsko",
        "da" to "Estland",
        "de" to "Estland",
        "el" to "Εσθονία",
        "en" to "Estonia",
        "es" to "Estonia",
        "et" to "Eesti",
        "fi" to "Viro",
        "fr" to "Estonie",
        "ga" to "An Eastóin",
        "hr" to "Estonija",
        "hu" to "Észtország",
        "it" to "Estonia",
        "lt" to "Estija",
        "lv" to "Igaunija",
        "mt" to "L-Estonja",
        "nl" to "Estland",
        "pl" to "Estonia",
        "pt" to "Estónia",
        "ro" to "Estonia",
        "sk" to "Estónsko",
        "sl" to "Estonija",
        "sv" to "Estland"
    ),
    
    "EL" to mapOf(
        "bg" to "Гърция",
        "cs" to "Řecko",
        "da" to "Grækenland",
        "de" to "Griechenland",
        "el" to "Ελλάδα",
        "en" to "Greece",
        "es" to "Grecia",
        "et" to "Kreeka",
        "fi" to "Kreikka",
        "fr" to "Grèce",
        "ga" to "An Ghréig",
        "hr" to "Grčka",
        "hu" to "Görögország",
        "it" to "Grecia",
        "lt" to "Graikija",
        "lv" to "Grieķija",
        "mt" to "Il-Greċja",
        "nl" to "Griekenland",
        "pl" to "Grecja",
        "pt" to "Grécia",
        "ro" to "Grecia",
        "sk" to "Grécko",
        "sl" to "Grčija",
        "sv" to "Grekland"
    ),
    
    "ES" to mapOf(
        "bg" to "Испания",
        "cs" to "Španělsko",
        "da" to "Spanien",
        "de" to "Spanien",
        "el" to "Ισπανία",
        "en" to "Spain",
        "es" to "España",
        "et" to "Hispaania",
        "fi" to "Espanja",
        "fr" to "Espagne",
        "ga" to "An Spáinn",
        "hr" to "Španjolska",
        "hu" to "Spanyolország",
        "it" to "Spagna",
        "lt" to "Ispanija",
        "lv" to "Spānija",
        "mt" to "Spanja",
        "nl" to "Spanje",
        "pl" to "Hiszpania",
        "pt" to "Espanha",
        "ro" to "Spania",
        "sk" to "Španielsko",
        "sl" to "Španija",
        "sv" to "Spanien"
    ),
    
    "FI" to mapOf(
        "bg" to "Финландия",
        "cs" to "Finsko",
        "da" to "Finland",
        "de" to "Finnland",
        "el" to "Φινλανδία",
        "en" to "Finland",
        "es" to "Finlandia",
        "et" to "Soome",
        "fi" to "Suomi",
        "fr" to "Finlande",
        "ga" to "An Fhionlainn",
        "hr" to "Finska",
        "hu" to "Finnország",
        "it" to "Finlandia",
        "lt" to "Suomija",
        "lv" to "Somija",
        "mt" to "Il-Finlandja",
        "nl" to "Finland",
        "pl" to "Finlandia",
        "pt" to "Finlândia",
        "ro" to "Finlanda",
        "sk" to "Fínsko",
        "sl" to "Finska",
        "sv" to "Finland"
    ),
    
    "FR" to mapOf(
        "bg" to "Франция",
        "cs" to "Francie",
        "da" to "Frankrig",
        "de" to "Frankreich",
        "el" to "Γαλλία",
        "en" to "France",
        "es" to "Francia",
        "et" to "Prantsusmaa",
        "fi" to "Ranska",
        "fr" to "France",
        "ga" to "An Fhrainc",
        "hr" to "Francuska",
        "hu" to "Franciaország",
        "it" to "Francia",
        "lt" to "Prancūzija",
        "lv" to "Francija",
        "mt" to "Franza",
        "nl" to "Frankrijk",
        "pl" to "Francja",
        "pt" to "França",
        "ro" to "Franța",
        "sk" to "Francúzsko",
        "sl" to "Francija",
        "sv" to "Frankrike"
    ),
    
    "GB" to mapOf(
        "bg" to "Обединено кралство",
        "cs" to "Spojené království",
        "da" to "Det Forenede Kongerige",
        "de" to "Vereinigtes Königreich",
        "el" to "Ηνωμένο Βασίλειο",
        "en" to "United Kingdom",
        "es" to "Reino Unido",
        "et" to "Ühendkuningriik",
        "fi" to "Yhdistynyt kuningaskunta",
        "fr" to "Royaume-Uni",
        "ga" to "An Ríocht Aontaithe",
        "hr" to "Ujedinjena Kraljevina",
        "hu" to "Egyesült Királyság",
        "it" to "Regno Unito",
        "lt" to "Jungtinė Karalystė",
        "lv" to "Apvienotā Karaliste",
        "mt" to "Ir-Renju Unit",
        "nl" to "Verenigd Koninkrijk",
        "pl" to "Zjednoczone Królestwo",
        "pt" to "Reino Unido",
        "ro" to "Regatul Unit",
        "sk" to "Spojené kráľovstvo",
        "sl" to "Združeno kraljestvo",
        "sv" to "Storbritannien"
    ),
    
    "HR" to mapOf(
        "bg" to "Хърватия",
        "cs" to "Chorvatsko",
        "da" to "Kroatien",
        "de" to "Kroatien",
        "el" to "Κροατία",
        "en" to "Croatia",
        "es" to "Croacia",
        "et" to "Horvaatia",
        "fi" to "Kroatia",
        "fr" to "Croatie",
        "ga" to "An Chróit",
        "hr" to "Hrvatska",
        "hu" to "Horvátország",
        "it" to "Croazia",
        "lt" to "Kroatija",
        "lv" to "Horvātija",
        "mt" to "Il-Kroazja",
        "nl" to "Kroatië",
        "pl" to "Chorwacja",
        "pt" to "Croácia",
        "ro" to "Croația",
        "sk" to "Chorvátsko",
        "sl" to "Hrvaška",
        "sv" to "Kroatien"
    ),
    
    "HU" to mapOf(
        "bg" to "Унгария",
        "cs" to "Maďarsko",
        "da" to "Ungarn",
        "de" to "Ungarn",
        "el" to "Ουγγαρία",
        "en" to "Hungary",
        "es" to "Hungría",
        "et" to "Ungari",
        "fi" to "Unkari",
        "fr" to "Hongrie",
        "ga" to "An Ungáir",
        "hr" to "Mađarska",
        "hu" to "Magyarország",
        "it" to "Ungheria",
        "lt" to "Vengrija",
        "lv" to "Ungārija",
        "mt" to "L-Ungerija",
        "nl" to "Hongarije",
        "pl" to "Węgry",
        "pt" to "Hungria",
        "ro" to "Ungaria",
        "sk" to "Maďarsko",
        "sl" to "Madžarska",
        "sv" to "Ungern"
    ),
    
    "IE" to mapOf(
        "bg" to "Ирландия",
        "cs" to "Irsko",
        "da" to "Irland",
        "de" to "Irland",
        "el" to "Ιρλανδία",
        "en" to "Ireland",
        "es" to "Irlanda",
        "et" to "Iirimaa",
        "fi" to "Irlanti",
        "fr" to "Irlande",
        "ga" to "Éire",
        "hr" to "Irska",
        "hu" to "Írország",
        "it" to "Irlanda",
        "lt" to "Airija",
        "lv" to "Īrija",
        "mt" to "L-Irlanda",
        "nl" to "Ierland",
        "pl" to "Irlandia",
        "pt" to "Irlanda",
        "ro" to "Irlanda",
        "sk" to "Írsko",
        "sl" to "Irska",
        "sv" to "Irland"
    ),
    
    "IT" to mapOf(
        "bg" to "Италия",
        "cs" to "Itálie",
        "da" to "Italien",
        "de" to "Italien",
        "el" to "Ιταλία",
        "en" to "Italy",
        "es" to "Italia",
        "et" to "Itaalia",
        "fi" to "Italia",
        "fr" to "Italie",
        "ga" to "An Iodáil",
        "hr" to "Italija",
        "hu" to "Olaszország",
        "it" to "Italia",
        "lt" to "Italija",
        "lv" to "Itālija",
        "mt" to "L-Italja",
        "nl" to "Italië",
        "pl" to "Włochy",
        "pt" to "Itália",
        "ro" to "Italia",
        "sk" to "Taliansko",
        "sl" to "Italija",
        "sv" to "Italien"
    ),
    
    "LT" to mapOf(
        "bg" to "Литва",
        "cs" to "Litva",
        "da" to "Litauen",
        "de" to "Litauen",
        "el" to "Λιθουανία",
        "en" to "Lithuania",
        "es" to "Lituania",
        "et" to "Leedu",
        "fi" to "Liettua",
        "fr" to "Lituanie",
        "ga" to "An Liotuáin",
        "hr" to "Litva",
        "hu" to "Litvánia",
        "it" to "Lituania",
        "lt" to "Lietuva",
        "lv" to "Lietuva",
        "mt" to "Il-Litwanja",
        "nl" to "Litouwen",
        "pl" to "Litwa",
        "pt" to "Lituânia",
        "ro" to "Lituania",
        "sk" to "Litva",
        "sl" to "Litva",
        "sv" to "Litauen"
    ),
    
    "LU" to mapOf(
        "bg" to "Люксембург",
        "cs" to "Lucembursko",
        "da" to "Luxembourg",
        "de" to "Luxemburg",
        "el" to "Λουξεμβούργο",
        "en" to "Luxembourg",
        "es" to "Luxemburgo",
        "et" to "Luksemburg",
        "fi" to "Luxemburg",
        "fr" to "Luxembourg",
        "ga" to "Lucsamburg",
        "hr" to "Luksemburg",
        "hu" to "Luxemburg",
        "it" to "Lussemburgo",
        "lt" to "Liuksemburgas",
        "lv" to "Luksemburga",
        "mt" to "Il-Lussemburgu",
        "nl" to "Luxemburg",
        "pl" to "Luksemburg",
        "pt" to "Luxemburgo",
        "ro" to "Luxemburg",
        "sk" to "Luxembursko",
        "sl" to "Luksemburg",
        "sv" to "Luxemburg"
    ),
    
    "LV" to mapOf(
        "bg" to "Латвия",
        "cs" to "Lotyšsko",
        "da" to "Letland",
        "de" to "Lettland",
        "el" to "Λεττονία",
        "en" to "Latvia",
        "es" to "Letonia",
        "et" to "Läti",
        "fi" to "Latvia",
        "fr" to "Lettonie",
        "ga" to "An Laitvia",
        "hr" to "Latvija",
        "hu" to "Lettország",
        "it" to "Lettonia",
        "lt" to "Latvija",
        "lv" to "Latvija",
        "mt" to "Il-Latvja",
        "nl" to "Letland",
        "pl" to "Łotwa",
        "pt" to "Letónia",
        "ro" to "Letonia",
        "sk" to "Lotyšsko",
        "sl" to "Latvija",
        "sv" to "Lettland"
    ),
    
    "MT" to mapOf(
        "bg" to "Малта",
        "cs" to "Malta",
        "da" to "Malta",
        "de" to "Malta",
        "el" to "Μάλτα",
        "en" to "Malta",
        "es" to "Malta",
        "et" to "Malta",
        "fi" to "Malta",
        "fr" to "Malte",
        "ga" to "Málta",
        "hr" to "Malta",
        "hu" to "Málta",
        "it" to "Malta",
        "lt" to "Malta",
        "lv" to "Malta",
        "mt" to "Malta",
        "nl" to "Malta",
        "pl" to "Malta",
        "pt" to "Malta",
        "ro" to "Malta",
        "sk" to "Malta",
        "sl" to "Malta",
        "sv" to "Malta"
    ),
    
    "NL" to mapOf(
        "bg" to "Нидерландия",
        "cs" to "Nizozemsko",
        "da" to "Nederlandene",
        "de" to "Niederlande",
        "el" to "Κάτω Χώρες",
        "en" to "Netherlands",
        "es" to "Países Bajos",
        "et" to "Madalmaad",
        "fi" to "Alankomaat",
        "fr" to "Pays-Bas",
        "ga" to "An Ísiltír",
        "hr" to "Nizozemska",
        "hu" to "Hollandia",
        "it" to "Paesi Bassi",
        "lt" to "Nyderlandai",
        "lv" to "Nīderlande",
        "mt" to "Il-Pajjiżi l-Baxxi",
        "nl" to "Nederland",
        "pl" to "Holandia",
        "pt" to "Países Baixos",
        "ro" to "Țările de Jos",
        "sk" to "Holandsko",
        "sl" to "Nizozemska",
        "sv" to "Nederländerna"
    ),
    
    "PL" to mapOf(
        "bg" to "Полша",
        "cs" to "Polsko",
        "da" to "Polen",
        "de" to "Polen",
        "el" to "Πολωνία",
        "en" to "Poland",
        "es" to "Polonia",
        "et" to "Poola",
        "fi" to "Puola",
        "fr" to "Pologne",
        "ga" to "An Pholainn",
        "hr" to "Poljska",
        "hu" to "Lengyelország",
        "it" to "Polonia",
        "lt" to "Lenkija",
        "lv" to "Polija",
        "mt" to "Il-Polonja",
        "nl" to "Polen",
        "pl" to "Polska",
        "pt" to "Polónia",
        "ro" to "Polonia",
        "sk" to "Poľsko",
        "sl" to "Poljska",
        "sv" to "Polen"
    ),
    
    "PT" to mapOf(
        "bg" to "Португалия",
        "cs" to "Portugalsko",
        "da" to "Portugal",
        "de" to "Portugal",
        "el" to "Πορτογαλία",
        "en" to "Portugal",
        "es" to "Portugal",
        "et" to "Portugal",
        "fi" to "Portugali",
        "fr" to "Portugal",
        "ga" to "An Phortaingéil",
        "hr" to "Portugal",
        "hu" to "Portugália",
        "it" to "Portogallo",
        "lt" to "Portugalija",
        "lv" to "Portugāle",
        "mt" to "Il-Portugall",
        "nl" to "Portugal",
        "pl" to "Portugalia",
        "pt" to "Portugal",
        "ro" to "Portugalia",
        "sk" to "Portugalsko",
        "sl" to "Portugalska",
        "sv" to "Portugal"
    ),
    
    "RO" to mapOf(
        "bg" to "Румъния",
        "cs" to "Rumunsko",
        "da" to "Rumænien",
        "de" to "Rumänien",
        "el" to "Ρουμανία",
        "en" to "Romania",
        "es" to "Rumanía",
        "et" to "Rumeenia",
        "fi" to "Romania",
        "fr" to "Roumanie",
        "ga" to "An Rómáin",
        "hr" to "Rumunjska",
        "hu" to "Románia",
        "it" to "Romania",
        "lt" to "Rumunija",
        "lv" to "Rumānija",
        "mt" to "Ir-Rumanija",
        "nl" to "Roemenië",
        "pl" to "Rumunia",
        "pt" to "Roménia",
        "ro" to "România",
        "sk" to "Rumunsko",
        "sl" to "Romunija",
        "sv" to "Rumänien"
    ),
    
    "SE" to mapOf(
        "bg" to "Швеция",
        "cs" to "Švédsko",
        "da" to "Sverige",
        "de" to "Schweden",
        "el" to "Σουηδία",
        "en" to "Sweden",
        "es" to "Suecia",
        "et" to "Rootsi",
        "fi" to "Ruotsi",
        "fr" to "Suède",
        "ga" to "An tSualainn",
        "hr" to "Švedska",
        "hu" to "Svédország",
        "it" to "Svezia",
        "lt" to "Švedija",
        "lv" to "Zviedrija",
        "mt" to "L-Isvezja",
        "nl" to "Zweden",
        "pl" to "Szwecja",
        "pt" to "Suécia",
        "ro" to "Suedia",
        "sk" to "Švédsko",
        "sl" to "Švedska",
        "sv" to "Sverige"
    ),
    
    "SK" to mapOf(
        "bg" to "Словакия",
        "cs" to "Slovinsko",
        "da" to "Slovakiet",
        "de" to "Slowakei",
        "el" to "Σλοβακία",
        "en" to "Slovakia",
        "es" to "Eslovaquia",
        "et" to "Slovakkia",
        "fi" to "Slovakia",
        "fr" to "Slovaquie",
        "ga" to "An tSlóvaic",
        "hr" to "Slovačka",
        "hu" to "Szlovákia",
        "it" to "Slovacchia",
        "lt" to "Slovakija",
        "lv" to "Slovākija",
        "mt" to "Is-Slovakkja",
        "nl" to "Slowakije",
        "pl" to "Słowacja",
        "pt" to "Eslováquia",
        "ro" to "Slovacia",
        "sk" to "Slovensko",
        "sl" to "Slovaška",
        "sv" to "Slovakien"
    ),
    
    "SI" to mapOf(
        "bg" to "Словения",
        "cs" to "Slovensko",
        "da" to "Slovenien",
        "de" to "Slovenia",
        "el" to "Σλοβενία",
        "en" to "Slovenia",
        "es" to "Eslovenia",
        "et" to "Sloveenia",
        "fi" to "Slovenia",
        "fr" to "Slovénie",
        "ga" to "An tSlóivéin",
        "hr" to "Slovenija",
        "hu" to "Szlovénia",
        "it" to "Slovenia",
        "lt" to "Slovėnija",
        "lv" to "Slovēnija",
        "mt" to "Is-Slovenja",
        "nl" to "Slovenië",
        "pl" to "Słowenia",
        "pt" to "Eslovénia",
        "ro" to "Slovenia",
        "sk" to "Slovinsko",
        "sl" to "Slovenija",
        "sv" to "Slovenien"
    )
)

fun printCountryNames() {
    var nameCount = 0
    val countries = listOf(
        "AT", "BE", "BG", "CY", "CZ", "DE", "DK", "EE", "EL", "ES", "FI", "FR", "GB", "HR", 
        "HU", "IE", "IT", "LT", "LU", "LV", "MT", "NL", "PL", "PT", "RO", "SE", "SK", "SI"
    )
    for (country in countries) {
        println("$country: ")
        val names = countryNames[country]!!
        println("${names.count()} -- ${officialLanguages.count()}")
        for (lang in officialLanguages) {
            val name = names[lang]!!
            println(name)
            nameCount += 1
        }
    }

    println("Total country name count = $nameCount")
}

fun getAllEvents(countries: List<Country>): List<Event> {
    val events = mutableListOf<Event>()

    for (country in countries) {
        events.add(Event(country, EventType.JOINED_UNION, country.joinedUnionDate))
        if (country.joinedEurozoneDate != null) {
            events.add(Event(country, EventType.JOINED_EUROZONE, country.joinedEurozoneDate!!))
        }
        if (country.joinedSchengenDate != null) {
            events.add(Event(country, EventType.JOINED_SCHENGEN, country.joinedSchengenDate!!))
        }
        if (country.exitedUnionDate != null) {
            events.add(Event(country, EventType.EXITED_UNION, country.exitedUnionDate!!))
        }
    }

    return events.toList()
}

fun printAllEvents(events: List<Event>) {
    for (event in events) {
        //println("${event.country.name} ${event.eventType} ${event.date}")
        println(event)
    }
}

// This is the original timeline used in the training
fun printOriginalTimeline(countries: List<Country>) {
    var joinsByDate = mutableMapOf<String, MutableList<String>>()
    for (country in countries) {
        if (joinsByDate.containsKey(country.joinedUnionDate)) {
            joinsByDate[country.joinedUnionDate]!!.add(country.name)
        }
        else {
            joinsByDate[country.joinedUnionDate] = mutableListOf<String>(country.name)
        }
    }
    
    println("Timeline:")
    var joinDates = joinsByDate.keys.toList().sorted()
    for (date in joinDates) {
        val joinedCountries = joinsByDate[date]!!.sorted()
        val lastIndex = joinedCountries.size - 1
        val countryPart = when (joinedCountries.size) {
            0 -> "***ERROR***"
            1 -> joinedCountries[0]
            2 -> joinedCountries.joinToString(" and ")
            else -> "${ joinedCountries.subList(0, lastIndex).joinToString(", ") } and ${joinedCountries[lastIndex]}" 
        }
        println("$date: $countryPart joined the EU")
    }
}

fun initData(): List<Country> {
    val finland = Country("FI", "Finland", City("Helsinki", Coordinate(60.1708, 24.9375)), 330_000L, 5_451_270L, "1995-01-01")
    val sweden = Country("SE", "Sweden", City("Stockholm", Coordinate(59.3294, 18.0686)), 438_574L, 9_644_864L, "1995-01-01")
    val belgium = Country("BE", "Belgium", City("Brussels", Coordinate(50.85, 4.35)), 30528L, 11_203_992L, "1958-01-01")
    val austria = Country("AT", "Austria", City("Vienna", Coordinate(48.2089, 16.3725)), 83879L, 8_507_786L, "1995-01-01")
    val czechRepublic = Country("CZ", "Czech Republic", City("Prague", Coordinate(50.0833, 14.4167)), 78867L, 10_512_419L, "2004-05-01")
    val netherlands = Country("NL", "Netherlands", City("Amsterdam", Coordinate(52.3731, 4.8922)), 41540L, 16_829_289L, "1958-01-01")
    val bulgaria = Country("BG", "Bulgaria", City("Sofia", Coordinate(42.7, 23.3333)), 111_002L, 7_245_677L, "2007-01-01")
    val greece = Country(
        "EL",
        "Greece",
        City(
            "Athens",
            Coordinate(37.9667, 23.7167)),
        131957L,
        10_992_589L,
        "1981-01-01")

    val cyprus = Country(
        "CY",
        "Cyprus",
        City(
            "Nicosia",
            Coordinate(35.1667, 33.3667)),
        9251,
        858_000,
        "2004-05-01")

    val denmark = Country(
        "DK",
        "Denmark",
        City(
            "Copenhagen",
            Coordinate(55.6761, 12.5683)),
        42_921,
        5_627_235,
        "1973-01-01")

    val estonia = Country(
        "EE",
        "Estonia",
        City(
            "Tallinn",
            Coordinate(59.4372, 24.7453)),
        45227,
        1315819,
        "2004-01-01")

    val france = Country(
        "FR",
        "France",
        City(
            "Paris",
            Coordinate(48.8567, 2.3508)),
        632_833,
        65_856_609L,
        "1958-01-01")

    val germany = Country(
        "DE",
        "Germany",
        City(
            "Berlin",
            Coordinate(52.5167, 13.3833)),
        357340,
        80780000,
        "1958-01-01")

    val hungary = Country(
        "HU",
        "Hungary",
        City(
            "Budapest",
            Coordinate(47.4719, 19.0503)),
        93024,
        9879000,
        "2004-01-01")

    val ireland = Country(
        "IE",
        "Ireland",
        City(
            "Dublin",
            Coordinate(53.3478, -6.2597)),
        69797,
        4604029,
        "1973-01-01")

    val latvia = Country(
        "LV",
        "Latvia",
        City(
            "Riga",
            Coordinate(56.9489, 24.1064)),
        64573,
        2001468,
        "2004-05-01")

    val lithuania = Country(
        "LT",
        "Lithuania",
        City(
            "Vilnius",
            Coordinate(54.6833, 25.2833)),
        65300,
        2943472,
        "2004-05-01")

    val luxembourg = Country(
        "LU",
        "Luxembourg",
        City(
            "Luxembourg",
            Coordinate(49.6117, 6.13)),
        2586,
        549680,
        "2004-05-01")

    val malta = Country(
        "MT",
        "Malta",
        City(
            "Valletta",
            Coordinate(35.8978, 14.5125)),
        316,
        425384,
        "2004-05-01")

    val poland = Country(
        "PL",
        "Poland",
        City(
            "Warsaw",
            Coordinate(52.2333, 21.0167)),
        312679,
        38495659,
        "2004-05-01")

    val portugal = Country(
        "PT",
        "Portugal",
        City(
            "Lisbon",
            Coordinate(38.7136, -9.1392)),
        92225,
        10427301,
        "1986-01-01")

    val romania = Country(
        "RO",
        "Romania",
        City(
            "Bucharest",
            Coordinate(44.4325, 26.1039)),
        238391,
        19942642,
        "2007-01-01")

    val slovakia = Country(
        "SK",
        "Slovakia",
        City(
            "Bratislava",
            Coordinate(48.1439, 17.1097)),
        49035,
        5415949,
        "2004-05-01")

    val slovenia = Country(
        "SI",
        "Slovenia",
        City(
            "Ljubljana",
            Coordinate(46.0556, 14.5083)),
        20273,
        2061085,
        "2004-05-01")

    val unitedKingdom = Country(
        "GB",
        "United Kingdom",
        City(
            "London",
            Coordinate(51.5072, -0.1275)),
        248528,
        64308261,
        "1973-01-01")

    val croatia = Country(
        "HR",
        "Croatia",
        City(
            "Zagreb",
            Coordinate(45.8167, 15.9833)),
        56594,
        4246700,
        "2013-07-01")

    val italy = Country(
        "IT",
        "Italy",
        City(
            "Rome",
            Coordinate(41.9, 12.5)),
        302073,
        60782668,
        "1958-01-01")

    val spain = Country(
        "ES",
        "Spain",
        City(
            "Madrid",
            Coordinate(40.3833, -3.7167)),
        505970,
        46507760,
        "1986-01-01")
    
    val countries: List<Country> = listOf(
        finland, sweden, belgium, austria, czechRepublic, 
        netherlands, bulgaria, greece, cyprus, denmark,
        estonia, france, germany, hungary, ireland,
        latvia, lithuania, luxembourg, malta, poland,
        portugal, romania, slovakia, slovenia, unitedKingdom,
        croatia, italy, spain)

    val eurozoneJoins = mapOf(
        "1999-01-01" to listOf(austria, belgium, finland, france, germany, ireland, italy, luxembourg, netherlands, portugal, spain),
        "2001-01-01" to listOf(greece),
        "2007-01-01" to listOf(slovenia),
        "2008-01-01" to listOf(cyprus, malta),
        "2009-01-01" to listOf(slovakia),
        "2011-01-01" to listOf(estonia),
        "2014-01-01" to listOf(latvia),
        "2015-01-01" to listOf(lithuania)
    )

    for (euroDate in eurozoneJoins.keys.toList()) {
        val countries = eurozoneJoins[euroDate]!!
        for (country in countries) {
            country.joinedEurozoneDate = euroDate
        }
    }

    val schengenJoins = mapOf(
        "1995-03-26" to listOf(belgium, france, germany, luxembourg, netherlands, portugal, spain),
        "1997-10-26" to listOf(italy),
        "2000-01-01" to listOf(greece),
        "2001-03-25" to listOf(denmark, finland, sweden),
        "2007-12-01" to listOf(austria, czechRepublic, estonia, hungary, latvia, lithuania, malta, poland, slovakia, slovenia)
    )

    for (schengenDate in schengenJoins.keys.toList()) {
        val countryCodes = schengenJoins[schengenDate]
        for (country in countries) {
            country.joinedSchengenDate = schengenDate
        }
    }

    return countries.toList()
}

fun printTimeline(events: List<Event>) {
    println("Timeline:")
    val eventsByDate = events.groupBy { it.date }
    println(eventsByDate)

/*
    for (date in eventsByDate.keys.sorted()) {
        var line = "$date: "
        val eventList = eventsByDate[date]!!
        println(eventList)
        val eventsByType = eventList.groupBy { it.eventType }
        for (event in eventsByType.keys) {
            val events = eventsByType[event]!!
            var names = events.map { it.country.name }.sorted()
            if (names.count() >= 2) {
                val lastName = names.last()
                line += names.dropLast(1).joinToString(separator = ", ")
                line += " and $lastName"
            }
            else {
                line += names.joinToString(separator = ", ")
            }
            val eventDescription = when (event.eventType) {
                EventType.JOINED_UNION    -> "joined the EU"
                EventType.JOINED_SCHENGEN -> "joined the Schengen agreement"
                EventType.JOINED_EUROZONE -> "joined the Eurozone"
                EventType.EXITED_UNION    -> "exited the EU"
            }
            line += " $eventDescription. "
        }
        print(line)
    }
*/
}

fun main(args: Array<String>) {
    val countries = initData()
    printOriginalTimeline(countries)

    /*
    var totalPopulationIterative = 0L
    for (country in countries) {
        totalPopulationIterative += country.population
    }
    println("Total population (iterative) = $totalPopulationIterative")

    val totalPopulationFunctional = countries.map { it.population }.reduce { total, item -> total + item }
    println("Total population (functional, map/reduce) = $totalPopulationFunctional")

    val totalPopulation = countries.map { it.population }.sum()
    println("Total population (functional, sum) = $totalPopulation")
    */

    //printCityNames()
    //printCountryNames()

    val events = getAllEvents(countries)
    //printAllEvents(events)

    printTimeline(events)
}
