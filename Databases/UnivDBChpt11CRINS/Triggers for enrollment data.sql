CREATE OR REPLACE FUNCTION trg_fn_block_overenrolment()
RETURNS TRIGGER LANGUAGE plpgsql AS $$
DECLARE
    v_limit    INTEGER;
    v_enrolled INTEGER;
BEGIN
    SELECT OffLimit, OffNumEnrolled
    INTO   v_limit, v_enrolled
    FROM   Offering
    WHERE  OfferNo = NEW.OfferNo;

    IF v_enrolled >= v_limit THEN
        RAISE EXCEPTION
            'Enrolment refused: Offering % is full (% / % seats taken).',
            NEW.OfferNo, v_enrolled, v_limit;
    END IF;
    RETURN NEW;   -- seats available — allow the insert
END;
$$;

CREATE or replace TRIGGER trg_block_overenrolment
    BEFORE INSERT ON Enrollment
    FOR EACH ROW
    EXECUTE FUNCTION trg_fn_block_overenrolment();
-- see what 
    select o.offerno, o.offlimit, o.offnumenrolled
    from offering o 
    where o.offerno = 5679;

insert into enrollment(regno, offerno, enrgrade) values(1254,5679, Null);
delete from enrollment where regno=1254 and offerno=5679;

-- Insert operation to increment offnumenrolled
-- Create a trigger function to increment offernumenrolled
CREATE OR REPLACE function trg_fn_increment_enrolled()
returns TRIGGER LANGUAGE plpgsql AS $$
BEGIN
   UPDATE Offering set offnumenrolled = offnumenrolled+1;
   RETURN NEW;
end;
$$;
-- assign the function  as the INSERT AFTER trigger
CREATE OR REPLACE TRIGGER trg_increment_enrolled
  AFTER INSERT ON Enrollment
  FOR EACH ROW
  EXECUTE FUNCTION trg_fn_increment_enrolled();

-- test it 
insert into enrollment(regno, offerno, enrgrade) values(1256,5679, Null);
delete from enrollment where regno=1254 and offerno=5679;
select o.offerno, o.offlimit, o.offnumenrolled from offering o where o.offerno = 5679;
   

-- Delete operation to decrement offnumenrolled
