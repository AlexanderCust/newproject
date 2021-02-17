create table country_dim (uk number not null,
                          ccode varchar2(8),
                          name varchar2(32),
                          primary key (uk));

create table city_dim (uk number not null,
                       name varchar2(32),
                       country_uk number not null,
                       primary key (uk),
                       foreign key (country_uk) references country_dim (uk));
                       
create table currency_dim (uk number not null,
                           iso_ncode number not null,
                           ccode varchar2(8),
                           name varchar2(256),
                           primary key (uk));
                           
create table membership_dim (uk number not null,
                             ccode varchar2(1) not null,
                             name varchar2(64),
                             monthly_limit number,
                             cancellation_period number,
                             massage_amt number,
                             ems_amt number,
                             price_rate number not null,
                             primary key (uk));
                             
create table member_dim (uk number not null,
                         first_name varchar2(64),
                         last_name varchar2(64),
                         base_city_uk number not null,
                         membership_uk number not null,
                         primary key (uk),
                         foreign key (base_city_uk) references city_dim (uk),
                         foreign key (membership_uk) references membership_dim (uk));
                         
create table sportstype_dim (uk number not null,
                             name varchar2(256),
                             last_name varchar2(64),
                             least_membership_uk clob not null,
                             primary key (uk));
                             
create table venue_dim (uk number not null,
                        name varchar2(256),
                        city_uk number not null,
                        least_membership_uk number not null,
                        sportstype_uk number not null,
                        primary key (uk),
                        foreign key (city_uk) references city_dim (uk),
                        foreign key (least_membership_uk) references membership_dim (uk),
                        foreign key (sportstype_uk) references sportstype_dim (uk));
                       
create table visiting_fct (member_uk number not null,
                           venue_uk number not null,
                           city_uk number not null,
                           value_day date,
                           standalone_flg varchar2(1),
                           foreign key (member_uk) references member_dim (uk),
                           foreign key (venue_uk) references venue_dim (uk),
                           foreign key (city_uk) references city_dim (uk));
                           
create table transaction_fct (value_day date not null,
                              member_uk number not null,
                              membership_uk number not null,
                              currency_uk number not null,
                              value_amt number not null,
                              foreign key (member_uk) references member_dim (uk),
                              foreign key (membership_uk) references membership_dim (uk),
                              foreign key (currency_uk) references currency_dim (uk));
                              
create table month_progress_agg (member_uk number not null,
                                 sportstype_uk number not null,
                                 visiting_cnt number not null,
                                 month number not null,
                                 year number not null,
                                 foreign key (member_uk) references member_dim (uk),
                                 foreign key (sportstype_uk) references sportstype_dim (uk));

comment on table country_dim is 'Справочник стран';
comment on table city_dim is 'Справочник городов';
comment on table currency_dim is 'Справочник валют';
comment on table membership_dim is 'Справочник программ членства';
comment on table member_dim is 'Справочник клиентов';
comment on table sportstype_dim is 'Справочник спортивных услуг';
comment on table venue_dim is 'Справочник клубов';
comment on table visiting_fct is 'Факты посещения клубов клиентами';
comment on table transaction_fct is 'Факты денежных переводов';
comment on table month_progress_agg is 'Месячный агрегат использования спортивных услуг';

