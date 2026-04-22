CREATE OR REPLACE PROCEDURE update_gpa(p_stdno CHAR, p_newgpa DECIMAL)
LANGUAGE plpgsql AS $$
DECLARE
    v_rows INTEGER;
BEGIN
    UPDATE Student
    SET    StdGPA = p_newgpa
    WHERE  StdNo  = p_stdno;
    GET DIAGNOSTICS v_rows = ROW_COUNT;
    IF v_rows = 0 THEN
        RAISE EXCEPTION 'Student % not found.', p_stdno;
    ELSE
        RAISE NOTICE 'GPA updated for student %.', p_stdno;
    END IF;
END;
$$;

CALL update_gpa('656-66-6666', 3.10);
SELECT StdNo, StdGPA FROM Student WHERE StdNo = '656-66-6666';
