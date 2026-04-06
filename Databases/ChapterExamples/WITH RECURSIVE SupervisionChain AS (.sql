WITH RECURSIVE SupervisionChain AS (
    SELECT FacNo, FacLastName,FacRank, FacSupervisor, 0 AS Depth
    FROM   Faculty WHERE  FacNo = '543-21-0987'
    UNION
    SELECT f.FacNo, f.FacLastName,f.FacRank, f.FacSupervisor,sc.Depth + 1
    FROM Faculty f JOIN SupervisionChain sc ON f.FacSupervisor = sc.FacNo
)
SELECT
    Depth, FacLastName AS Name, FacRank,FacNo
FROM   SupervisionChain
ORDER BY Depth, FacLastName;


