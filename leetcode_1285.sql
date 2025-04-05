CREATE TABLE Logs (
    log_id INT PRIMARY KEY
);
INSERT INTO Logs (log_id) VALUES
(1),
(2),
(3),
(7),
(8),
(10);

with cte as (select log_id, row_number() over  (order by log_id) as x  , (log_id -row_number() over  (order by log_id)) as diff from logs)

select min(log_id) as start , max(log_id) as ends from cte
group by diff
