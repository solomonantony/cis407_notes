create or replace function trg_fn_check_available()
returns TRIGGER LANGUAGE plpgsql AS $$
declare 
  is_available boolean := False;
BEGIN
   select offnumenrolled > offlimit into is_available 
   from offering where offering.offerno = new.offerno;
   if is_available THEN
     raise Exception 'Not available';
    end if;
    return new;
end;
$$;
CREATE or replace TRIGGER trg_check_available
    before INSERT ON Enrollment
    FOR EACH ROW
    EXECUTE FUNCTION trg_fn_check_available();

select o.offerno, o.offlimit, o.offnumenrolled from offering o where o.offerno = 5679;

drop trigger trg_block_overenrolment;

insert into enrollment(regno, offerno, enrgrade) values(1256,5679, Null);

DROP trigger trg_block_overenrolment on Enrollment;