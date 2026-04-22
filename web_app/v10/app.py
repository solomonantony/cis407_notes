from flask import Flask, render_template, request, redirect, url_for
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

    return redirect(url_for('students'))

@app.route('/students/courses/<std_no>')
def student_courses(std_no):
    conn = get_connection()
    cur = conn.cursor()

    # Fetch the student's name for the page heading
    cur.execute("""
        SELECT StdFirstName, StdLastName
        FROM Student
        WHERE StdNo = %s
    """, (std_no,))
    student = cur.fetchone()

    # Join Registration -> Enrollment -> Offering -> Course
    # to get every course the student has enrolled in
    cur.execute("""
        SELECT c.CourseNo,
               c.CrsDesc,
               c.CrsUnits,
               o.OffTerm,
               o.OffYear,
               e.EnrGrade
        FROM   Enrollment e
        JOIN   Offering     o ON e.OfferNo  = o.OfferNo
        JOIN   Course       c ON o.CourseNo = c.CourseNo
        WHERE  e.StdNo = %s
        ORDER BY o.OffYear, o.OffTerm, c.CourseNo
    """, (std_no,))
    courses = cur.fetchall()

    cur.close()
    conn.close()

    return render_template('student_courses.html',
                           student=student,
                           std_no=std_no,
                           courses=courses)

if __name__ == '__main__':
    app.run(debug=True)
