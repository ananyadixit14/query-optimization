CREATE DATABASE LibraryDB;
USE LibraryDB;
ALTER TABLE Books DROP FOREIGN KEY books_ibfk_1;
-- Drop Tables
DROP TABLE IF EXISTS Borrowers;
DROP TABLE IF EXISTS Books;
DROP TABLE IF EXISTS Authors;
CREATE TABLE Authors (
    AuthorID INT AUTO_INCREMENT,
    Name VARCHAR(100),
    PRIMARY KEY (AuthorID)
);
DROP TABLE IF EXISTS Books;
CREATE TABLE Books (
    BookID INT AUTO_INCREMENT,
    Title VARCHAR(100),
    AuthorID INT,
    PublishedYear INT,
    Genre VARCHAR(50),
    PRIMARY KEY (BookID),
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID)
);
CREATE TABLE Borrowers (
    BorrowerID INT AUTO_INCREMENT,
    Name VARCHAR(100),
    BookID INT,
    BorrowDate DATE,
    PRIMARY KEY (BorrowerID),
    FOREIGN KEY (BookID) REFERENCES Books(BookID)
);
INSERT INTO Authors (Name) VALUES
('J.K. Rowling'),
('J.R.R. Tolkien'),
('George R.R. Martin');
INSERT INTO Books (Title, AuthorID, PublishedYear, Genre) VALUES
('Harry Potter and the Philosopher\'s Stone', 1, 1997, 'Fantasy'),
('The Hobbit', 2, 1937, 'Fantasy'),
('A Game of Thrones', 3, 1996, 'Fantasy');
INSERT INTO Borrowers (Name, BookID, BorrowDate) VALUES
('Alice', 1, '2024-01-10'),
('Bob', 2, '2024-02-15'),
('Charlie', 3, '2024-03-20');
-- Initial Query
SELECT Borrowers.Name, Books.Title, Authors.Name
FROM Borrowers
JOIN Books ON Borrowers.BookID = Books.BookID
JOIN Authors ON Books.AuthorID = Authors.AuthorID;
EXPLAIN SELECT Borrowers.Name, Books.Title, Authors.Name
FROM Borrowers
JOIN Books ON Borrowers.BookID = Books.BookID
JOIN Authors ON Books.AuthorID = Authors.AuthorID;

SET profiling = 1;
SELECT * FROM Borrowers WHERE BorrowDate > '2024-01-01';
SHOW PROFILES;

SHOW PROFILE FOR QUERY 1;

-- Add Indexes
CREATE INDEX idx_authorid ON Books (AuthorID);
CREATE INDEX idx_bookid ON Borrowers (BookID);
-- Optimized Query
SELECT Borrowers.Name, Books.Title, Authors.Name
FROM Borrowers
JOIN Books ON Borrowers.BookID = Books.BookID
JOIN Authors ON Books.AuthorID = Authors.AuthorID;
EXPLAIN SELECT Borrowers.Name, Books.Title, Authors.Name
FROM Borrowers
JOIN Books ON Borrowers.BookID = Books.BookID
JOIN Authors ON Books.AuthorID = Authors.AuthorID;
-- Optimized query
SET profiling = 1;
SELECT * FROM Borrowers WHERE BorrowDate > '2024-01-01';
SHOW PROFILES;

SHOW PROFILE FOR QUERY 2;

-- Compare the profiling results
SHOW PROFILE FOR QUERY 1;  -- Original query
SHOW PROFILE FOR QUERY 2;  -- Optimized query
