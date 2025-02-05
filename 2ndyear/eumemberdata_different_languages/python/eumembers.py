import sys
import sqlite3
from enum import Enum
from typing import List, Dict, Optional
from collections import defaultdict

class EventKind(Enum):
    @classmethod
    def list(cls):
        return list(map(lambda c: c.value, cls))

    def __str__(self) -> str:
        if self == EventKind.JOINED_UNION:
            return 'joined the EU'
        elif self == EventKind.JOINED_EUROZONE:
            return 'joined the eurozone'
        elif self == EventKind.JOINED_SCHENGEN:
            return 'joined the Schengen treaty'
        elif self == EventKind.EXITED_UNION:
            return 'exited the EU'
        else:
            return '(unknown event)'

    JOINED_UNION = 1
    JOINED_EUROZONE = 2
    JOINED_SCHENGEN = 3
    EXITED_UNION = 4

class Country:
    def __init__(self, country_code: str, name: str = '') -> None:
        self.country_code = country_code
        self.name = name

    def __str__(self) -> str:
        return self.name

    def __repr__(self) -> str:
        return f'Country({self.country_code}, "{self.name}")'

class Event:
    def __init__(self, date: str, kind: EventKind, country_name: str) -> None:
        self.date = date
        self.kind = kind
        self.country_name = country_name

    def __str__(self) -> str:
        return f'{self.date}: {self.country_name} {self.kind}'

    def __repr__(self) -> str:
        return f'{self.date}: {self.country_name} {self.kind}'

def get_country_name(cur: sqlite3.Cursor, country_code: str, lang: str = 'en') -> str:
    cur.execute("SELECT * FROM country_name WHERE country_code = '%s' AND language_code = '%s'" % (country_code, lang))
    rows = cur.fetchall()
    if len(rows) != 0:
        return rows[0][2]
    else:
        return ''

def find_country(countries: List[Country], country_code: str) -> Optional[Country]:
    for country in countries:
        if country.country_code == country_code:
            return country
    return None

def make_timeline(events: Dict[str, List[Event]]) -> None:
    dates: List[str] = sorted(list(events.keys()))

    for date in dates:
        date_events = defaultdict(list)
        for event in events[date]:
            date_events[event.kind].append(event)

        for event_kind in EventKind.list():
            if event_kind in date_events:
                date_events[event_kind].sort(key=lambda e: e.country_name)

        for event_kind in date_events:
            country_names = [e.country_name for e in date_events[event_kind]]
            print(f'{event.date}: {concatenated(country_names)} {event.kind}.')

def concatenated(names: List[str]) -> str:
    if len(names) == 0:
        return ''

    if len(names) == 1:
        return names[0]

    if len(names) == 2:
        return names[0] + ' and ' + names[1]

    parts = [
        names[0],
        ', ',
        ', '.join(names[1 : len(names) - 1]),
        ' and ',
        names[-1]
    ]
    return ''.join(parts)

def load_data(db_name):
    con = sqlite3.connect(db_name)
    cur = con.cursor()

    cur.execute('SELECT * FROM country')
    countries = [Country(row[0]) for row in cur.fetchall()]

    for c in countries:
        c.name = get_country_name(cur, c.country_code)

    cur.execute('SELECT * FROM membership')
    membership_rows = cur.fetchall()

    all_events = defaultdict(list)  # dict where keys are dates, and values are lists of events.
    # For more on using defaultdict see https://realpython.com/python-defaultdict/

    for row in membership_rows:
        country: Optional[Country] = find_country(countries, row[0])
        if country is None:
            print(f'country {row[0]} not found!')
            continue

        # Join date is always there (as specified in the database schema)
        join_date = row[1]
        all_events[join_date].append(Event(join_date, EventKind.JOINED_UNION, country.name))

        # Eurozone, Schengen and exit dates might not be present
        if row[2]:
            euro_date = row[2]
            all_events[euro_date].append(Event(euro_date, EventKind.JOINED_EUROZONE, country.name))

        if row[3]:
            schengen_date = row[3]
            all_events[schengen_date].append(Event(schengen_date, EventKind.JOINED_SCHENGEN, country.name))

        if row[4]:
            exit_date = row[4]
            all_events[exit_date].append(Event(exit_date, EventKind.EXITED_UNION, country.name))

    cur.close()
    con.close()

    return all_events

if __name__ == '__main__':
    if len(sys.argv) < 2: #
        print('Need at least the SQLite database file name.')
        sys.exit(-1)

    db_name = sys.argv[1]
    #print(f'using database file "{db_name}"')

    all_events = load_data(db_name)

    make_timeline(all_events)
