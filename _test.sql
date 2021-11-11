--
-- TODO: This test must currently be executed manually (for example in SQL Developer)
--

declare
   id integer;
begin
   id := plsql_pkg_owner.task_mgmt.id('test 01');
   dbms_output.put_line('id = ' || id);

   id := plsql_pkg_owner.task_mgmt.id('test 02');
   dbms_output.put_line('id = ' || id);

   id := plsql_pkg_owner.task_mgmt.id('test 01');
   dbms_output.put_line('id = ' || id);

end;
/

begin
   plsql_pkg_owner.task_mgmt.begin_('test 02');
   plsql_pkg_owner.log_mgmt.msg('foo');
   plsql_pkg_owner.log_mgmt.msg('bar');
   plsql_pkg_owner.log_mgmt.msg('baz');
   plsql_pkg_owner.task_mgmt.done;
end;
/

select * from plsql_pkg_owner.task_exec;
select * from plsql_pkg_owner.task_exec_v;

select * from plsql_pkg_owner.log_v where cur_ses = 'y';