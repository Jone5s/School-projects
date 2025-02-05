import sys
import sqlite3

from tabulate import tabulate

def load_cities(db_name):
    con = sqlite3.connect(db_name)
    cur = con.cursor()

    cur.execute("SELECT city_id, latitude, longitude FROM city")
    result = {row[0]: {'latitude': row[1], 'longitude': row[2]} for row in cur.fetchall()}

    cur.close()
    con.close()

    return result

def load_country_names(db_name, language):
    con = sqlite3.connect(db_name)
    cur = con.cursor()

    cur.execute("SELECT country_code, name FROM country_name WHERE language_code = '%s'" % (language))

    names = {row[0]: row[1] for row in cur.fetchall()}

    cur.close()
    con.close()

    return names

def load_city_names(db_name, language):
    con = sqlite3.connect(db_name)
    cur = con.cursor()

    cur.execute("SELECT city_id, name FROM city_name WHERE language_code = '%s'" % (language))

    names = {row[0]: row[1] for row in cur.fetchall()}

    cur.close()
    con.close()

    return names

def load_capitals(db_name):
    con = sqlite3.connect(db_name)
    cur = con.cursor()

    cur.execute("SELECT country_code, capital FROM country")

    capitals = {row[0]: row[1] for row in cur.fetchall()}

    cur.close()
    con.close()

    return capitals

if __name__ == '__main__':
    if len(sys.argv) < 3: #
        print('Usage: python3 dbname lang')
        sys.exit(-1)

    db_name = sys.argv[1]
    language = sys.argv[2]

    cities = load_cities(db_name)
    country_names = load_country_names(db_name, language)
    city_names = load_city_names(db_name, language)
    capitals = load_capitals(db_name)

    table = []
    for country_code in country_names.keys():
        country_name = country_names[country_code]
        capital = capitals[country_code]
        capital_name = city_names[capital]
        latitude = cities[capital]['latitude']
        longitude = cities[capital]['longitude']
        table.append([country_name, capital_name, latitude, longitude])

    col_names = ['Country', 'Capital', 'Latitude', 'Longitude']
    print(tabulate(table, headers=col_names, tablefmt='fancy_grid'))
