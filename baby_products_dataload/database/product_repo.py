import psycopg2


def run_sql(sql):
    try:
        # connect to the PostgreSQL server
        print('Connecting to the PostgreSQL database...')
        conn = psycopg2.connect("dbname=baby user=postgres password=postgres")
        cursor = conn.cursor()
        
	    # execute a statement
        cursor.execute(sql)
        cursor.close()

        conn.commit()

    except (Exception, psycopg2.DatabaseError) as error:
        print(error)
    finally:
        if conn is not None:
            conn.close()
            print('Database connection closed.')

def add_product(product_name, price):
    sql = "call add_product('Baby Monitor'::character varying, '" + product_name + "'::character varying, " + str(price) + "::money);"
    run_sql(sql)

def add_feature(product_name, feature):
    sql = "call add_feature('" + product_name + "'::character varying, '" + feature + "'::character varying);"
    run_sql(sql)

def add_accolade(product_name, accolade, source):
    sql = "call add_accolade('" + product_name + "'::character varying, '" + accolade + "'::character varying, '" + source + "'::character varying);"
    run_sql(sql)
