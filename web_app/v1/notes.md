Open http://127.0.0.1:5000 in your browser. You should see: Hello, World!

Key Concepts
•	Flask(__name__)  —  creates the application object. __name__ tells Flask where to find templates and static files.
•	@app.route('/')  —  registers the function as the handler for HTTP GET requests to the root URL.
•	debug=True  —  auto-reloads the server when you save a file; shows detailed error pages. Never use in production.

Checkpoint
•	Change the return string and save. Does the browser update automatically without restarting?
•	What happens if you visit http://127.0.0.1:5000/anything?  Why?
