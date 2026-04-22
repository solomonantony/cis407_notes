from flask import Flask, render_template, request
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

@app.route('/students/edit/<std_no>', methods=['GET'])
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

@app.route('/students/save', methods=['POST'])
def save_student():
    # Collect form data
    std_no     = request.form['std_no']
    first_name = request.form['first_name']
    last_name  = request.form['last_name']
    city       = request.form['city']
    state      = request.form['state']
    zip_code   = request.form['zip']
    major      = request.form['major']
    std_class  = request.form['std_class']
    gpa        = request.form['gpa']

    conn = get_connection()
    cur = conn.cursor()

    cur.execute("""
        UPDATE Student
        SET StdFirstName = %s,
            StdLastName  = %s,
            StdCity      = %s,
            StdState     = %s,
            StdZip       = %s,
            StdMajor     = %s,
            StdClass     = %s,
            StdGPA       = %s
        WHERE StdNo = %s
    """, (first_name, last_name, city, state, zip_code, major, std_class, gpa, std_no))

    conn.commit()
    cur.close()
    conn.close()

    return 'Saved!  <a href="/students">Back to Students</a>'

if __name__ == '__main__':
    app.run(debug=True)