comment on column country_dim.uk is 'Уникальный ключ страны';
comment on column country_dim.ccode is 'Символьный код страны';
comment on column country_dim.name is 'Наименование страны';
comment on column city_dim.uk is 'Уникальный ключ города';
comment on column city_dim.name is 'Наименование города';
comment on column city_dim.country_uk is 'Ссылочный ключ на страну';
comment on column currency_dim.uk is 'Уникальный ключ валюты';
comment on column currency_dim.iso_ncode is 'Числовой ISO код валюты';
comment on column currency_dim.ccode is 'Символьный код валюты';
comment on column currency_dim.name is 'Наименование валюты';
comment on column membership_dim.uk is 'Уникальный ключ программы членства';
comment on column membership_dim.ccode is 'Символьный код программы';
comment on column membership_dim.name is 'Наименование программы';
comment on column membership_dim.monthly_limit is 'Месячный лимит';
comment on column membership_dim.cancellation_period is 'Период работы программы';
comment on column membership_dim.massage_amt is 'Стоимость массажа';
comment on column membership_dim.ems_amt is 'Стоимость EMS вибрационной тренировки';
comment on column membership_dim.price_rate is 'Цена';
comment on column member_dim.uk is 'Уникальный ключ клиента';
comment on column member_dim.first_name is 'Имя';
comment on column member_dim.last_name is 'Фамилия';
comment on column member_dim.base_city_uk is 'Ссылочный ключ на базовый город клиента';
comment on column member_dim.membership_uk is 'Ссылочный ключ на программу клиента';
comment on column sportstype_dim.uk is 'Уникальный ключ спортивной услуги';
comment on column sportstype_dim.name is 'Наименование спортивной услуги';
comment on column sportstype_dim.least_membership_uk is 'Ссылочный ключ на минимальный тип программы с которой доступна спортивная услуга';
comment on column venue_dim.uk is 'Уникальный ключ клуба';
comment on column venue_dim.name is 'Наименование клуба';
comment on column venue_dim.city_uk is 'Ссылочный ключ на город в котором расположен клуб';
comment on column venue_dim.least_membership_uk is 'Ссылочный ключ на минимальный тип программы с которой доступен клуб';
comment on column venue_dim.sportstype_uk is 'Ссылочный ключ на спортивную услугу в этом клубе';
comment on column visiting_fct.member_uk is 'Ссылочный ключ на клиента';
comment on column visiting_fct.venue_uk is 'Ссылочный ключ на клуб';
comment on column visiting_fct.city_uk is 'Ссылочный ключ на город в котором расположен клуб';
comment on column visiting_fct.value_day is 'Дата тренировки';
comment on column visiting_fct.standalone_flg is 'Флаг работы в одиночестве, без тренера';
comment on column transaction_fct.value_day is 'Дата транзакции';
comment on column transaction_fct.member_uk is 'Ссылочный ключ на клиента';
comment on column transaction_fct.membership_uk is 'Ссылочный ключ на программу клиента';
comment on column transaction_fct.currency_uk is 'Ссылочный ключ на валюту';
comment on column transaction_fct.value_amt is 'Сумма выплаты';
comment on column month_progress_agg.member_uk is 'Ссылочный ключ на клиента';
comment on column month_progress_agg.sportstype_uk is 'Ссылочный ключ на спортивную услугу';
comment on column month_progress_agg.visiting_cnt is 'Количество посещений в месяц';
comment on column month_progress_agg.month is 'Номер месяца';
comment on column month_progress_agg.year is 'Номер года';

insert into country_dim (uk,
                         ccode,
                         name) values (f_key_gen,
                                       'RU',
                                       'Russia');
                                       
insert into country_dim (uk,
                         ccode,
                         name) values (f_key_gen,
                                       'IE',
                                       'Ireland');                                       
                                       
insert into country_dim (uk,
                         ccode,
                         name) values (f_key_gen,
                                       'DE',
                                       'Germany');
                                       
insert into country_dim (uk,
                         ccode,
                         name) values (f_key_gen,
                                       'GR',
                                       'Greece');
                                       
insert into country_dim (uk,
                         ccode,
                         name) values (f_key_gen,
                                       'EG',
                                       'Egypt');
                                       
insert into country_dim (uk,
                         ccode,
                         name) values (f_key_gen,
                                       'BY',
                                       'Belarus');                                       
                                       
insert into country_dim (uk,
                         ccode,
                         name) values (f_key_gen,
                                       'YE',
                                       'Yemen');
                                                             

insert into city_dim (uk,
                      name,
                      country_uk) values (f_key_gen,
                                          'Moscow',
                                          1337);
                                          
insert into city_dim (uk,
                      name,
                      country_uk) values (f_key_gen,
                                          'Saint-Petersburg',
                                          1337);
                                          
insert into city_dim (uk,
                      name,
                      country_uk) values (f_key_gen,
                                          'Vorkuta',
                                          1337);
                                          
insert into city_dim (uk,
                      name,
                      country_uk) values (f_key_gen,
                                          'Norilsk',
                                          1337);                                          
                                          
insert into city_dim (uk,
                      name,
                      country_uk) values (f_key_gen,
                                          'Sochi',
                                          1337);
                                          
insert into city_dim (uk,
                      name,
                      country_uk) values (f_key_gen,
                                          'Yekaterinburg',
                                          1337);
                                          
insert into city_dim (uk,
                      name,
                      country_uk) values (f_key_gen,
                                          'Dublin',
                                          1338);                                    



insert into currency_dim (uk,
                          iso_ncode,
                          ccode,
                          name) values (f_key_gen,
                                        643,
                                        'RUB',
                                        'Rubles');
                                        
insert into currency_dim (uk,
                          iso_ncode,
                          ccode,
                          name) values (f_key_gen,
                                        978,
                                        'EUR',
                                        'Euro');
                                        
insert into currency_dim (uk,
                          iso_ncode,
                          ccode,
                          name) values (f_key_gen,
                                        840,
                                        'USD',
                                        'Dollars');
                                        

