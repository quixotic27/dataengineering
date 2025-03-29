--DDL/DML STATEMENTS

CREATE TABLE Teams (
    team_id INT PRIMARY KEY,
    team_name VARCHAR(100)
);
2. Inserting Data into the Teams Table
sql
Copy
INSERT INTO Teams (team_id, team_name) VALUES
(10, 'Leetcode FC'),
(20, 'NewYork FC'),
(30, 'Atlanta FC'),
(40, 'Chicago FC'),
(50, 'Toronto FC');
3. Creating the Matches Table
sql
Copy
CREATE TABLE Matches (
    match_id INT PRIMARY KEY,
    host_team INT,
    guest_team INT,
    host_goals INT,
    guest_goals INT,
    FOREIGN KEY (host_team) REFERENCES Teams(team_id),
    FOREIGN KEY (guest_team) REFERENCES Teams(team_id)
);
4. Inserting Data into the Matches Table
sql
Copy
INSERT INTO Matches (match_id, host_team, guest_team, host_goals, guest_goals) VALUES
(1, 10, 20, 3, 0),
(2, 30, 10, 2, 2),
(3, 10, 50, 5, 1),
(4, 20, 30, 1, 0),
(5, 50, 30, 1, 0);

--CODE:


with cte1 as (select team_id, team_name, sum(case when host_goals > guest_goals then 3  when host_goals = guest_goals then 1 else 0 end) as num_points from Teams a left join matches b
on a.team_id = b.host_team
group by team_id, team_name)
,

cte2 as (select team_id, team_name, sum(case when guest_goals > host_goals then 3  when host_goals = guest_goals then 1 else 0 end) as num_points from Teams a left join matches b
on a.team_id = b.guest_team
group by team_id, team_name)

select team_id, team_name, sum(num_points)  as num_points from (select * from cte1
union 
select * from cte2) as x
group by team_id, team_name
order by num_points desc, team_id asc
