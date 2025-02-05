/*
 * 'country_code' - ISO 3166 two-letter code, like 'FI'
 * 'capital' - foreign key to the 'city' table
 * 'area' - the area of the country in square kilometers
 * 'population' - the country's population count or estimate
 * 'population_year' - the year of the population count
 * 'currency_code' - the currency code of the country's currency (can be used to
 * retrieve the currency name(s) from the 'currency_name' table)
 * 'national_day' - the national day of this country in the Gregorian calendar,
 * in the format '--MM-DD'
 */
CREATE TABLE IF NOT EXISTS country (
    country_code TEXT PRIMARY KEY NOT NULL,
    capital TEXT NOT NULL REFERENCES city(city_id),
    area INTEGER,
    population INTEGER,
    population_year INTEGER,
    currency_code TEXT NOT NULL,
    national_day TEXT
);

/*
 * 'country_code' - ISO 3166 two-letter code, like 'FI'
 * 'language_code' - the ISO 639 two-letter code, like 'en'
 * 'name' - the name of the country in the language indicated by 'language_code'
 */
CREATE TABLE IF NOT EXISTS country_name (
    country_code TEXT NOT NULL,
    language_code TEXT NOT NULL,
    name TEXT NOT NULL
);

/*
 * 'city_id' - the unique ID of the city as a string (its English name folded into lowercase)
 * latitude, longitude - the location of some central place in the city (from Wikipedia)
 */
CREATE TABLE IF NOT EXISTS city (
    city_id TEXT PRIMARY KEY NOT NULL,
    latitude FLOAT NOT NULL,
    longitude FLOAT NOT NULL
);

/*
 * city_id - foreign key to the city table
 * 'language_code' - the ISO 639 two-letter code, like 'en'.
 * 'name' - the name of the city in the language indicated by 'language_code'
 */
CREATE TABLE IF NOT EXISTS city_name (
    city_id TEXT NOT NULL REFERENCES city(city_id),
    language_code TEXT NOT NULL,
    name TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS currency (
    currency_code TEXT PRIMARY KEY NOT NULL,
    currency_symbol TEXT
);

/*
 * 'currency_code' - the ISO 4217 three-letter code, like 'EUR'.
 * 'language_code' - the ISO 639 two-letter code, like 'en'.
 * 'name' - the name of the currency in the language indicated by the
 * 'language_code' column.
 */
CREATE TABLE IF NOT EXISTS currency_name(
    currency_code TEXT NOT NULL,
    language_code TEXT NOT NULL,
    name TEXT NOT NULL
);

/*
 * The dates when a country has joined the union, the eurozone, or the Schengen treaty.
 * If the country is not a member of the eurozone or Schengen, the corresponding column value is NULL,
 * otherwise the value is the date in the Gregorian calendar, expressed in the ISO 8601 standard format
 * 'YYYY-MM-DD'. Obviously the date of joining the union cannot be NULL, since there are only member
 * countries in this data.
 */
CREATE TABLE IF NOT EXISTS membership(
    country_code TEXT NOT NULL REFERENCES country(country_code),
    union_date TEXT NOT NULL,
    euro_date TEXT,
    schengen_date TEXT,
    exit_date TEXT
);

/*
 * The name of the European Union in the official languages.
 * 'language_code' - the ISO 639 two-letter code, like 'en'
 * 'name' - the name of the EU in the language indicated by 'language_code'
 */
CREATE TABLE IF NOT EXISTS union_name(
    language_code TEXT NOT NULL,
    name TEXT NOT NULL
);
