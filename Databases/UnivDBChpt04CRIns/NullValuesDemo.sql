CREATE TABLE Club (
ClubNo		char(6) not null,
CName		varchar(10) not null,
CPurpose	varchar(10) not null,
CBudget		DECIMAL(10,2),
CActual		DECIMAL(10,2),
CONSTRAINT ClubPk PRIMARY KEY (ClubNo) );

INSERT INTO club
	(ClubNo, CName, CPurpose, CBudget, CActual )
	VALUES('C1','DELTA','SOCIAL',1000.00,1200.00);

INSERT INTO club
	(ClubNo, CName, CPurpose, CBudget, CActual )
	VALUES('C2','BITS','ACADEMIC',500.00,350.00);

INSERT INTO club
	(ClubNo, CName, CPurpose, CBudget, CActual )
	VALUES('C3','HELPS','SERVICE',300.00,330.00);

INSERT INTO club
	(ClubNo, CName, CPurpose, CBudget, CActual )
	VALUES('C4','SIGMA','SOCIAL',NULL,150.00);

select * from club;

-- 10.21
SELECT * 
 FROM Club
 WHERE CBudget > 200;

-- 10.22
SELECT * 
 FROM Club
 WHERE CBudget > CActual;

-- 10.23
SELECT * 
 FROM Club
 WHERE CBudget <= CActual;

-- 10.31
SELECT COUNT(*) AS NumRows, 
       COUNT(CBudget) AS NumBudgets 
 FROM Club;
select * from club;
SELECT SUM(CBudget) AS SumBudget, 
       SUM(CActual) AS SumActual, 
       SUM(CBudget)-SUM(CActual) AS SumDifference,
       SUM(CBudget-CActual) AS SumOfDifferences
 FROM Club;
