import sqlite3
import csv

db_filename = 'eumemberdata.sqlite3'

def populate_table(conn, table_name):
    with open(csv_filename, encoding='utf-8') as csv_file:
        csv_reader = csv.DictReader(csv_file)

        columns = ', '.join([column for column in csv_reader.fieldnames])
        values = ', '.join([':%s' % column for column in csv_reader.fieldnames])

        statement = 'insert into %s (%s) values (%s)' % (table_name, columns, values)

        cursor = conn.cursor()
        cursor.executemany(statement, csv_reader)
        conn.commit()
        cursor.close()

table_names = ['country', 'country_name', 'city', 'city_name', 'union_name', 'membership']

for table_name in table_names:
    csv_filename = table_name + '.csv'
    print('Processing %s' % csv_filename)

    conn = sqlite3.connect(db_filename)
    populate_table(conn, table_name)

print('Done.')
