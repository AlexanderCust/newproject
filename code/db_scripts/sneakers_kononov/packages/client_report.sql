create or replace package client_report
is
    type report_rec is record (full_name varchar2(32),
                               visitings number,
                               month number,
                               sportstype varchar2(32),
                               year number);
    type report_tbl is table of report_rec;
    
    function get_using (f_key number) return report_tbl pipelined;
    
end client_report;
    
create or replace package body client_report
is
    function get_using (f_key number) return report_tbl pipelined
    is
        v_report_row report_rec;
        i number := 1;
    
        cursor c_report
        is 
        select mem.first_name||' '||mem.last_name as full_name,
               mon.visiting_cnt as visitings,
               mon.month,
               spt.name as sportstype,
               mon.year
        from month_progress_agg mon
        join member_dim mem
            on mon.member_uk = mem.uk
        join sportstype_dim spt
            on mon.sportstype_uk = spt.uk
        where mem.uk = f_key;
    begin
        for r in c_report loop
            v_report_row := null;
            i := i + 1;
        
            v_report_row.full_name  := r.full_name;
            v_report_row.visitings  := r.visitings;
            v_report_row.month      := r.month;
            v_report_row.sportstype := r.sportstype;
            v_report_row.year       := r.year;
        
            pipe row (v_report_row);
        end loop;
        return;
        
    end get_using;
    
end client_report;

select*
from table(client_report.get_using(1368));
