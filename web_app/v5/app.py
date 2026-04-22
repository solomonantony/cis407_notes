from flask import Flask, render_template
from db import get_connection

app = Flask(__name__)

@app.route('/')
def index():
    return render_template('home.html')

@app.route('/students')
def students():
    return render_template('students.html')

@app.route('/test-db')
def test_db():
    """Temporary route to verify the database connection works."""
    try:
        conn = get_connection()
        cur = conn.cursor()
        cur.execute('SELECT version();')
        version = cur.fetchone()
        cur.close()
        conn.close()
        return f'<p>Connected successfully!</p><p>PostgreSQL version: {version[0]}</p>'
    except Exception as e:
        return f'<p style="color:red">Connection failed: {e}</p>'

if __name__ == '__main__':
    app.run(debug=True)