insert into membership_dim (uk,
                            ccode,
                            name,
                            monthly_limit,
                            cancellation_period,
                            massage_amt,
                            ems_amt,
                            price_rate) values (f_key_gen,
                                                'O',
                                                'One week',
                                                7,
                                                4,
                                                300,
                                                500,
                                                3000);
                                                
insert into membership_dim (uk,
                            ccode,
                            name,
                            monthly_limit,
                            cancellation_period,
                            massage_amt,
                            ems_amt,
                            price_rate) values (f_key_gen,
                                                'O',
                                                'One week',
                                                7,
                                                6,
                                                300,
                                                450,
                                                3500);
insert into membership_dim (uk,
                            ccode,
                            name,
                            monthly_limit,
                            cancellation_period,
                            massage_amt,
                            ems_amt,
                            price_rate) values (f_key_gen,
                                                'T',
                                                'Two weeks',
                                                14,
                                                8,
                                                200,
                                                400,
                                                4000);
insert into membership_dim (uk,
                            ccode,
                            name,
                            monthly_limit,
                            cancellation_period,
                            massage_amt,
                            ems_amt,
                            price_rate) values (f_key_gen,
                                                'T',
                                                'Two weeks',
                                                14,
                                                12,
                                                200,
                                                400,
                                                4500);
insert into membership_dim (uk,
                            ccode,
                            name,
                            monthly_limit,
                            cancellation_period,
                            massage_amt,
                            ems_amt,
                            price_rate) values (f_key_gen,
                                                'F',
                                                'Four weeks',
                                                28,
                                                12,
                                                300,
                                                500,
                                                3000);
insert into membership_dim (uk,
                            ccode,
                            name,
                            monthly_limit,
                            cancellation_period,
                            massage_amt,
                            ems_amt,
                            price_rate) values (f_key_gen,
                                                'F',
                                                'Four weeks',
                                                28,
                                                4,
                                                200,
                                                200,
                                                5000);
insert into membership_dim (uk,
                            ccode,
                            name,
                            monthly_limit,
                            cancellation_period,
                            massage_amt,
                            ems_amt,
                            price_rate) values (f_key_gen,
                                                'F',
                                                'Four weeks',
                                                28,
                                                18,
                                                300,
                                                500,
                                                4000); 
 

insert into member_dim (uk,
                        first_name,
                        last_name,
                        base_city_uk,
                        membership_uk) values (f_key_gen,
                                               'Zofia',
                                               'Ambler',
                                               1346,
                                               1357);
insert into member_dim (uk,
                        first_name,
                        last_name,
                        base_city_uk,
                        membership_uk) values (f_key_gen,
                                               'Jeniffer',
                                               'Brace',
                                               1344,
                                               1358);
insert into member_dim (uk,
                        first_name,
                        last_name,
                        base_city_uk,
                        membership_uk) values (f_key_gen,
                                               'August',
                                               'Darland',
                                               1347,
                                               1359); 
insert into member_dim (uk,
                        first_name,
                        last_name,
                        base_city_uk,
                        membership_uk) values (f_key_gen,
                                               'Jovita',
                                               'Fesler',
                                               1348,
                                               1360);   
insert into member_dim (uk,
                        first_name,
                        last_name,
                        base_city_uk,
                        membership_uk) values (f_key_gen,
                                               'Leland',
                                               'Gales',
                                               1349,
                                               1361);       
insert into member_dim (uk,
                        first_name,
                        last_name,
                        base_city_uk,
                        membership_uk) values (f_key_gen,
                                               'Ranae',
                                               'Lumpkins',
                                               1345,
                                               1362);       
insert into member_dim (uk,
                        first_name,
                        last_name,
                        base_city_uk,
                        membership_uk) values (f_key_gen,
                                               'Stephani',
                                               'Mincy',
                                               1345,
                                               1363);                                               

alter table sportstype_dim drop column last_name;

insert into sportstype_dim (uk,
                            name,
                            least_membership_uk) values (f_key_gen,
                                                         'Gym',
                                                         1357);
insert into sportstype_dim (uk,
                            name,
                            least_membership_uk) values (f_key_gen,
                                                         'Gymnastic',
                                                         1358);
insert into sportstype_dim (uk,
                            name,
                            least_membership_uk) values (f_key_gen,
                                                         'Swimmimg',
                                                         1359);    
insert into sportstype_dim (uk,
                            name,
                            least_membership_uk) values (f_key_gen,
                                                         'Personal training',
                                                         1360);     
insert into sportstype_dim (uk,
                            name,
                            least_membership_uk) values (f_key_gen,
                                                         'Skating',
                                                         1361);  
