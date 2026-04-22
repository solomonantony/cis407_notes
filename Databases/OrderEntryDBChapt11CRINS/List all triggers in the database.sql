-- List all triggers in the database with their table and event
SELECT
    trigger_name,
    event_object_table   AS on_table,
    event_manipulation   AS event,
    action_timing        AS timing,
    action_orientation   AS level
FROM   information_schema.triggers
ORDER  BY event_object_table, trigger_name;

-- List triggers on a specific table only:
SELECT trigger_name, event_manipulation, action_timing
FROM   information_schema.triggers
WHERE  event_object_table = 'student';

-- Disable a single trigger (keeps the definition, stops it from firing)
ALTER TABLE Student DISABLE TRIGGER trg_normalize_student;
-- Re-enable it:
ALTER TABLE Student ENABLE TRIGGER trg_normalize_student;

-- Disable ALL triggers on a table (useful for bulk loads):
ALTER TABLE Enrollment DISABLE TRIGGER ALL;
ALTER TABLE Enrollment ENABLE  TRIGGER ALL;
