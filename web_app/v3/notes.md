•	url_for('students')  —  generates the URL for the function named students. Using url_for instead of hard-coding /students means links stay correct if you ever rename a route.
•	Notice both templates repeat the <nav> block. In a real project you would extract this into a base template using Jinja2 extends/block (a natural next refactoring step).

Checkpoint
•	What is the difference between url_for('students') and just writing /students directly in the href?
•	Add a third route /about and link to it from the nav. What is the minimum change needed?