insert into sportstype_dim (uk,
                            name,
                            least_membership_uk) values (f_key_gen,
                                                         'Powerlifting',
                                                         1362);                                                         
insert into sportstype_dim (uk,
                            name,
                            least_membership_uk) values (f_key_gen,
                                                         'Stretching',
                                                         1363);

update sportstype_dim
set    least_membership_uk = 1357||', '||1359
where uk = 1371;

update sportstype_dim
set    least_membership_uk = 1358||', '||1359
where uk = 1372;

update sportstype_dim
set    least_membership_uk = 1357||', '||1359||', '||1360
where uk = 1373;

update sportstype_dim
set    least_membership_uk = 1361||', '||1362||', '||1363
where uk = 1374;

update sportstype_dim
set    least_membership_uk = 1358||', '||1359||', '||1363
where uk = 1375;

update sportstype_dim
set    least_membership_uk = 1362||', '||1363
where uk = 1376;

update sportstype_dim
set    least_membership_uk = 1357||', '||1360||', '||1361
where uk = 1377;

                                                         
insert into venue_dim (uk,
                       name,
                       city_uk,
                       least_membership_uk,
                       sportstype_uk) values (f_key_gen,
                                              'SS CLUB',
                                              1344,
                                              1357,
                                              1371);
insert into venue_dim (uk,
                       name,
                       city_uk,
                       least_membership_uk,
                       sportstype_uk) values (f_key_gen,
                                              'SUPER PLUS',
                                              1345,
                                              1358,
                                              1372);
insert into venue_dim (uk,
                       name,
                       city_uk,
                       least_membership_uk,
                       sportstype_uk) values (f_key_gen,
                                              'COOL GYM',
                                              1346,
                                              1359,
                                              1373);
insert into venue_dim (uk,
                       name,
                       city_uk,
                       least_membership_uk,
                       sportstype_uk) values (f_key_gen,
                                              'EPIC CLUB',
                                              1347,
                                              1360,
                                              1374);
insert into venue_dim (uk,
                       name,
                       city_uk,
                       least_membership_uk,
                       sportstype_uk) values (f_key_gen,
                                              'PRIME TIME SPORT',
                                              1348,
                                              1361,
                                              1375);
insert into venue_dim (uk,
                       name,
                       city_uk,
                       least_membership_uk,
                       sportstype_uk) values (f_key_gen,
                                              'Classical Sport Club',
                                              1349,
                                              1362,
                                              1376);
insert into venue_dim (uk,
                       name,
                       city_uk,
                       least_membership_uk,
                       sportstype_uk) values (f_key_gen,
                                              'EXTRAGYM',
                                              1350,
                                              1363,
                                              1377);

alter table venue_dim drop column least_membership_uk;

alter table venue_dim add least_membership_uk clob;

update venue_dim
set    least_membership_uk = 1357||', '||1359
where uk = 1397;

update venue_dim
set    least_membership_uk = 1358||', '||1359
where uk = 1398;

update venue_dim
set    least_membership_uk = 1357||', '||1359||', '||1360
where uk = 1399;

update venue_dim
set    least_membership_uk = 1361||', '||1362||', '||1363
where uk = 1400;

update venue_dim
set    least_membership_uk = 1358||', '||1359||', '||1363
where uk = 1401;

update venue_dim
set    least_membership_uk = 1362||', '||1363
where uk = 1402;

update venue_dim
set    least_membership_uk = 1357||', '||1360||', '||1361
where uk = 1403;

alter table venue_dim modify least_membership_uk not null;
                                                    

insert into visiting_fct (member_uk,
                          venue_uk,
                          city_uk,
                          value_day,
                          standalone_flg) values (1364,
                                                  1397,
                                                  1344,
                                                  date'2020-08-04',
                                                  'Y');
insert into visiting_fct (member_uk,
                          venue_uk,
                          city_uk,
                          value_day,
                          standalone_flg) values (1365,
                                                  1398,
                                                  1345,
                                                  date'2020-08-04',
                                                  'N');
insert into visiting_fct (member_uk,
                          venue_uk,
                          city_uk,
                          value_day,
                          standalone_flg) values (1366,
                                                  1399,
                                                  1346,
                                                  date'2020-08-04',
                                                  'N');
insert into visiting_fct (member_uk,
                          venue_uk,
                          city_uk,
                          value_day,
                          standalone_flg) values (1367,
                                                  1400,
                                                  1347,
                                                  date'2020-08-04',
                                                  'N');
