create user sneakers_kononov
    identified by sneakers5242
    default tablespace sysaux
    temporary tablespace temp 
    account unlock;
    
alter user sneakers_kononov quota unlimited on sysaux;

grant create session to sneakers_kononov;

grant create table to sneakers_kononov;

grant create sequence to sneakers_kononov;

grant create view to sneakers_kononov;

grant all PRIVILEGES to sneakers_kononov;
