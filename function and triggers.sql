--select * from [dbo].[Employesss]

-------scalar function------
create function squre(@num int)
returns int
as 
begin
return @num*@num;
end


SELECT dbo.Squre(5) AS SquareResult;

alter function multiply(@num1 int, @num2 int)
returns int
as
begin
return @num1*@num2;
end

select dbo.multiply(25,20) AS SquareResult;

----table valued function--------------

create function getAge(@age int)
returns table
as

return
(select * from Employesss
where age>@age);

select * from dbo.getAge(20)


CREATE TABLE EmployeeAudit (
    AuditID INT IDENTITY PRIMARY KEY,
    EmployeeID INT,
    Action NVARCHAR(50),
    ActionDate DATETIME DEFAULT GETDATE()
);

select * from Employesss where age>30

select * from EmployeeAudit


insert into Employesss (EmployeeID,age) values (135,38)

insert into EmployeeAudit (EmployeeID,Action) 
values (121,'user')

-------insert  trigger-------

create trigger add_insertData ON Employesss
after insert
as 
begin
insert into EmployeeAudit (EmployeeID,Action) 
select EmployeeID,'INSERT' from INSERTED;
end;


-------delete trigger-------------

alter trigger delete_data ON Employesss
after delete

as
begin
delete from employesss
where EmployeeID in (select EmployeeID from deleted)
and age>50;
end;
--------delete and insert those values -------
alter trigger delete_data2 ON Employesss
after delete

as
begin
INSERT INTO EmployeeAudit (EmployeeID,action)
    SELECT EmployeeID ,'delete' FROM DELETED;
end;



--delete from employesss where age=38


--EXEC sp_rename 'EmployeeAudit.newid', 'newidd', 'COLUMN';--rename column anme


alter trigger updateData on Employesss
after update 
as
begin
insert into EmployeeAudit (EmployeeID,newidd)
select d.EmployeeID,i.newidd as newsal from deleted d 
inner join inserted i on d.EmployeeID=i.EmployeeID
end;


update Employesss
set EmployeeID=1210,newidd=00055
where EmployeeID=12100

select * from   EmployeeAudit


alter table EmployeeAudit
add oldsal int
-------function to print age> @ age------

create function findemplyee(@age int )
returns table
as
return
select * from employesss
where age>@age;


select * from  dbo.findemplyee(30)

create view findemplyees as
select EmployeeID,age from Employesss
where age>10

select * from findemplyees

update findemplyees
set age=50
where EmployeeID=125