insert into visiting_fct (member_uk,
                          venue_uk,
                          city_uk,
                          value_day,
                          standalone_flg) values (1368,
                                                  1401,
                                                  1348,
                                                  date'2020-08-04',
                                                  'N');
insert into visiting_fct (member_uk,
                          venue_uk,
                          city_uk,
                          value_day,
                          standalone_flg) values (1369,
                                                  1402,
                                                  1349,
                                                  date'2020-08-04',
                                                  'N');
insert into visiting_fct (member_uk,
                          venue_uk,
                          city_uk,
                          value_day,
                          standalone_flg) values (1370,
                                                  1403,
                                                  1350,
                                                  date'2020-08-04',
                                                  'N');                                                  
       

insert into transaction_fct (value_day,
                             member_uk,
                             membership_uk,
                             currency_uk,
                             value_amt) values (date'2020-08-20',
                                                1364,
                                                1357,
                                                1351,
                                                5133);
insert into transaction_fct (value_day,
                             member_uk,
                             membership_uk,
                             currency_uk,
                             value_amt) values (date'2020-08-19',
                                                1365,
                                                1358,
                                                1353,
                                                108.9);
insert into transaction_fct (value_day,
                             member_uk,
                             membership_uk,
                             currency_uk,
                             value_amt) values (date'2020-08-04',
                                                1366,
                                                1359,
                                                1351,
                                                8613);
insert into transaction_fct (value_day,
                             member_uk,
                             membership_uk,
                             currency_uk,
                             value_amt) values (date'2020-08-20',
                                                1367,
                                                1360,
                                                1353,
                                                108.9);
insert into transaction_fct (value_day,
                             member_uk,
                             membership_uk,
                             currency_uk,
                             value_amt) values (date'2020-08-21',
                                                1368,
                                                1361,
                                                1352,
                                                99);
insert into transaction_fct (value_day,
                             member_uk,
                             membership_uk,
                             currency_uk,
                             value_amt) values (date'2020-08-12',
                                                1369,
                                                1362,
                                                1351,
                                                5133);
insert into transaction_fct (value_day,
                             member_uk,
                             membership_uk,
                             currency_uk,
                             value_amt) values (date'2020-08-28',
                                                1370,
                                                1363,
                                                1352,
                                                99);                                                
                             

insert into month_progress_agg (member_uk,
                                sportstype_uk,
                                visiting_cnt,
                                month,
                                year) values (1364,
                                              1371,
                                              5,
                                              8,
                                              2020);
insert into month_progress_agg (member_uk,
                                sportstype_uk,
                                visiting_cnt,
                                month,
                                year) values (1365,
                                              1372,
                                              7,
                                              8,
                                              2020);
insert into month_progress_agg (member_uk,
                                sportstype_uk,
                                visiting_cnt,
                                month,
                                year) values (1366,
                                              1373,
                                              2,
                                              8,
                                              2020);
insert into month_progress_agg (member_uk,
                                sportstype_uk,
                                visiting_cnt,
                                month,
                                year) values (1367,
                                              1374,
                                              9,
                                              8,
                                              2020);
insert into month_progress_agg (member_uk,
                                sportstype_uk,
                                visiting_cnt,
                                month,
                                year) values (1368,
                                              1375,
                                              5,
                                              8,
                                              2020);
insert into month_progress_agg (member_uk,
                                sportstype_uk,
                                visiting_cnt,
                                month,
                                year) values (1369,
                                              1376,
                                              11,
                                              8,
                                              2020);
insert into month_progress_agg (member_uk,
                                sportstype_uk,
                                visiting_cnt,
                                month,
                                year) values (1370,
                                              1377,
                                              18,
                                              8,
                                              2020);  
                                               

truncate table visiting_fct;

truncate table transaction_fct;            

create table transactions (first_name varchar2(32),
                           last_name varchar2(32),
                           value_day date,
                           currency_code varchar2(4),
                           membership_code varchar2(4),
                           value_amt number);

create table sk_aggregate_data (first_name varchar2(32),
                                last_name varchar2(32),
                                value_day date,
                                currency_code varchar2(4),
                                value_amt number);
                                
insert into sk_aggregate_data
select mmb.first_name,
       mmb.last_name,
       tct.value_day,
       crc.uk as currency_code,
       tct.value_amt
from transaction_fct tct
join member_dim mmb
    on tct.member_uk = mmb.uk
join currency_dim crc
    on crc.uk = tct.currency_uk;
    
alter table transactions drop column membership_code;    

create table visitings (first_name varchar2(32),
                        last_name varchar2(32),
                        value_day date,
                        city varchar2(32),
                        venue varchar2(32),
                        standalone_flg varchar2(1));

commit;                                         