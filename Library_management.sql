/*table for books*/

CREATE TABLE Book (
    BookID INT PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    TotalCopies INT
);

 /*table for Members*/

CREATE TABLE Members (
    MemberID INT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    JoinDate DATE
);


/* table for Borrow */

CREATE TABLE Borrow (
    BorrowID INT PRIMARY KEY,
    BookID INT,
    MemberID INT,
    BorrowDate DATE,
    ReturnDate DATE,
    FOREIGN KEY (BookID) REFERENCES Book(BookID),
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
);


-- Books
INSERT INTO Book (BookID , Title ,Author ,Genre ,TotalCopies)
VALUES (1, 'Harry Potter', 'J.K. Rowling', 'Fantasy', 5),
        (2, 'Rich Dad Poor Dad', 'Robert Kiyosaki', 'Finance', 3),
        (3, 'The Alchemist', 'Paulo Coelho', 'Fiction', 4);

insert into book 
values (4, 'Atomic Habits', 'James Clear', 'Self-help', 3),
        (5, 'Think and Grow Rich', 'Napoleon Hill', 'Motivation', 4),
        (6, 'Wings of Fire', 'A.P.J. Abdul Kalam', 'Biography', 2),
        (7, 'Sapiens', 'Yuval Noah Harari', 'History', 3),
        (8, 'Clean Code', 'Robert C. Martin', 'Programming', 5),
        (9, 'Deep Work', 'Cal Newport', 'Productivity', 3),
        (10, 'The Psychology of Money', 'Morgan Housel', 'Finance', 3),
        (11, 'Ikigai', 'Francesc Miralles', 'Lifestyle', 4);

-- Members
INSERT INTO Members(MemberID , Name ,Email ,JoinDate )
VALUES 
(101, 'Aditi Sharma', 'aditi@gmail.com', '2024-01-10'),
(102, 'Rohan Mehta', 'rohan@gmail.com', '2024-02-05');

INSERT INTO Members VALUES
(103, 'Sneha Verma', 'sneha@gmail.com', '2024-03-01'),
(104, 'Kunal Singh', 'kunal@gmail.com', '2024-04-05'),
(105, 'Meera Joshi', 'meera@gmail.com', '2024-04-20'),
(106, 'Nikhil Rao', 'nikhil@gmail.com', '2024-05-10'),
(107, 'Tanya Kapoor', 'tanya@gmail.com', '2024-05-18'),
(108, 'Ishaan Desai', 'ishaan@gmail.com', '2024-05-22'),
(109, 'Pooja Jain', 'pooja@gmail.com', '2024-06-01'),
(110, 'Ankit Roy', 'ankit@gmail.com', '2024-06-05');

-- Borrow
INSERT INTO Borrow(BorrowID , BookID ,MemberID ,BorrowDate ,ReturnDate ) 
VALUES 
(1, 1, 101, '2024-05-01', '2024-05-15'),
(2, 2, 101, '2024-06-01', NULL), -- Not yet returned
(3, 3, 102, '2024-06-10', NULL);

insert into Borrow values
(1002, 2, 101, '2024-05-20', NULL),
(1003, 3, 102, '2024-06-01', '2024-06-10'),
(1004, 1, 103, '2024-06-05', NULL),
(1005, 4, 104, '2024-06-10', NULL),
(1006, 5, 104, '2024-06-15', NULL),
(1007, 6, 105, '2024-06-18', NULL),
(1008, 7, 106, '2024-06-20', NULL),
(1009, 8, 107, '2024-06-20', NULL),
(1010, 9, 108, '2024-06-21', NULL),
(1011, 10, 109, '2024-06-21', NULL),
(1012, 1, 110, '2024-06-21', NULL),
(1013, 3, 101, '2024-06-10', NULL),
(1014, 2, 102, '2024-06-11', NULL),
(1015, 5, 103, '2024-06-12', NULL),
(1016, 6, 104, '2024-06-13', NULL),
(1017, 7, 105, '2024-06-14', NULL),
(1018, 9, 106, '2024-06-15', NULL),
(1019, 4, 107, '2024-06-16', NULL),
(1020, 2, 108, '2024-06-17', NULL),
(1021, 10, 109, '2024-06-18', NULL),
(1022, 8, 110, '2024-06-19', NULL),
(1023, 9, 101, '2024-06-20', NULL),
(1024, 3, 102, '2024-06-20', NULL),
(1025, 6, 103, '2024-06-20', NULL);

select * from Book; --print data 

select *from Members -- print data 

select * from Borrow -- print data 

--List all books with their authors and genres

SELECT Title, Author, Genre FROM Book;

 -- Show all borrow history with member and book names

SELECT B.BorrowID, M.Name AS Member, BK.Title AS Book, B.BorrowDate, B.ReturnDate
FROM Borrow B
JOIN Members M ON B.MemberID = M.MemberID
JOIN Book BK ON B.BookID = BK.BookID;

-- Find currently borrowed books (not returned yet)

SELECT BK.Title, M.Name AS BorrowedBy
FROM Borrow B
JOIN Book BK ON B.BookID = BK.BookID
JOIN Members M ON B.MemberID = M.MemberID
WHERE B.ReturnDate IS NULL;

-- Count how many times each book was borrowed

SELECT BK.Title, COUNT(*) AS TimesBorrowed
FROM Borrow B
JOIN Book BK ON B.BookID = BK.BookID
GROUP BY BK.Title;

-- Find top active members (most books borrowed)

SELECT M.Name, COUNT(*) AS TotalBorrowed
FROM Borrow B
JOIN Members M ON B.MemberID = M.MemberID
GROUP BY M.Name 
ORDER BY TotalBorrowed DESC;
