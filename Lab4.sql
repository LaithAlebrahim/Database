
Task 1 : The Schema

Student(id,name, native_language)
Course(name, credits)
Specialization(name)
Enrollment( course_id, student_id)
Takes(spec_id, student_id)    

--------------------------------------------------------------------
-- Task 2 : The tables

CREATE TABLE Student (
  id INT PRIMARY KEY NOT NULL,
  name VARCHAR(255),
  native_language VARCHAR(255)
);

CREATE TABLE Course (
  name VARCHAR(255) PRIMARY KEY NOT NULL,
  credits INT
);

CREATE TABLE Specialization (
  name VARCHAR(255) PRIMARY KEY NOT NULL
);

CREATE TABLE Enrollment (
  course_name VARCHAR(255),
  student_id INT,
  PRIMARY KEY (course_name, student_id) NOT NULL,
  FOREIGN KEY (course_name) REFERENCES Course(name),
  FOREIGN KEY (student_id) REFERENCES Student(id)
);

CREATE TABLE Takes (
  spec_name VARCHAR(255),
  student_id INT,
  PRIMARY KEY (spec_name, student_id) NOT NULL,
  FOREIGN KEY (spec_name) REFERENCES Specialization(name),
  FOREIGN KEY (student_id) REFERENCES Student(id)
);


INSERT INTO Student (id,name, native_language) VALUES
(1,'Laith', 'Arabic'),
(2,'Alice', 'Russian'),
(3,'Charlie', 'English'),
(4,'David', 'German'),
(5,'Eve', 'Italian');

INSERT INTO Course (name, credits) VALUES
('Database', 4),
('Operating system', 3),
('ITP', 2),
('Machine learning', 4),
('Math', 1);

INSERT INTO Specialization (name) VALUES
('Robotics'),
('Artificial Intelligence'),
('Computer Networks'),
('Data Science'),
('Software Engineering');


INSERT INTO Enrollment (course_name, student_id) VALUES
('Database', 2),
('Operating system', 1),
('ITP', 3),
('Machine learning', 4),
('Math', 5);


INSERT INTO Takes (spec_name, student_id) VALUES
('Robotics', 2),
('Artificial Intelligence', 1),
('Computer Networks', 3),
('Data Science', 4),
('Software Engineering', 5);


a. Find student names for the first 10 students.
SELECT name 
FROM Student 
LIMIT 10;

Output:

name
Laith
Alice
Charlie
David
Eve
----------------------------------------------------------------------
b. Find students names whose native language is not Russian.
SELECT name 
FROM Student 
WHERE native_language <> 'Russian';

Output:

name
Laith
Charlie
David
Eve
----------------------------------------------------------------------
c. Find student names of students who have specialization in “Robotics”.
SELECT s.name 
FROM Student s 
JOIN Takes t ON s.name = t.student_name 
JOIN Specialization sp ON t.spec_name = sp.name 
WHERE sp.name = 'Robotics';

Output:
name
Alice
----------------------------------------------------------------------
d. Find pair of course names and student names if course credit is less than 3.
SELECT c.name, s.name 
FROM Course c 
JOIN Enrollment e ON c.name = e.course_name 
JOIN Student s ON e.student_id = s.id 
WHERE c.credits < 3;

Output:

name                | name  
ITP                 | Charlie
Math                | Eve
----------------------------------------------------------------------
e. Find all course names where an English native speaker exists.

SELECT DISTINCT c.name 
FROM Course c 
JOIN Enrollment e ON c.name = e.course_name 
JOIN Student s ON e.student_name = s.name 
WHERE s.native_language = 'English';

Output:

name
ITP
