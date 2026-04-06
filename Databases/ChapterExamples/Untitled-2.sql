// list faculty last name, department, and salary, in each department whose salary is less than the depatment average
SELECT  f.FacLastName  AS FacultyName, f.FacDept, f.FacSalary
FROM    Faculty f
WHERE   f.FacSalary < (
            SELECT  AVG(f2.FacSalary) FROM    Faculty f2 WHERE   f2.FacDept = f.FacDept
        )
ORDER BY f.FacDept, f.FacSalary;

WITH DeptAvgSalary AS 
(SELECT  FacDept, AVG(FacSalary) AS AvgSalary FROM Faculty GROUP BY FacDept)
SELECT  f.FacLastName  AS FacultyName, f.FacDept, f.FacSalary, ROUND(d.AvgSalary, 2) AS DeptAvgSalary
FROM Faculty f JOIN DeptAvgSalary d ON f.FacDept = d.FacDept
WHERE   f.FacSalary < d.AvgSalary  ORDER BY f.FacDept, f.FacSalary;

select * from faculty;

WITH RECURSIVE SupervisionChain AS (
    SELECT FacNo, FacLastName,FacRank, FacSupervisor, 0 AS Depth
    FROM   Faculty WHERE  FacNo = '543-21-0987'
    UNION ALL
    SELECT f.FacNo, f.FacLastName,f.FacRank, f.FacSupervisor,sc.Depth + 1
    FROM Faculty f JOIN SupervisionChain sc ON f.FacSupervisor = sc.FacNo
)
SELECT
    Depth, FacLastName AS Name, FacRank,FacNo
FROM   SupervisionChain
ORDER BY Depth, FacLastName;


