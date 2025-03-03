--student - ID,name(1,2,3)
 
--mark - id,studentID,Subject,mark
 
--1,1,'English',90
--2,2,'English',80

-- Creating the 'student' table with columns 'StudentID' (unique student identifier) and 'name' (student's name, cannot be NULL)
Create table student(
  StudentID int,
  name varchar(250) not null
);

-- Inserting sample data into the 'student' table
insert into student 
values
(201,'Jocky'),
(202,'Rocky'),
(203,'Ram'),
(204,'Rama'),
(205,'Esha'),
(206,'Bhoomi'),
(207,'Joker'),
(208,'Diksha'),
(210,'Naveen');

-- Creating the 'Marks' table with a primary key 'ID', 'StudentID' (foreign key reference to 'student' table), 'subject', and 'marks' columns
Create table Marks(
  ID int primary key,
  StudentID int,
  subject varchar(50),
  marks int
);

-- Inserting sample data into the 'Marks' table
insert into Marks 
values
(1,201,'English',80),
(2,202,'Hindi',60),
(3,203,'English',85),
(4,204,'Hindi',90),
(5,205,'English',80),
(6,207,'Sanskrit',80),
(7,208,'Hindi',80),
(8,206,'English',80),
(9,205,'Sanskrit',80);

-- Updating the 'Marks' table: Setting 'subject' to NULL for the student with StudentID 208
update Marks
set [subject]=null
where StudentID=208;

-- Selecting students who have not taken English OR have no records in the 'Marks' table
select s.name
       from student s left join Marks m
on s.StudentID = m.StudentID
where m.subject!='English'or m.ID is null;

-- Selecting students who have taken subjects other than English
select s.name
from student s  join Marks m
on s.StudentID = m.StudentID
where m.subject!='English';

-- Selecting students whose subjects are NULL in the 'Marks' table
select s.name
from student s join Marks m
on s.StudentID = m.StudentID
where m.subject is null;

-- Selecting students who scored more than 80 marks
select s.name
from student s join Marks m
on s.StudentID = m.StudentID
where m.marks > 80;

-- Selecting students who have taken either 'Hindi' or 'Sanskrit' as subjects
select s.name
from student s join Marks m
on s.StudentID = m.StudentID
where m.subject in ('Hindi', 'Sanskrit');

-- Selecting students whose names start with 'R'
select s.name
from student s 
where s.name like 'R%';

-- Selecting students whose names end with 'a'
select s.name
from student s 
where s.name like '%a';

-- Selecting students whose names contain 'oo'
select s.name
from student s 
where s.name like '%oo%';

-- Selecting students who scored between 60 and 85 marks
select s.name
from student s join Marks m
on s.StudentID = m.StudentID
where m.marks between 60 and 85;

-- Selecting all records from the 'student' table
SELECT *FROM student;

-- Selecting all records from the 'Marks' table
SELECT *FROM Marks;
