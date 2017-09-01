
create or replace function test_sqldf (id integer)
returns int as $$
declare
    a  int;
    b varchar(32);
begin

    create table if not exists tmp(a int, b varchar(32));
    insert into tmp(a, b) values (id, 'abc');
    return 1;

end;
$$ language plpgsql;

