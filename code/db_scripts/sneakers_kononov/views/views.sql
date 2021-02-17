create or replace view view_1
as
select distinct
       count(1) pers,
       to_char(to_date(value_day), 'mm') as month
from visitings
group by to_char(to_date(value_day), 'mm');--Количество клиентов по месяцам

create or replace view view_2
as
select distinct
       sum(value_amt) sum_val,
       to_char(to_date(value_day), 'mm') as month
from transactions
group by to_char(to_date(value_day), 'mm');--Сумма выручки по месяцам

create view view_3
as
select count (1) as cnt
from (select distinct
             first_name,
             last_name
      from visitings);--Всего подключенных партнеров 
      
create view view_4
as
select city,
       count(1) cnt
from (select distinct
       city,
       first_name||' '||last_name full_name
from visitings)
group by city;--Список партнеров по городам
