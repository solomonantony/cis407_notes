# db.py
import psycopg2
import psycopg2.extras
import os
from dotenv import load_dotenv
load_dotenv()   # reads .env into os.environ
def get_connection():
	"""Open and return a new database connection."""
	conn = psycopg2.connect(
    	host=os.environ['DB_HOST'],
    	port=os.environ['DB_PORT'],
    	dbname=os.environ['DB_NAME'],
    	user=os.environ['DB_USER'],
    	password=os.environ['DB_PASSWORD']
	)
	return conn
