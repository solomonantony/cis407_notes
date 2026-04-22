CREATE OR REPLACE PROCEDURE add_student(
    p_stdno       CHAR,
    p_firstname   VARCHAR,
    p_lastname    VARCHAR,
    p_city        VARCHAR,
    p_state       CHAR,
    p_zip         CHAR,
    p_class       CHAR
)
LANGUAGE plpgsql AS $$
BEGIN
    INSERT INTO Student(StdNo, StdFirstName, StdLastName,
                        StdCity, StdState, StdZip, StdClass)
    VALUES (p_stdno, p_firstname, p_lastname,
            p_city, p_state, p_zip, p_class);

    RAISE NOTICE 'Student % % added successfully.',
                 p_firstname, p_lastname;
END;
$$;
CALL add_student('656-66-6666','Anna','Rivera','Tacoma','WA','98401-2233','SO');
SELECT * FROM Student WHERE StdNo = '656-66-6666';
