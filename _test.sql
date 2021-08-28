--
-- TODO: This test must currently be executed manually (for example in SQL Developer)
--

declare
   id integer;
begin
   id := task_mgmt.id('test 01');
   dbms_output.put_line('id = ' || id);

   id := task_mgmt.id('test 02');
   dbms_output.put_line('id = ' || id);

   id := task_mgmt.id('test 01');
   dbms_output.put_line('id = ' || id);

end;
/

begin
   task_mgmt.begin_('test 02');
   log_mgmt.msg('foo');
   log_mgmt.msg('bar');
   log_mgmt.msg('baz');
   task_mgmt.done;
end;
/

select * from task_exec;
select * from task_exec_v;

select * from log_v where cur_ses = 'y';
