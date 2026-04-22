**Goal:** Add an "Edit" link per row that opens a pre-populated edit form.

**What's new:**
- A new route `/students/edit/<std_no>` with a **URL parameter** (`<std_no>`)
- The parameter is passed automatically as a function argument: `def edit_student(std_no)`
- `%s` placeholder in SQL — psycopg2 parameterized query prevents SQL injection
- `cur.fetchone()` — retrieves a single row
- `edit_student.html` displays the student's data in form `<input>` fields
- `readonly` attribute on the primary-key field to prevent editing it

**Checkpoint:**
- [ ] Each row in the student list has an "Edit" link
- [ ] Clicking the link opens the edit form pre-filled with that student's data
- [ ] Clicking a different student's Edit link loads different data
- [ ] The Student No field cannot be edited (readonly)

**Key concept:** URL parameters let you pass a record identifier through the URL. Flask captures `<std_no>` from the path and passes it as a Python string to the function.
