import sys
import sqlite3
import math

#
# Utility functions
#

EARTH_EQUATORIAL_RADIUS = 6378.1370

def haversine(lat1_deg, lon1_deg, lat2_deg, lon2_deg, earth_radius=EARTH_EQUATORIAL_RADIUS):
    """
    Computes the distance between two geographical points in kilometers.

    The coordinate values are degrees.
    Uses the haversine formula (see http://en.wikipedia.org/wiki/Haversine_formula).
    This implementation is derived from the JavaScript code
    by Andrew Hedges at http://andrew.hedges.name/experiments/haversine/.
    The Earth radius defaults to the Earth's equatorial radius.
    For added accuracy, you may want pass a radius more suitable for the
    latitudes of the points you are processing.
    """
    lat1 = math.radians(lat1_deg)
    lon1 = math.radians(lon1_deg)
    lat2 = math.radians(lat2_deg)
    lon2 = math.radians(lon2_deg)

    dlon = lon2 - lon1
    dlat = lat2 - lat1
    a = (math.sin(dlat/2))**2 + math.cos(lat1) * math.cos(lat2) * (math.sin(dlon/2))**2
    c = 2 * math.atan2( math.sqrt(a), math.sqrt(1-a) )
    d = earth_radius * c

    return d

def load_cities(db_name):
    con = sqlite3.connect(db_name)
    cur = con.cursor()

    cur.execute("SELECT city_id, latitude, longitude FROM city")
    rows = cur.fetchall()

    cities = {row[0]: {
        'latitude': float(row[1]),
        'longitude': float(row[2])
    } for row in rows}

    cur.close()
    con.close()

    return cities

if __name__ == '__main__':
    if len(sys.argv) < 2:
        print('Need at least the SQLite database file name.')
        sys.exit(-1)

    db_name = sys.argv[1]

    cities = load_cities(db_name)

    my_lat = 61.50
    my_lon = 23.75

    for city in cities:
        lat = cities[city]['latitude']
        lon = cities[city]['longitude']
        distance = haversine(my_lat, my_lon, lat, lon)
        print(f'{city}: {distance:.0f} km')
