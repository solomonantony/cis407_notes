CREATE OR REPLACE PROCEDURE enroll_student(p_regno INTEGER, p_offerno INTEGER)
LANGUAGE plpgsql AS $$
DECLARE
    v_limit     INTEGER;
    v_enrolled  INTEGER;
BEGIN
    -- Check offering exists and has space
    SELECT OffLimit, OffNumEnrolled
    INTO   v_limit, v_enrolled
    FROM   Offering
    WHERE  OfferNo = p_offerno;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Offering % does not exist.', p_offerno;
    END IF;

    -- Insert enrollment and update count
    INSERT INTO Enrollment(RegNo, OfferNo)
    VALUES (p_regno, p_offerno);

    RAISE NOTICE 'Enrollment complete: Reg % → Offering %.', p_regno, p_offerno;
END;
$$;

-- Test (student 5 trying to join offering 1001):
CALL enroll_student(1234, 1111);
