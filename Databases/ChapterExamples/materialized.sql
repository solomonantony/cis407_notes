drop materialized view mv_ms_faculty;

create materialized view mv_ms_faculty as 
select * from Faculty where faculty.facdept='MS';

Select * from mv_ms_faculty;

REFRESH MATERIALIZED VIEW mv_ms_faculty;

select * from faculty where faculty.facdept='MS';

update faculty set facfirstname = 'CRIS' where facno = '876-54-3210';

