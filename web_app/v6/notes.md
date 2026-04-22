**Goal:** Query the `Student` table and render the results in an HTML table.

**What's new:**
- `cur.execute(SQL)` — runs a SELECT query
- `cur.fetchall()` — returns all rows as a list of tuples
- Passing `students=rows` to `render_template()` — sends data to the template
- Jinja2 `{% for s in students %}` loop and `{{ s[0] }}` variable syntax in the template

**SQL used:**
```sql
SELECT StdNo, StdFirstName, StdLastName, StdCity, StdState, StdMajor, StdClass, StdGPA
FROM Student
ORDER BY StdLastName, StdFirstName
```

**Checkpoint:**
- [ ] The student list page shows all rows from the database
- [ ] Column order in the HTML matches the SELECT column order
- [ ] Adding a student directly in psql and refreshing the page shows the new row

**Key concept:** `render_template()` accepts keyword arguments that become variables inside the template. Jinja2 uses `{{ variable }}` for output and `{% tag %}` for logic.

