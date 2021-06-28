create or replace package body task_mgmt as
 --
 -- V0.1
 --

    cur_task_ integer;

    function id(name varchar2) return integer is -- {
        pragma autonomous_transaction;
        ret  integer;
    begin

        select t.id into ret
        from
           task t
        where
           t.name = id.name;

        return ret;

    exception when no_data_found then
        insert into task(name) values (id.name) returning id into ret;
        commit;
        return ret;

    end id; -- }

    procedure begin_(name varchar2) is -- {
       pragma autonomous_transaction;
    begin

       if cur_task_ is not null then
          raise_application_error(-20800, 'cannot start task if another thas is not finished');
       end if;

       insert into task_exec(start_, task_id, ses_id) values (sysdate, id(name), ses_mgmt.id) returning id into cur_task_;
       commit;

    end begin_; -- }

    procedure done is -- {
    begin

       if cur_task_ is null then
          raise_application_error(-20800, 'cur_task_ is null');
       end if;

       update task_exec t set end_ = sysdate where t.id = cur_task_;
       commit;

       ses_mgmt.ping;
       cur_task_ := null;
    end done; -- }

    function cur_task return integer is -- {
    begin
       return cur_task_;
    end cur_task; -- }

    procedure exc_(err varchar2) is -- {
       pragma autonomous_transaction;
    begin
       update task_exec t set
           t.end_ = sysdate,
           t.err  = exc_.err
        where
           t.id = cur_task_;

        commit;
    end exc_; -- }

    procedure exc is -- {
       sqlerrm_  varchar2(500) := sqlerrm;
       sqlcode_  integer       := sqlcode;
    begin

       if cur_task_ is null then
          raise_application_error(-20800, 'cur_task_ is null');
       end if;

       exc_(sqlerrm_);
       rollback;

       ses_mgmt.ping;
       cur_task_ := null;

       if sqlcode_ != -06508 then -- : PL/SQL: could not find program unit being called
          raise_application_error(-20800, 'task ended because of ' || sqlerrm_);
       end if;

    end exc; -- }

end task_mgmt;
/
