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

    return render_template('students.html', students=rows)

@app.route('/students/edit/<std_no>')
def edit_student(std_no):
    conn = get_connection()
    cur = conn.cursor()

    cur.execute("""
        SELECT StdNo, StdFirstName, StdLastName, StdCity, StdState, StdZip, StdMajor, StdClass, StdGPA
        FROM Student
        WHERE StdNo = %s
    """, (std_no,))
    student = cur.fetchone()

    cur.close()
    conn.close()

    return render_template('edit_student.html', student=student)

if __name__ == '__main__':
    app.run(debug=True)
