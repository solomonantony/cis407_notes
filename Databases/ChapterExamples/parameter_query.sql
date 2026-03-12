Select * from student where stdmajor='FIN' and stdgpa = 
(select max(stdgpa) from student where stdmajor=$1)

