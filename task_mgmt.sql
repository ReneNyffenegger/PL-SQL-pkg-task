create or replace package task_mgmt as
 --
 -- Version V0.1
 --

    function   id(name varchar2) return integer;

    procedure  begin_(name varchar2); -- return integer;

    function   cur_task return integer;

    procedure  done;
    procedure  exc;

end task_mgmt;
/
