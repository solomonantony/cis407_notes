**Checkpoint:**
- [ ] Visiting `/test-db` shows the PostgreSQL version string
- [ ] Entering wrong credentials produces a readable error message, not a crash
- [ ] The connection is closed after every request (`conn.close()`)

**Key concept:** Always close connections (and cursors) when finished. A common pattern is `try / finally` or a context manager. For this exercise we close manually to keep things explicit.


