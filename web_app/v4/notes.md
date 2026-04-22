Key Concepts
•	load_dotenv()  reads the .env file and injects each KEY=value pair into the process environment.
•	os.environ.get('KEY', 'default')  reads the value, falling back to a default if it is missing.
•	SECRET_KEY is required by Flask for sessions and flash messages. Any secret string works in development.

Checkpoint
•	Visit /config-check. Does it show the DATABASE_URL? Then remove that route.
•	What happens if .env is missing entirely? How would you make the app fail clearly instead of silently?

