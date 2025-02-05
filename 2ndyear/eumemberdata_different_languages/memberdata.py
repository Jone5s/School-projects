import os
import logging

import psycopg2

DATABASE_URL = os.environ['DATABASE_URL']

language_codes = ['bg', 'cs', 'da', 'de', 'el', 'en', 'es', 'et', 'fi', 'fr', 'ga', 'hr', 'hu', 'it', 'lt', 'lv', 'mt', 'nl', 'pl', 'pt', 'ro', 'sk', 'sl', 'sv']

def get_countries():
    conn = None
    result = []

    try:
        conn = psycopg2.connect(DATABASE_URL, sslmode='require')
        
        city_names = {}
        city_name_cursor = conn.cursor()
        city_name_cursor.execute('SELECT city_id, language_code, name FROM city_name')
        city_names_result = city_name_cursor.fetchall()
        for city_name in city_names_result:
            city_id, lang, name = city_name[0], city_name[1], city_name[2]
            city_names.setdefault(city_id, {})[lang] = name
        city_name_cursor.close()

        cities = {}
        city_cursor = conn.cursor()
        city_cursor.execute('SELECT city_id, latitude, longitude FROM city')
        cities_result = city_cursor.fetchall()
        for city in cities_result:
            city_id, latitude, longitude = city[0], city[1], city[2]
            city_dict = {'name': city_names[city_id],
                        'coordinate': {'longitude': longitude, 'latitude': latitude}}
            cities[city_id] = city_dict
        city_cursor.close()

        country_cursor = conn.cursor()
        country_cursor.execute('SELECT country_code FROM country')
        country_codes = [item[0] for item in country_cursor.fetchall()]
        country_cursor.close()

        country_names = {}  # key is country code, value is dictionary of names (with language code as key, name in that language as value)
        country_joins = {}  # key is country code, value is dictionary of join dates

        for cc in country_codes:
            names_statement = 'SELECT country_code, language_code, name FROM country_name WHERE country_code = %s'
            names_cursor = conn.cursor()
            names_cursor.execute(names_statement, (cc,))
            names_result = names_cursor.fetchall()
            names_for_language = {}
            for name in names_result:
                names_for_language[name[1]] = name[2]
            country_names[cc] = names_for_language
            names_cursor.close()

            joins_statement = 'SELECT country_code, union_date, euro_date, schengen_date, exit_date FROM membership WHERE country_code = %s'
            joins_cursor = conn.cursor()
            joins_cursor.execute(joins_statement, (cc,))
            joins = joins_cursor.fetchall()
            for join in joins:
                joins_for_country = {}                
                joins_for_country['union'] = join[1]
                joins_for_country['euro'] = join[2]
                joins_for_country['schengen'] = join[3]
                joins_for_country['exit'] = join[4]
            country_joins[cc] = joins_for_country
            joins_cursor.close()

        all_cursor = conn.cursor()
        all_statement = 'SELECT country_code, capital, area, population, population_year, currency_code, national_day FROM country ORDER BY country_code'
        all_cursor.execute(all_statement)
        countries = all_cursor.fetchall()
        all_cursor.close()

    except psycopg2.Error as e:
        error_message = 'Error %s: %s' % (e.pgcode, e.pgerror)
        logging.error(error_message)
        return error_message

    finally:
        if conn:
            conn.close()

    result = []
    for country in countries:
        cc = country[0]
        country_dict = {'code': cc,
                        'name': country_names[cc],
                        'capital': cities[country[1]],
                        'area': country[2],
                        'population': {'population': country[3], 'year': country[4]},
                        'currency': country[5],
                        'joined': country_joins[cc]}
        result.append(country_dict)

    return result

def get_country(country_code):
    # Brute force: get all countries, then pick the one you want
    all_countries = get_countries()
    return next((c for c in all_countries if c['code'] == country_code), None)

def get_cities():
    conn = None
    cities = []

    try:
        conn = psycopg2.connect(DATABASE_URL, sslmode='require')

        city_names = {}
        city_name_cursor = conn.cursor()
        city_name_cursor.execute('SELECT city_id, language_code, name FROM city_name')
        city_names_result = city_name_cursor.fetchall()
        for city_name in city_names_result:
            city_id, lang, name = city_name[0], city_name[1], city_name[2]
            city_names.setdefault(city_id, {})[lang] = name
        city_name_cursor.close()

        city_cursor = conn.cursor()
        city_cursor.execute('SELECT city_id, latitude, longitude FROM city')
        cities_result = city_cursor.fetchall()
        for city in cities_result:
            city_id, latitude, longitude = city[0], city[1], city[2]
            city_dict = {'id': city_id, 
                         'name': city_names[city_id],
                         'coordinate': {'longitude': longitude, 'latitude': latitude}}
            cities.append(city_dict)
        city_cursor.close()

    except psycopg2.Error as e:
        error_message = 'Error %s: %s' % (e.pgcode, e.pgerror)
        logging.error(error_message)
        return error_message

    finally:
        if conn:
            conn.close()

    return cities

def get_city(city_id):
    all_cities = get_cities()
    return next((c for c in all_cities if c['id'] == city_id), None)

def get_updated():
    conn = None
    timestamp = 0
    try:
        conn = psycopg2.connect(DATABASE_URL, sslmode='require')
        cur = conn.cursor()
        cur.execute('SELECT timestamp FROM updated ORDER BY timestamp DESC LIMIT 1')
        result = cur.fetchall()
        timestamp = result[0][0]
        cur.close()
    except psycopg2.Error as e:
        error_message = 'Error %s: %s' % (e.pgcode, e.pgerror)
        logging.error(error_message)
        return error_message

    finally:
        if conn:
            conn.close()

    return timestamp
