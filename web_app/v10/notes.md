**Goal:** Demonstrate a multi-table JOIN query driven by a URL parameter.

**What's new:**
- New route `/students/courses/<std_no>` and view function `student_courses()`
- Two queries: one for the student's name (heading), one for the course enrollment details
- A four-table JOIN: `Registration → Enrollment → Offering → Course`
- "View Courses" link added to each row in `students.html`
- `student_courses.html` with a conditional `{% if courses %}` to handle students with no enrollments

**SQL used:**
```sql
SELECT c.CourseNo, c.CrsDesc, c.CrsUnits,
       o.OffTerm, o.OffYear, e.EnrGrade
FROM   Registration r
JOIN   Enrollment   e ON r.RegNo    = e.RegNo
JOIN   Offering     o ON e.OfferNo  = o.OfferNo
JOIN   Course       c ON o.CourseNo = c.CourseNo
WHERE  r.StdNo = %s
ORDER BY o.OffYear, o.OffTerm, c.CourseNo
```

**Checkpoint:**
- [ ] Clicking "View Courses" for a student who has enrollments shows their courses and grades
- [ ] Clicking "View Courses" for a student with no enrollments shows the "No enrollments" message
- [ ] "Back to Students" link works correctly
- [ ] Only that student's courses appear — no cross-contamination between students

**Key concept:** A single `WHERE r.StdNo = %s` clause filters the entire JOIN to only rows belonging to the selected student. This is the fundamental pattern for master-detail navigation in relational web apps.
