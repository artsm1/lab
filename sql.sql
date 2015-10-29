exercise 1

create database college;
 
create table student(
student_id integer not null primary key,
name varchar(10) not null,
year smallint not null default 1,
dept_no integer not null,
major varchar(20)
);

create table department(
dept_no integer primary key auto_increment,
dept_name varchar(20) unique,
office varchar(20),
office_tel varchar(13) not null
);
 
alter table student change column major major varchar(40);
alter table student add gender varchar(5) not null;
alter table department change column dept_name dept_name varchar(40);
alter table department change column office office varchar(30);
 

exercise 2

alter table student drop gender;
 
insert into student values (20070002,'James Bond',3,4,'Business Administration'),
(20060001, 'Queenie', 4, 4, 'Business Administration'),
(20030001,'Reonardo', 4, 2, 'Electronic Engineering'),
(20040003,'Julia',3,2,'Electronic Engineering'),
(20060002, 'Roosevelt', 3, 1, 'Computer Science'),
(20100002, 'Fearne', 3, 4, 'Business Administration'),
(20110001, 'Chloe', 2, 1, 'Computer Science'),
(20080003, 'Amy', 4, 3, 'Law'),
(20040002, 'Selina', 4, 5, 'English Literature'),
(20070001, 'Ellen', 4, 4, 'Business Administration'),
(20100001, 'Kathy', 3, 4, 'Business Administration'),
(20110002, 'Lucy', 2, 2, 'Electronic Engineering'),
(20030002, 'Michelle', 5, 1, 'Computer Science'),
(20070003, 'April', 4, 3, 'Law'),
(20070005, 'Alicia', 2, 5, 'English Literature'),
(20100003, 'Yullia', 3, 1, 'Computer Science'),
(20070007, 'Ashlee', 2, 4, 'Business Administration');
  
INSERT INTO department(dept_name, office, office_tel) values('Computer Science', 'Engineering building', '02-3290-0123');
INSERT INTO department(dept_name, office, office_tel) values('Electronic Engineering', 'Engineering building', '02-3290-2345');
INSERT INTO department(dept_name, office, office_tel) values('Law', 'Law building', '02-3290-7896');
INSERT INTO department(dept_name, office, office_tel) values( 'Business Administration', 'Administration building', '02-3290-1112');
INSERT INTO department(dept_name, office, office_tel) values ('English Literature', 'Literature building', '02-3290-4412');
 
 
 
exercise 3
 
1)
 
UPDATE department SET dept_name = 'Electronic and Electrical Engineering'
WHERE dept_name = 'Electronic engineering';
 
 
2)
 
insert into department (dept_name, office, office_tel) values('Education', 'Education Building', '02-3290-2347'); 
 
 
3)
update student set major = 'Education' where name = 'Chloe';
 
 
4)
 
delete from student where name = 'Michelle';
 
5)
delete from student where name = 'Fearne';
 
 
exercise 4

1)
select name from student where major='Computer Science';
 
2)
select student_id,year,major from student;
 
3)
select name from student where year=3;
 
4)
select name from student where year=1 or year=2;
 
5)
select name,dept_no,dept_name from student join department d using(dept_no) where d.dept_name='Business Administration';
 

exercise 5

1)
select name from student where student_id like '2007%';
 
2)
select name from student order by student_id asc;
 
3)
select major from student group by major having avg(year)>3;
 
4)
select name from student where student_id like '2007%' limit 2;
 
 
exercise 6

1)
	SELECT r.role role FROM roles r JOIN movies m ON r.movie_id = m.id WHERE m.name = 'Pi';

2) 
	SELECT a.first_name, a.last_name, r.role role FROM actors a JOIN roles r ON r.actor_id = a.id
	JOIN movies m ON r.movie_id = m.id WHERE m.name = 'Pi';

3. 
	SELECT a.first_name, a.last_name FROM actors a JOIN roles r1 ON r1.actor_id = a.id
	JOIN roles r2 ON r2.actor_id = a.id JOIN movies m1 ON m1.id = r1.movie_id JOIN movies m2 ON m2.id = r2.movie_id
	WHERE m1.name = 'Kill Bill: Vol. 1' AND m2.name = 'Kill Bill: Vol. 2';

4. 
	SELECT a.first_name, a.last_name, count(a.id) howmany FROM actors a
	JOIN roles r ON a.id=r.actor_id GROUP BY a.id ORDER BY count(a.id) DESC LIMIT 7;

5.
	SELECT mg.genre genre, count(mg.genre) howmany FROM movies_genres mg
	GROUP BY mg.genre ORDER BY count(mg.genre) DESC LIMIT 3;

6.
	SELECT d.first_name, d.last_name, count(d.id) howmany FROM directors d
	JOIN movies_directors md ON d.id=md.director_id JOIN movies_genres mg ON md.movie_id=mg.movie_id
	WHERE mg.genre = "Thriller" GROUP BY d.id ORDER BY count(d.id) DESC LIMIT 1;


exercise 7

1. search all roles grades given in the course Computer Science 143 (4 rows)
	SELECT g.grade grade
	FROM grades g
	JOIN courses c ON course_id=c.id
	WHERE c.name = 'Computer Science 143';

2. search names and grades of all students who took Computer Science 143 and got a B- or better (2 rows)
	SELECT s.name name, g.grade grade
	FROM grades g
	JOIN students s ON g.student_id = s.id
	JOIN courses c ON g.course_id = c.id
	WHERE c.name = 'Computer Science 143' AND g.grade <= 'B-';

3. search names of all students who got a B- or better in any course, along with the names of the course and the grades (5 rows)
	SELECT s.name student, c.name course, g.grade grade
	FROM grades g
	JOIN students s ON g.student_id = s.id
	JOIN courses c ON g.course_id = c.id
	WHERE g.grade <= 'B-';

4. search names of all courses that have been taken by 2 or more students (2 rows)
	SELECT c.name course, count(*) howmany
	FROM grades g
	JOIN students s ON g.student_id = s.id
	JOIN courses c ON g.course_id = c.id
	GROUP BY c.name
	HAVING count(*) >= 2;



exercise 8

1. receives a DB name and an SQL query from user inputs through form
	
2. connects to the specified DB
	
3. queries data with the given SQL query (can use queries constructed from previous exercises)
	
4. displays each row of the query results in unordered list



extra

1)
select name from movies where year > 1995;
2)
select count(*) from movies m join roles r on r.movie_id=m.id where name='Lost in Translation'
3)
select a.first_name,a.last_name from movies m join roles r on r.movie_id=m.id join actors a on a.id=r.actor_id  where name='Lost in Translation';
4)
select d.first_name,d.last_name from directors d join movies_directors md on d.id=md.director_id join movies m on m.id=md.movie_id where m.name='Fight Club'
5)
select count(*) from directors d join movies_directors md on d.id=md.director_id join movies m on m.id=md.movie_id where d.first_name='Clint' and d.last_name='Eastwood';
6)
select d.first_name,d.last_name from directors d join movies_directors md on d.id=md.director_id join movies_genres mg on mg.movie_id = md.movie_id where mg.genre='horror' group by md.director_id having count(md.director_id)>=1; 
7)
select distinct a.first_name,a.last_name from directors d join movies_directors md on d.id=md.director_id natural join roles r join actors a on a.id=r.actor_id where d.first_name='Christopher' and d.last_name='Nolan';
