**Goal:** Follow the Post/Redirect/Get (PRG) pattern to prevent duplicate form submissions.

**What's new:**
- `from flask import redirect, url_for`
- `return redirect(url_for('students'))` replaces the plain-text return
- `url_for('students')` generates the URL for the `students` view function by name

**Why this matters:** Without a redirect, the browser's last request was a POST. If the user refreshes, the browser will ask "Resend form data?" and re-submit the update. With PRG, after saving the browser is redirected to a GET request, so refreshing simply reloads the student list safely.

**Checkpoint:**
- [ ] After clicking Save, the browser URL changes to `/students` (not `/students/save`)
- [ ] Refreshing the student list does NOT trigger a "Resend form data?" browser prompt
- [ ] The updated data is visible immediately in the list

**Key concept:** `url_for()` is preferred over hard-coded strings like `'/students'` because it automatically updates if you ever rename the route.
