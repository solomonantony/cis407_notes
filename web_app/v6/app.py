from flask import Flask, render_template
from db import get_connection

app = Flask(__name__)

@app.route('/')
def index():
    return render_template('home.html')

@app.route('/students')
def students():
    conn = get_connection()
    cur = conn.cursor()

    cur.execute("""
        SELECT StdNo, StdFirstName, StdLastName, StdCity, StdState, StdMajor, StdClass, StdGPA
        FROM Student
        ORDER BY StdLastName, StdFirstName
    """)
    rows = cur.fetchall()

    cur.close()
    conn.close()

    # Pass the rows to the template
    return render_template('students.html', students=rows)

if __name__ == '__main__':
    app.run(debug=True)
