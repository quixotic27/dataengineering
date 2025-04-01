with  hierarchy as (

select employee_id, employee_name, manager_id, 1 as depth from Employees where employee_id  =1

union all

select e.employee_id, e.employee_name,e.manager_id, c.depth+1 from Employees e
inner join hierarchy as c on e.manager_id = c.employee_id  where c.depth <4) 

select distinct employee_id from hierarchy where employee_id <>1
