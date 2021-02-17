create or replace procedure download_agg_data (p_date date)
as 
begin      
    delete sk_aggregate_data 
    where value_day between trunc(p_date, 'mm') and last_day(p_date);
    
    insert into sk_aggregate_data --таблица-агрегат c данными из логической модели
    select first_name,
            last_name,
            value_day,
            currency_code,
            value_amt
    from transactions --таблица с детальными данными из учебных материалов
    where value_day between trunc(p_date, 'mm') and last_day(p_date);
end;

exec download_agg_data(date'2020-08-01');