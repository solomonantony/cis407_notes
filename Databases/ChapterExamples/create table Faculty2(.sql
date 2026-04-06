create table Faculty2(
FacNo			char(11) not null,
FacFirstName		varchar(10) not null,
FacLastName		varchar(10) not null,
FacRank			char(4),
FacHireDate		date,
FacSalary		decimal(10,2),
FacSupervisor		char(11),
CONSTRAINT Faculty2PK PRIMARY KEY (FacNo), 
CONSTRAINT Supervisor2FK FOREIGN KEY (FacSupervisor) REFERENCES Faculty2 );

INSERT INTO faculty2
	(FacNo, FacFirstName, FacLastName, FacRank, FacSalary, FacSupervisor, FacHireDate)
	 VALUES ('543-21-0987','VICTORIA','EMMANUEL','PROF',120000.0,NULL,'15-Apr-2009');

INSERT INTO faculty2
	(FacNo, FacFirstName, FacLastName, FacRank, FacSalary, FacSupervisor, FacHireDate)
	 VALUES ('765-43-2109','NICKI','MACON','ASSC',105000.00,NULL,'11-Apr-2010');

INSERT INTO faculty2
	(FacNo, FacFirstName, FacLastName, FacRank, FacSalary, FacSupervisor, FacHireDate)
	 VALUES ('654-32-1098','LEONARD','FIBON','ASSC',70000.00,'543-21-0987','01-May-2007');

INSERT INTO faculty2
	(FacNo, FacFirstName, FacLastName, FacRank, FacSalary, FacSupervisor, FacHireDate)
	 VALUES ('098-76-5432','LEONARD','VINCE','ASST',55000.00,'654-32-1098','10-Apr-2008');

INSERT INTO faculty2
	(FacNo, FacFirstName, FacLastName, FacRank, FacSalary, FacSupervisor, FacHireDate)
	 VALUES ('876-54-3210','CRISTOPHER','COLAN','ASST',90000.00,'654-32-1098','01-Mar-2012');

INSERT INTO faculty2
	(FacNo, FacFirstName, FacLastName, FacRank, FacSalary, FacSupervisor, FacHireDate)
	 VALUES ('987-65-4321','JULIA','MILLS','ASSC',95000.00,'765-43-2109','15-Mar-2013');

INSERT INTO faculty2
	(FacNo, FacFirstName, FacLastName, FacRank, FacSalary, FacSupervisor, FacHireDate)
	 VALUES ('111-22-3333','JOHN','MILLSON','PROF',110000.00,'543-21-0987','01-May-2013');

INSERT INTO faculty2
	(FacNo, FacFirstName, FacLastName, FacRank, FacSalary, FacSupervisor, FacHireDate)
	 VALUES ('333-22-4444','SALLY','SCOTT','ASST',90000.00,'111-22-3333','01-May-2014');

INSERT INTO faculty2
	(FacNo, FacFirstName, FacLastName, FacRank, FacSalary, FacSupervisor, FacHireDate)
	 VALUES ('555-66-7777','SUSAN','JONES','ASSC',125000.00,'111-22-3333','01-May-2015');

INSERT INTO faculty2
	(FacNo, FacFirstName, FacLastName, FacRank, FacSalary, FacSupervisor, FacHireDate)
	 VALUES ('777-11-4321','AIMEE','MANNING','ASST',85000.00,'765-43-2109','15-Mar-2014');

INSERT INTO faculty2
	(FacNo, FacFirstName, FacLastName, FacRank, FacSalary, FacSupervisor, FacHireDate)
	 VALUES ('888-33-1111','JAMES','BLOKE','ASST',85000.00,'987-65-4321','15-Apr-2016');

INSERT INTO faculty2
	(FacNo, FacFirstName, FacLastName, FacRank, FacSalary, FacSupervisor, FacHireDate)
	 VALUES ('789-12-3210','JAIME','SANCHEZ','PROF',107000.00,'987-65-4321','10-May-2017');


SELECT e.FacNo, e.FacLastName AS Employee, e.FacRank AS EmpRank,s.FacLastName  AS Supervisor,s.FacRank                                 AS SupRank
FROM   Faculty e JOIN Faculty s ON e.FacSupervisor = s.FacNo
ORDER BY s.FacLastName, e.FacLastName;

WITH RECURSIVE SupervisionChain AS (
    -- Anchor member: the starting point (top of the chain)
    SELECT FacNo,FacFirstName, FacLastName,FacRank, FacSupervisor,0 AS Depth                          -- root is at depth 0
    FROM   Faculty
    WHERE  FacNo = '543-21-0987'            -- start with Victoria Emmanuel
    UNION 
    -- Recursive member: join the CTE back to the base table
    SELECT f.FacNo,f.FacFirstName, f.FacLastName,f.FacRank,f.FacSupervisor,sc.Depth + 1                        -- each hop increases depth
    FROM   Faculty f JOIN SupervisionChain sc ON f.FacSupervisor = sc.FacNo
)
SELECT Depth, FacLastName AS Name, FacRank,FacNo
FROM   SupervisionChain
ORDER BY Depth, FacLastName;

