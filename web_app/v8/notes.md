**Goal:** Allow the user to modify student data and persist changes to the database.

**What's new:**
- `method="POST"` and `action="/students/save"` on the `<form>` tag
- A hidden `<input type="hidden" name="std_no">` carries the primary key
- New route `@app.route('/students/save', methods=['POST'])`
- `from flask import request` — access to form data
- `request.form['field_name']` — reads submitted form values
- `UPDATE` SQL with parameterized values
- `conn.commit()` — **required** to persist DML changes

**SQL used:**
```sql
UPDATE Student
SET StdFirstName = %s, StdLastName = %s, StdCity = %s, StdState = %s,
    StdZip = %s, StdMajor = %s, StdClass = %s, StdGPA = %s
WHERE StdNo = %s
```

**Checkpoint:**
- [ ] Changing a student's city and clicking Save updates the database
- [ ] Refreshing the students list shows the updated value
- [ ] Omitting `conn.commit()` means the change is rolled back — demonstrate this!
- [ ] The primary key (`StdNo`) cannot be changed via the form

**Key concept:** HTML forms use `method="POST"` to send data in the request body (not the URL). Flask's `request.form` dictionary maps input `name` attributes to submitted values. Always use parameterized queries (`%s`) — never f-strings or string concatenation — to prevent SQL injection.
