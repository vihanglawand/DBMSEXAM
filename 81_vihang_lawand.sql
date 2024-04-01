# 1)
create table students(student_id int primary key,name varchar(50) unique,age int not null);

# 2)
insert into students(student_id,name,age) values(1,'Abhishek',24),(2,'Omkar',23),(3,'Gaurav',25);
select * from students;

# 3) 
select department_id,count(*) from employees where FIRST_NAME like "%d" group by DEPARTMENT_ID;

# 4)
select * from
(select first_name,DEPARTMENT_ID,rank() over(partition by department_id order by salary ) rank_on_salary from employees) s
where rank_on_salary <4;

# 5)
select e.FIRST_NAME,e.LAST_NAME,e.SALARY,s.* from employees e join
(select avg(salary) as average_sal,DEPARTMENT_ID from employees group by DEPARTMENT_ID) s
on e.department_id=s.DEPARTMENT_ID where salary>average_sal;
;

# 6)
select location_id ,count(*)from
(select e.first_name,d.LOCATION_ID from employees e join
departments d on e.department_id=d.DEPARTMENT_ID
where timestampdiff(year,hire_date,now())>5 ) s group by LOCATION_ID;


# 7)
select EMPLOYEE_ID,FIRST_NAME,LAST_NAME,j.JOB_TITLE, rank() over (partition by j.JOB_TITLE order by e.hire_date) as rank_on_jobs
from employees e join jobs j 
on 
e.JOB_ID=j.JOB_ID;

# 8)

delimiter $$
create procedure rankofemp(in emp_id int)
begin
select e.first_name,d.department_name,
 rank() over(order by e.salary desc) rank_based_on_sal
 from employees e join
departments d
on e.DEPARTMENT_ID=d.DEPARTMENT_ID
where employee_id=emp_id;
end
$$ delimiter ;

call rankofemp(200);


                                         --                 OR    question                     -- 
 
# 9)

create table promotion_log (old_job_title varchar(40),new_job_title varchar(40) );

delimiter $$
create trigger afterjob
after update on jobs 
for each row 
begin
insert into promotion_log values(old.job_title,new.job_title);
end
$$ delimiter ;
update jobs set job_title='student' where  job_title= 'President';

select * from promotion_log;

#############################################################################################################################################################
# MongoDB

-- 1)
--  query ::             db.restaurants.find({borough:'Manhattan'});

-- 2)
--  Query ::             db.restaurants.find().sort({name:1});

-- 3)
--  Query ::             db.restaurants.find({grades:{$ne:0},'grades.grade':'A'});