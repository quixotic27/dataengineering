--select * from friendship



--DDL.DML STATEMENT

CREATE TABLE Friendship (
    user1_id INT,
    user2_id INT,
    PRIMARY KEY (user1_id, user2_id)
);

CREATE TABLE Likes (
    user_id INT,
    page_id INT,
    PRIMARY KEY (user_id, page_id)
);


-- Insert data into Friendship table
INSERT INTO Friendship (user1_id, user2_id)
VALUES
(1, 2),
(1, 3),
(1, 4),
(2, 3),
(2, 4),
(2, 5),
(6, 1);

-- Insert data into Likes table
INSERT INTO Likes (user_id, page_id)
VALUES
(1, 88),
(2, 23),
(3, 24),
(4, 56),
(5, 11),
(6, 33),
(2, 77),
(3, 77),
(6, 88);



select page_id as recommended_page from friendship inner join likes on friendship.user2_id = likes.user_id where user1_id = 1 and page_id not in (select page_id from likes where user_id = 1)
union

select page_id as recommended_page from friendship inner join likes on friendship.user1_id = likes.user_id where user2_id = 1 and page_id not in (select page_id from likes where user_id = 1)
