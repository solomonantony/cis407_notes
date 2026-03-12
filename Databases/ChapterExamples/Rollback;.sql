Rollback;
CREATE VIEW Fac_View1 AS 
 SELECT FacNo, FacFirstName, FacLastName, FacRank,
        FacSalary, FacDept, FacCity, FacState, FacZipCode
  FROM Faculty
  WHERE FacDept = 'MS';

INSERT INTO Fac_View1 
 (FacNo, FacFirstName, FacLastName, FacRank, FacSalary,
  FacDept, FacCity, FacState, FacZipCode)
 VALUES ('999-99-8888', 'JOE', 'SMITH', 'PROF', 80000,
         'MS', 'SEATTLE', 'WA', '98011-011');

Select * from faculty;

Select * from Fac_View1;

UPDATE Fac_View1 
 SET FacDept = 'FIN'
 WHERE FacNo = '999-99-8888';

CREATE VIEW Fac_View1_Revised AS 
 SELECT FacNo, FacFirstName, FacLastName, FacRank,
        FacSalary, FacDept, FacCity, FacState, FacZipCode
  FROM Faculty
  WHERE FacDept = 'MS'
 WITH CHECK OPTION;

 UPDATE Fac_View1_Revised 
 SET FacDept = 'FIN'
 WHERE FacNo = '999-99-8888';

SELECT * 
 FROM Club
 WHERE  CBudget > CActual is null;

Select * from club;

SELECT * 
 FROM Club
 WHERE CBudget <= CActual  

SELECT FacNo
 FROM Offering
 WHERE OffTerm = 'SUMMER';
rollback;

WITH RECURSIVE faculty_hierarchy AS ( -- Anchor: top supervisor in each department SELECT facno, facfirstname, facdept, facsupervisor, facfirstname AS supervisor_name, 1 AS level FROM faculty WHERE facsupervisor IS NULL

UNION ALL

-- Recursive part: find subordinates
SELECT
    f.facno,
    f.facfirstname,
    f.facdept,
    f.facsupervisor,
    fh.supervisor_name,
    fh.level + 1
FROM faculty f
JOIN faculty_hierarchy fh
    ON f.facsupervisor = fh.facno
)
Rollback;
WITH RECURSIVE faculty_hierarchy AS 
( -- Anchor: top supervisor in each department 
  SELECT facno, facfirstname, facdept, facsupervisor, 
     facfirstname AS supervisor_name, 1 AS level FROM faculty 
     WHERE facsupervisor IS NULL
     UNION ALL
-- Recursive part: find subordinates
    SELECT
        f.facno,
        f.facfirstname,
        f.facdept,
        f.facsupervisor,
        fh.supervisor_name,
        fh.level + 1
    FROM faculty f
    JOIN faculty_hierarchy fh
        ON f.facsupervisor = fh.facno)
SELECT supervisor_name AS supervisor, facdept, 
       facfirstname AS subordinate, level 
FROM faculty_hierarchy 
WHERE level >= 1 ORDER BY facdept, supervisor, level;

