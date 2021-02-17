create or replace function f_key_gen return number
as 
    result number;
begin
    result := s_unique_key.nextval;
    return result;
end;
